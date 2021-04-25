# parkowaNIE

An app which helps you in reporting illegal parking! It allows you to take a photo, choose offences, locate you automatically and generate a ready-to-send email in your email app!

### Supported cities

- Katowice
- Opole
- Poznań
- Wrocław

If you are aware of any other cities in Poland that support email reporting, please consider adding those by creating a pull request and editing file [cities.json](./assets/cities.json). This file is added to the app bundle and then loaded, as well fetched every time the app opens, so the user has the newest version of the list regardless their installed app version.

## Requirements

- Flutter (stable) 2.0.5

## Development

Remember to run `flutter packages pub run build_runner build` after modifying `@HiveType` annotated objects to generate Adapters for Hive.
