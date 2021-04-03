class Report {
  final String address;
  final String city;
  final DateTime dateTime;
  final List<String> offences;

  Report({this.address, this.city, this.dateTime, this.offences = const []});
}
