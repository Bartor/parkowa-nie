import 'package:i18n_extension/i18n_extension.dart';
import 'package:parkowa_nie/modules/core/model/Offence.dart';

class I18n {
  static var _uiTranslations = Translations("en") +
      {
        "en": "No licence plate",
        "pl": "Brak tablicy rejestracyjnej",
      } +
      {"en": "Add new report", "pl": "Dodaj nowe zgłoszenie"} +
      {"en": "No historic data", "pl": "Brak poprzednich zgłoszeń"} +
      {"en": "Select photo source", "pl": "Wybierz źródło zdjęcia"} +
      {"en": "Camera", "pl": "Aparat"} +
      {"en": "Gallery", "pl": "Galeria"} +
      {"en": "Add a photo", "pl": "Dodaj zdjęcie"} +
      {"en": "City", "pl": "Miasto"} +
      {"en": "Street name", "pl": "Ulica"} +
      {"en": "License plate", "pl": "Tablica rejestracyjna"} +
      {"en": "Save", "pl": "Zapisz"} +
      {"en": "Edit", "pl": "Edytuj"} +
      {"en": "Parking report", "pl": "Zgłoszenie nieprawidłowego parkowania"} +
      {"en": "There was an error", "pl": "Wystąpił błąd"} +
      {"en": "Send", "pl": "Wyślij"} +
      {"en": "Info updated", "pl": "Zaktualizowano informacje"} +
      {"en": "Contact information", "pl": "Informacje kontaktowe"} +
      {
        "en":
            "This information will be attached to emails sent to city officials to allow them to contact you afterwars. Make sure they are accurate!",
        "pl":
            "Te dane będą dołączane do wiadomości do Straży Miejskiej, aby umożliwić im kontakt w sprawie zgłoszeń. Upewnij się, że są poprawne!"
      } +
      {"en": "Full name", "pl": "Imię i nazwisko"} +
      {"en": "Address information", "pl": "Adres"} +
      {"en": "Licence plate", "pl": "Tablica rejestracyjna"} +
      {"en": "Date & time", "pl": "Data i godzina"} +
      {"en": "Address", "pl": "Adres"};

  static var _offenceTranslations = Translations.from('en', {
    OffenceType.NO_ENOUGH_SIDEWALK_SPACE: {
      "en": "Less than 1.5 m of available space on sidewalk",
      "pl": "Nie pozostawiono 1.5 metra wolnego miejsca na chodniku"
    },
    OffenceType.NO_PARKING_ZONE: {
      "en": "Parking in restricted area",
      "pl": "Parkowanie na zakazie parkowania"
    },
    OffenceType.NO_STOPPING_SING: {
      "en": "Parking after no stopping sign",
      "pl": "Parkowanie na zakazie zatrzymywania się"
    },
    OffenceType.TOO_CLOSE_TO_CROSSING: {
      "en": "Parking less than 10 meters from pedestrian crossing",
      "pl": "Parkowanie poniżej 10 metrów od przejścia dla pieszych"
    },
    OffenceType.TOO_CLOSE_TO_INTERSECTION: {
      "en": "Parking less than 10 meters from crossing",
      "pl": "Parkowanie poniżej 10 metrów od skrzyżowania"
    }
  });

  static var translations = _uiTranslations * _offenceTranslations;
}

extension Localization on String {
  String get i18n => localize(this, I18n.translations);
}
