import 'package:flutter/material.dart';
import 'package:my_object_box/main.dart';
import 'package:my_object_box/person.dart';

class AddOrUpdatePerson extends StatelessWidget {
  final Person? person;
  AddOrUpdatePerson({required this.person, super.key});
  final nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (person != null) {
      nameController.text = person!.name;
    }
    return Scaffold(
      appBar: AppBar(
        title: person == null
            ? const Text('Add Person')
            : const Text('Update Person'),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              width: 300,
              child: TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  label: Text('Enter Name'),
                ),
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                if (person == null) {
                  myObjectBox.insertPerson(Person(name: nameController.text));
                } else {
                  myObjectBox.updatePerson(
                      Person(id: person!.id, name: nameController.text));
                }
                Navigator.pop(context);
              },
              child: person == null ? const Text('Add') : const Text('Update'),
            ),
          ],
        ),
      ),
    );
  }
}
