class ContactInformation {
  final String address;
  final String fullName;

  ContactInformation({this.address, this.fullName});

  Map<String, String> toMap() {
    return {"address": address, "fullName": fullName};
  }

  static ContactInformation fromMap(Map<String, Object> data) {
    return ContactInformation(
        address: data['address'], fullName: data['fullName']);
  }
}
