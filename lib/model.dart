import 'package:hive/hive.dart';

part 'model2.dart';

@HiveType(typeId: 0)
class TodoModel {
  @HiveField(0)
  String description;

  @HiveField(1)
  bool isDone;

  TodoModel({required this.description, this.isDone = false});
}
