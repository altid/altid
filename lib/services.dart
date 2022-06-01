import 'package:flutter/material.dart';
import 'services/list_entries_service.dart';

class ServicesWidget extends StatefulWidget {
  const ServicesWidget(Key? key) : super(key: key);

  @override
  _ServicesState createState() => _ServicesState();
}

class _ServicesState extends State {
  late Stream<Service> _stream;
  var services = <Service>{};

  @override
  void initState() {
    final entries = ListEntriesService();
    _stream = entries.items.stream;
    entries.search(services);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select service(s)'),
      ),
      body: StreamBuilder<Service>(
        stream: _stream,
        builder: (context, state) {
          if (!state.hasData) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                ]
              ),
            );
          }
          // Show spinner until done
          return Container(
            constraints: BoxConstraints(minWidth: 100, maxWidth: 300),
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.blue,
            ), 
            child: ListView(
              children: [
                ...services.map(
                  (e) => Column(
                    children: <Widget>[
                      Card(
                        margin: EdgeInsets.all(5),
                        elevation: 5,
                        child: ListTile(
                          title: Text(e.service),
                          // Check if service is connected and show/gray out with checkmark
                          trailing: Icon(Icons.add),
                          onTap: () {
                            // Connect to service flow
                            print(e.address);
                          }
                          ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      )
    );
  }
}