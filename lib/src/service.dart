import 'package:flutter/foundation.dart';
import 'dart:collection';
import 'package:altid/src/buffer.dart';
import 'package:multicast_dns/multicast_dns.dart';

class Service {
  final String address;
  final String service;
  String status = '';
  List<Buffer> buffers = [];

  Service (
    this.address,
    this.service,
  );

  void write(String line) {
    print(line);
  }
}

class Services extends ChangeNotifier {
  final Set<Service> _services = {};
  UnmodifiableListView<Service> get services => UnmodifiableListView(_services);

  void add(Service service) {
    // Avoid duplicates found from mDNS
    if (services.any((key) => service.service == key.service)) {
      return;
    }
    
    _services.add(service);
    notifyListeners();
  }

  void delete(Service service) {
    _services.remove(service);
    notifyListeners();
  }

  // Show login modal?
  Future<void> connect(Service service) async {
    service.status = 'connecting';
    notifyListeners();
    
    service.buffers.add(Buffer('buffer1'));
    service.buffers.add(Buffer('buffer2'));
    service.buffers.add(Buffer('buffer3'));
    
    // After, we push to connected
    await Future.delayed(const Duration(seconds: 2), (){
      service.status = 'connected';
      notifyListeners();
    });
  }

  void clear() {
    _services.clear();
    notifyListeners();
  }

  // Make sure we populate the services list
  Services() {
    _search();
  }

  Future<void> _search() async {
    const String name = '_altid._tcp.local';
    final MDnsClient client = MDnsClient();
    await client.start();
    await for (final PtrResourceRecord ptr in client
        .lookup<PtrResourceRecord>(ResourceRecordQuery.serverPointer(name))) {
      await for (final SrvResourceRecord srv in client.lookup<SrvResourceRecord>(
      ResourceRecordQuery.service(ptr.domainName))) {
        final String svcName = ptr.domainName.substring(0, ptr.domainName.indexOf('._'));
        final String address = '${srv.target}:${srv.port}';
        final svc = Service(address, svcName);
        add(svc);
      }
    }
    client.stop();
  }
}
