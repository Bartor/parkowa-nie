import 'package:hive/hive.dart';

part 'ContactInformation.g.dart';

@HiveType(typeId: 0)
class ContactInformation {
  @HiveField(0)
  final String address;
  @HiveField(1)
  final String fullName;

  ContactInformation({this.address, this.fullName});
}
