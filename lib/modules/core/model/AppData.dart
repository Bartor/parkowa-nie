import 'package:hive/hive.dart';

part 'AppData.g.dart';

@HiveType(typeId: 3)
class AppData {
  @HiveField(0)
  final String currentCity;

  AppData({this.currentCity});
}
