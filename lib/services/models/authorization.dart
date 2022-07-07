import 'package:isar/isar.dart';

part 'authorization.g.dart';

@Collection()
class Authorization {
  @Id()
  int? id;

  late String tokenType;
  late String accessToken;
}
