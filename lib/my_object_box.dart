import 'package:my_object_box/objectbox.g.dart';
import 'package:my_object_box/person.dart';

class MyObjectBox {
  late Box<Person> persons;

  MyObjectBox._create(store) {
    persons = Box<Person>(store);
  }

  static Future<MyObjectBox> create() async {
    var store = await openStore();
    return MyObjectBox._create(store);
  }

  Stream<List<Person>> getAllPersons() =>
      persons.query().watch(triggerImmediately: true).map(
            (event) => event.find(),
          );

  Person? getPerson(id) => persons.get(id);

  int? insertPerson(Person person) => persons.put(person);

  int? updatePerson(Person person) => persons.put(person, mode: PutMode.update);

  bool? deletePerson(id) => persons.remove(id);
}
