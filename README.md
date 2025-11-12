<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages).
-->

A small library with a few classes and functions that a corresponding app takes
advantage of.

### Configuration

Before using this package, you need to configure your secrets:

1. Copy `lib/src/secrets.dart.template` to `lib/src/secrets.dart`
2. Fill in your actual Google service account credentials and API keys
3. Make sure `secrets.dart` is included in your `.gitignore` file

The secrets file should contain:
- Google service account credentials JSON
- Google Sheets spreadsheet ID
- Google Apps Script deployment path

You'll need that google account to have a sheet there fitting the schema expected
here. If anyone does need that then get in touch.

