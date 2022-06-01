import 'dart:async';
import 'package:multicast_dns/multicast_dns.dart';

class Service {
  final String address;
  final String service;

  const Service(
    this.address,
    this.service,
  );
}

class ListEntriesService { 
  final items = StreamController<Service>();

  Future<void> search(Set<Service> services) async {
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
        // Make sure we only list unique services
        if (services.any((key) => svcName == key.service)) {
          continue;
        }
        services.add(svc);
        items.add(svc);
      }
    }
    client.stop();
  }
}