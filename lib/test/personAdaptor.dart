import 'package:flutter_application_1/test/person.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Personadaptor extends TypeAdapter<Person> {
  @override
  Person read(BinaryReader reader) {
    return Person(
        age: reader.readInt(),
        name: reader.readString(),
        frineds: reader.readByteList().cast());
  }

  @override
  // uniqe 0 to 233
  int get typeId => 0;

  @override
  void write(BinaryWriter writer, Person obj) {
  writer.writeInt(obj.age);
  writer.writeString(obj.name);
  writer.writeList(obj.frineds);
  }
}
