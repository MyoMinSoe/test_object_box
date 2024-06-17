import 'package:flutter/material.dart';
import 'package:my_object_box/add_or_update_person.dart';
import 'package:my_object_box/my_object_box.dart';
import 'package:my_object_box/person.dart';

late MyObjectBox myObjectBox;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  myObjectBox = await MyObjectBox.create();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Material App',
      home: Home(),
    );
  }
}

class Home extends StatelessWidget {
  const Home({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Material App Bar'),
      ),
      body: StreamBuilder<List<Person>>(
        stream: myObjectBox.getAllPersons(),
        builder: (context, snapshot) {
          return !snapshot.hasData
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return snapshot.data!.isEmpty
                        ? const Center(
                            child: Text('No Data'),
                          )
                        : ListTile(
                            title: Text(snapshot.data![index].name),
                            subtitle: Text(
                                'Id - ${snapshot.data![index].id.toString()}'),
                            trailing: SizedBox(
                              width: 100,
                              child: Row(
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (c) => AddOrUpdatePerson(
                                            person: snapshot.data![index],
                                          ),
                                        ),
                                      );
                                    },
                                    icon: const Icon(Icons.edit),
                                  ),
                                  IconButton(
                                      onPressed: () {
                                        myObjectBox.deletePerson(
                                            snapshot.data![index].id);
                                      },
                                      icon: const Icon(Icons.delete))
                                ],
                              ),
                            ),
                          );
                  },
                );
        },
      ),
      floatingActionButton: IconButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (c) => AddOrUpdatePerson(person: null),
            ),
          );
        },
        icon: const Icon(
          Icons.add_circle,
          size: 50,
        ),
      ),
    );
  }
}
