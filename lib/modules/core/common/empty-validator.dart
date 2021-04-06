import 'package:parkowa_nie/modules/core/common/i18n.dart';

String emptyValidator(String value) {
  if (value.trim().isEmpty) {
    return "Cannot be empty".i18n;
  }
  return null;
}
