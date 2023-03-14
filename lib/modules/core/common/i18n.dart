import 'package:i18n_extension/i18n_extension.dart';
import 'package:parkowa_nie/modules/core/model/Offense.dart';

class I18n {
  static var _uiTranslations = Translations("en") +
      {
        "en": "No license plate",
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
      {"en": "Do you want to cancel?", "pl": "Czy chcesz przerwać?"} +
      {"en": "Yes", "pl": "Tak"} +
      {"en": "No", "pl": "Nie"} +
      {"en": "No offences", "pl": "Brak wykroczeń"} +
      {"en": "Unknown city", "pl": "Nieznane miasto"} +
      {
        "en":
            "We don't have this city's email address in the database. Do you want to put it in manually?",
        "pl":
            "Nie posiadamy adresu mailowego dla tego miasta. Chcesz kontynuować i podać go ręcznie?"
      } +
      {"en": "No photos", "pl": "Brak zdjęć"} +
      {"en": "Missing info", "pl": "Brakujące informacje"} +
      {
        "en":
            "You haven't set your contact information. Do you want to set it now?",
        "pl":
            "Nie uzupełniono informacji kontaktowych. Czy chcesz zrobić to teraz?"
      } +
      {
        "en": "Couldn't get current location",
        "pl": "Nie udało się zlokalizować"
      } +
      {"en": "Cannot be empty", "pl": "Należy wypełnić"} +
      {"en": "Could not take an image", "pl": "Nie udało się zrobić zdjęcia"} +
      {"en": "Could not pick an image", "pl": "Nie udało się wybrać zdjęcia"} +
      {"en": "Image saved to gallery", "pl": "Zdjęcie zapisane w galerii"} +
      {"en": "Address", "pl": "Adres"} +
      {"en": "Reports total", "pl": "Zgłoszeń łącznie"} +
      {"en": "Show only not yet sent?", "pl": "Pokaż tylko niewysłane"} +
      {
        "en": "All reports already sent!",
        "pl": "Wszystkie zgłoszenia wysłane!"
      } +
      {"en": "Reports sent", "pl": "Wysłanych zgłoszeń"};

  static var _offenceTranslations = Translations.from('en', {
    OffenseType.NO_ENOUGH_SIDEWALK_SPACE.toString(): {
      "en": "Less than 1.5 m of available space on sidewalk",
      "pl": "Nie pozostawiono 1.5 metra wolnego miejsca na chodniku"
    },
    OffenseType.NO_STOPPING_SING.toString(): {
      "en": "Parking after no stopping sign",
      "pl": "Postój za znakiem zakazu zatrzymywania się"
    },
    OffenseType.TOO_CLOSE_TO_CROSSING.toString(): {
      "en": "Parking less than 10 meters from pedestrian crossing",
      "pl": "Postój poniżej 10 metrów od przejścia dla pieszych"
    },
    OffenseType.TOO_CLOSE_TO_INTERSECTION.toString(): {
      "en": "Parking less than 10 meters from crossing",
      "pl": "Postój poniżej 10 metrów od skrzyżowania"
    },
    OffenseType.PARKED_ON_GREEN_AREA.toString(): {
      "en": "Parking on green area",
      "pl": "Postój na terenie zielonym"
    },
    OffenseType.AWAY_FROM_THE_EDGE_OF_THE_ROAD.toString(): {
      "en": "Parking on sidewalk away from the edge of the road",
      "pl": "Postój na chodniku z dala od krawędzi jezdni"
    },
    OffenseType.TOO_CLOSE_TO_BUS_TRAM_STOP.toString(): {
      "en": "Parking less than 15 meters from public transport stop",
      "pl":
          "Postój poniżej 15 metrów od przystanku lub na terenie zatoki autobusowej"
    },
    OffenseType.TOO_HEAVY.toString(): {
      "en":
          "Vehilce with permissible gross weight greater than 2.5 t parked on sidewalk",
      "pl":
          "Postój pojadem o dopuszczalnej masie całkowitej powyżej 2.5 t na chodniku"
    },
    OffenseType.RESIDENCE_ZONE.toString(): {
      "en": "Parking outside of designated parking place in a residence zone",
      "pl": "Postój poza wyznaczonym miejscem w strefie zamieszakania"
    },
    OffenseType.NO_DRIVING.toString(): {
      "en": "Not obeying no driving sign",
      "pl": "Nieprzestrzeganie znaku zakazu ruchu"
    },
    OffenseType.INCORRECT_PARKING.toString(): {
      "en": "Not obeying the parking signs",
      "pl":
          "Niezastosowanie się do miejsc wyznaczonych znakami poziomymi lub pionowymi"
    },
    OffenseType.PARKING_ON_BIKE_LANE.toString(): {
      "en": "Parking on a bike lane",
      "pl": "Postój na pasie ruchu/drodze dla rowerowów"
    },
  });

  static var translations = _uiTranslations * _offenceTranslations;
}

extension Localization on String {
  String get i18n => localize(this, I18n.translations);
}
