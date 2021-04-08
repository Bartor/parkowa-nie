import 'package:slugify/slugify.dart';

final _cityEmailAdrresses = {
  slugify("Wrocław"): "interwencje@strazmiejska.wroclaw.pl"
};

String getCityEmail({String city}) {
  return _cityEmailAdrresses[slugify(city)];
}
