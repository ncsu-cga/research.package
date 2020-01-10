---
layout: single
title: About
permalink: /about-research-package
toc: true
---

## Naming
We are following the pattern from Apple's Research Kit's when it comes to naming. There's a prefix ORK (Open Research Kit) before the names of classes, types etc. Following that the class names are starting with the `RP` prefix which stands for Research Package.

For UI widgets we are using the `RPUI` (Research Package UI) prefix.

## Limitations

Research Package supports only single choice, multiple choice and integer questions at the moment.

Furthermore, as of yet, only Ordered Task is available meaning that branching and navigating between steps and questions are not possible. 

Nonetheless, we are constantly working on the package so these features are also coming in the feature alongside more type of questions.

## How to set up a Research Package project

Since Research Package is published to pub, in order to use it just add it to your `pubspec.yaml` file.

```dart
  dependencies:
     research_package: ^0.1.0
```

After you run `flutter packages get` command you are able to import and start using Research Package. 
You can import the whole package including the Model and UI libraries:

```dart
import 'package:research_package/research_package.dart';
```

Or with the following lines you can decide which library of the package you want to gain access to:

``` dart
import 'package:research_package/model.dart';
import 'package:research_package/ui.dart';
```

> Note that objects starting with `RP` are part of the Model (e.g. `RPConsentDocument`) while those which start with `RPUI` are part of the UI library (e.g. `RPUIVisualConsentStep`).

## Style and UI Theme

Research Package is accessing the parent application's style through Flutter's `context` feature. This means that the given `Theme` of the application is shared also with Research Package and appears in its styling (colors, font styles...). As an example have a look at the example application where the Theme colors of the parent application are set to different colors.

On how to Theme your application see the following article by the Flutter team: https://flutter.dev/docs/cookbook/design/themes