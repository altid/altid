import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:altid/src/service.dart';

class CreateWidget extends StatelessWidget {
  const CreateWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add a Service'),
      ),
      body: const AddServiceWidget(),
    );
  }
}

class AddServiceWidget extends StatefulWidget {
  const AddServiceWidget({super.key});

  @override
  ServiceFormState createState() {
    return ServiceFormState();
  }
}

class ServiceFormState extends State<AddServiceWidget> {
  final _formKey = GlobalKey<FormState>();
  String address = '';
  String svcname = '';

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8),
              child: TextFormField(
                onSaved: (value) {
                  svcname = value!;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter service name';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Name',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: TextFormField(
                onSaved: (value) {
                   address = value!;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an address';
                  }
                  if (! Uri.parse(value).isAbsolute) {
                    return 'Please enter a valid address';
                  }
                },
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'URL'
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: Consumer<Services>(
                builder: (context, service, child) {
                  return ElevatedButton(
                    onPressed: () {
                      // Validate returns true if the form is valid, or false otherwise.
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState?.save();
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Added service')),
                        );
                        service.add(Service(address, svcname));
                        Navigator.pop(context);
                      }
                    },
                    child: const Text('Submit'),
                  );
                },
              ),
            ),
          ],
        ));
  }
}
