import 'package:slugify/slugify.dart';

final _cityEmailAdrresses = {
  slugify("Wrocław"): "interwencje@strazmiejska.wroclaw.pl",
  slugify("Poznań"): "kancelaria@smmp.pl",
  slugify("Katowice"): "interwencje@katowice.eu",
  slugify("Opole"): "dyzurny@strazmiejska.opole.pl"
};

String getCityEmail({String city}) {
  return _cityEmailAdrresses[slugify(city)];
}
