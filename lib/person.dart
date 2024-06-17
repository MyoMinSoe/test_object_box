import 'package:objectbox/objectbox.dart';

@Entity()
class Person {
  int id;
  String name;
  Person({this.id = 0, required this.name});
}
