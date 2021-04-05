import 'package:slugify/slugify.dart';

final _cityEmailAdrresses = {
  slugify("Częstochowa"): "test@example.com",
  slugify("Wrocław"): "straz@strazmiejska.wroclaw.pl"
};

String getCityEmail({String city}) {
  return _cityEmailAdrresses[slugify(city)];
}
