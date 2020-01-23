---
layout: single
title: Software Architecture
permalink: /software-architecture
toc: true
---

This tutotial describes the overall software architecture of ResearchPackage and its API, and how to get started.

## API Naming and Architecture

### API Naming
We are following the pattern from Apple's Research Kit's when it comes to naming. ResearchKit uses the prefix `ORK` (Open Research Kit) before the names of classes, types etc. Following this naming model, the the class names in ResearchPackage starts a `RP` prefix. UI widgets uses the `RPUI` (Research Package UI) prefix.

> Note that objects starting with `RP` are part of the Model (e.g. `RPConsentDocument`) while those which start with `RPUI` are part of the UI library (e.g. `RPUIVisualConsentStep`).

### Data Flow

Research Package uses streams and regular callbacks for internal communication (e.g. between Task and Steps). 
There is a BLoC file responsible for the communication between the Task and the Steps it's containing ([BlocTask](https://pub.dev/documentation/research_package/latest/research_package_model/BlocTask-class.html)). The communication between the Question Container and their Question Body is made possible by regular callback functions.

### Bloc

ResearchPackage follows the [BLoC architecture](https://medium.com/flutterpub/architecting-your-flutter-project-bd04e144a8f1),
which is recommended by the [Flutter Team](https://www.youtube.com/watch?v=PLHln7wHgPE).
In ResearchPackage, the [BlocTask](https://pub.dev/documentation/research_package/latest/research_package_model/BlocTask-class.html) is holding the StreamControllers needed for the communication.

### Results

There are steps which can produce [RPStepResult]() e.g. [RPQuestionStep]() or [RPConsentReviewStep](). The task widget [RPUIOrderedTask]() collects these Step Results as the user is proceeding through the task in order to create the [RPTaskResult]() which is accessible by passing a callback function to the Task widget's `onSubmit` property.

Both of the task and step result objects are collection results which means that they can contain other results (e.g. the task result holds the array of step results).

Every result ([RPResult]()) has an identifier which connects it to the task or step which produced it. The identifier of the result is identical to the identifier of its task or step.

Also results have a `startDate` and `endDate` property. Based on that the time spent on the given task/step/question can be calculated. (Some results for example [RPSignatureResult]() doesn't have its `startDate` filled out. In that case only the `endDate` is relevant which in this case is the exact time of the signature.)

The result hierarchy corresponds closely to the hierarchy of the building model of tasks and steps.

Here you can see an example figure and the actual hierarchy of a result collected after a survey task:

<img src="https://raw.githubusercontent.com/cph-cachet/research.package/master/documentation/images/survey_result_hierarchy_figure.png" height="150">

<img src="https://raw.githubusercontent.com/cph-cachet/research.package/master/documentation/images/survey_result_hierarchy_screenshot.png" height="600">

Here you can see an example figure and the actual hierarchy of a result collected after a consent document task:

<img src="https://raw.githubusercontent.com/cph-cachet/research.package/master/documentation/images/signature_result_hierarchy_figure.png" height="300"> 
<img src="https://raw.githubusercontent.com/cph-cachet/research.package/master/documentation/images/signature_result_hierarchy_screenshot.png" height="600">

## Style and UI Theme

Research Package is accessing the parent application's style through Flutter's `context` feature. This means that the given `Theme` of the application is shared also with Research Package and appears in its styling (colors, font styles...). As an example have a look at the [example application](https://github.com/cph-cachet/research.package/tree/master/example/research_package_demo_app) where the theme colors of the parent application are modified.

See [this article by the Flutter team](https://flutter.dev/docs/cookbook/design/themes) on how to Theme your application.


## How to set up a Research Package project

Since Research Package is [published to `pub.dev](https://pub.dev/packages/research_package), all you have to do is to add its dependency to your `pubspec.yaml` file.

```dart
  dependencies:
     research_package: ^0.1.0
```

After you run the `flutter packages get` command, you are able to import and start using ResearchPackage. 
You can import the whole package including the Model and UI libraries:

```dart
import 'package:research_package/research_package.dart';
```

Or with the following lines you can decide which library of the package you want to gain access to:

``` dart
import 'package:research_package/model.dart';
import 'package:research_package/ui.dart';
```

## Limitations

Research Package currently supports only a few [answer formats](answer-formats) which can be put on the separate pages or combined in one page (using a `FormStep`).
Moreover, currently only `OrderedTask` is available meaning that branching and navigating between steps and questions are not supported (yet). 

Nonetheless, we are constantly working on the package so these features, as well as more type of questions will be implemeted in the future.
