import 'package:hive/hive.dart';


void main() async {
  // Hive.init('somePath');
  //
  // var box = await Hive.openBox('testBox');
  //
  // box.put('name', 'David');
  //
  // print('Name: ${box.get('name')}');
  //var path = Directory.current.path;

  Hive
    ..init('somePath')
    ..registerAdapter(UserAdapter());

  var box = await Hive.openBox<User>('userBox');

  box.put('david', User('David'));
  box.put('sandy', User('Sandy'));

  print(box.values);
}

class User {
  String name;

  User(this.name);

  @override
  String toString() => name; // Just for print()
}

// Can be generated automatically
class UserAdapter extends TypeAdapter<User> {
  @override
  final typeId = 0;

  @override
  User read(BinaryReader reader) {
    return User(reader.read());
  }

  @override
  void write(BinaryWriter writer, User obj) {
    writer.write(obj.name);
  }
}