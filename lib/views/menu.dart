import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:altid/src/service.dart';

Widget build() {
  return Drawer(
    child: Consumer<Services>(
      builder: (context, service, child) {
        return ListView(
          children: [
            const ListTile(
              contentPadding: EdgeInsets.only(left: 20, top: 5),
              title: Text('Manage Services'),
              subtitle: Text('Long press a service to delete'),
            ),
            const Divider(),
            ...service.services.map(
              (e) => Column(
                // If e.connected show ExpansionTile
                children: <Widget>[
                  if (e.status == 'connected') ...[
                    Card(
                      margin: const EdgeInsets.all(5),
                      elevation: 5,
                      child: ExpansionTile(
                        title: Text(e.service),
                        initiallyExpanded: true,
                        children: [
                          ...e.buffers.map(
                            (b) => ListTile(
                              title: Text(b.name),
                              onTap: () {
                                Navigator.pushNamed(context, '/service/buffer', arguments: {e, b});
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ] else if (e.status == 'connecting') ...[
                    Card(
                      margin: const EdgeInsets.all(5),
                      elevation: 2,
                      child: ListTile(
                        title: Text(e.service),
                        trailing: const CircularProgressIndicator(
                          strokeWidth: 2,
                        ),
                      ),
                    ),
                  ] else ...[
                    Card(
                      margin: const EdgeInsets.all(5),
                      elevation: 4,
                      child: ListTile(
                        title: Text(e.service),
                        // Check if service is connected and show/gray out with checkmark
                        trailing: const Icon(Icons.connected_tv),
                        onTap: () {
                          // Connect to service flow
                          service.connect(e);
                        },
                        // Show modal to confirm deletions
                        onLongPress: () { confirmDelete(context, service, e); },
                      ),
                    ),
                  ],
                ],
              ),
            ),
            Card(
              margin: const EdgeInsets.all(5),
              elevation: 3,
              child: ListTile(
                title: const Text('Add service',
                    style: TextStyle(color: Colors.white)),
                trailing: const Icon(Icons.add),
                tileColor: Colors.blueGrey.shade700,
                iconColor: Colors.white,
                onTap: () {
                  Navigator.pushNamed(context, '/service/create');
                },
              ),
            ),
          ], // children
        );
      },
    ),
  );
}

confirmDelete(BuildContext context, Services service, Service e) {
  Widget cancelButton = TextButton(
    child: const Text("Cancel"),
    onPressed: () {
      Navigator.pop(context);
    },
  );

  Widget continueButton = TextButton(
    child: const Text("Continue"),
    onPressed: () {
      service.delete(e);
      Navigator.pop(context);
    },
  );
  AlertDialog alert = AlertDialog(
    title: const Text('Confirm delete'),
    content: const Text('Delete the selected service?'),
    actions: [
      cancelButton,
      continueButton,
    ],
  );
  
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    }
  );
}
