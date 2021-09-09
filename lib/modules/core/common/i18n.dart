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
      {"en": "Address", "pl": "Adres"};

  static var _offenceTranslations = Translations.from('en', {
    OffenceType.NO_ENOUGH_SIDEWALK_SPACE.toString(): {
      "en": "Less than 1.5 m of available space on sidewalk",
      "pl": "Nie pozostawiono 1.5 metra wolnego miejsca na chodniku"
    },
    OffenceType.NO_STOPPING_SING.toString(): {
      "en": "Parking after no stopping sign",
      "pl": "Postój na zakazie zatrzymywania się"
    },
    OffenceType.TOO_CLOSE_TO_CROSSING.toString(): {
      "en": "Parking less than 10 meters from pedestrian crossing",
      "pl": "Postój poniżej 10 metrów od przejścia dla pieszych"
    },
    OffenceType.TOO_CLOSE_TO_INTERSECTION.toString(): {
      "en": "Parking less than 10 meters from crossing",
      "pl": "Postój poniżej 10 metrów od skrzyżowania"
    },
    OffenceType.PARKED_ON_GREEN_AREA.toString(): {
      "en": "Parking on green area",
      "pl": "Postój na terenie zielonym"
    },
    OffenceType.AWAY_FROM_THE_EDGE_OF_THE_ROAD.toString(): {
      "en": "Parking on sidewalk away from the edge of the road",
      "pl": "Postój na chodniku z dala od krawędzi jezdni"
    },
    OffenceType.TOO_CLOSE_TO_BUS_TRAM_STOP.toString(): {
      "en": "Parking less than 15 meters from public transport stop",
      "pl":
          "Postój poniżej 15 metrów od przystanku lub na terenie zatoce autobusowej"
    },
    OffenceType.TOO_HEAVY.toString(): {
      "en":
          "Vehilce with permissible gross weight greater than 2.5 t parked on sidewalk",
      "pl":
          "Pojazd pojadem o dopuszczalnej masie całkowitej powyżej 2.5 t na chodniku"
    },
    OffenceType.RESIDENCE_ZONE.toString(): {
      "en": "Parking outside of designated parking place in a residence zone",
      "pl": "Postój poza wyznaczonym miejscem w strefie zamieszakania"
    },
    OffenceType.NO_DRIVING.toString(): {
      "en": "Not obeying no driving sign",
      "pl": "Nieprzestrzeganie znaku zakazu ruchu"
    },
    OffenceType.INCORRECT_PARKING.toString(): {
      "en": "Not obeying the parking signs",
      "pl":
          "Niezastosowanie się do miejsc wyznaczonych znakami poziomymi lub pionowymi"
    },
    OffenceType.PARKING_ON_BIKE_LANE.toString(): {
      "en": "Parking on a bike lane",
      "pl": "Postój na pasie ruchu/drodze dla rowerowów"
    },
  });

  static var translations = _uiTranslations * _offenceTranslations;
}

extension Localization on String {
  String get i18n => localize(this, I18n.translations);
}
