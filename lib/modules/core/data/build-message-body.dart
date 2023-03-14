import 'package:i18n_extension/i18n_extension.dart';
import 'package:parkowa_nie/modules/core/common/format-date.dart';
import 'package:parkowa_nie/modules/core/model/ContactInformation.dart';
import 'package:parkowa_nie/modules/core/model/Report.dart';
import 'package:parkowa_nie/modules/core/common/i18n.dart';

String buildMessageBody({Report report, ContactInformation contactInfo}) {
  final buffer = StringBuffer();

  buffer.write(
      "Dzień dobry,\nChciałbym zgłosić nieprawidłowe parkowanie pod adresem ${report.address}, ${report.city}. Pojazd o rejestracji ${report.licensePlate} parkował tam ${formatDate(report.dateTime)}.");

  if (report.offenses.isNotEmpty) {
    buffer.write(" Kierujący popełnił następujące wykroczenia:\n");
    for (var offence in report.offenses) {
      buffer.write("- ${localize(offence, I18n.translations, locale: "pl")}\n");
    }
  }

  if (contactInfo != null) {
    buffer.write(
        "\nDane zgłąszającego:\n${contactInfo.fullName}\n${contactInfo.address}");
  }

  return buffer.toString();
}
