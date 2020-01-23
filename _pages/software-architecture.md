---
layout: single
title: Software Architecture
permalink: /software-architecture
toc: true
---

This tutotial describes the overall software architecture of ResearchPackage and its API, and how to get started.

## API and Architecture

### API Naming
We are following the pattern from Apple's Research Kit's when it comes to naming. ResearchKit uses the prefix `ORK` (Open Research Kit) before the names of classes, types etc. Following this naming model, the class names in ResearchPackage starts a `RP` prefix. UI widgets uses the `RPUI` (Research Package UI) prefix.

> Note that objects starting with `RP` are part of the Model (e.g. `RPConsentDocument`) while those which start with `RPUI` are part of the UI library (e.g. `RPUIVisualConsentStep`).


### Main Domain Model

Overall, ResearchPackage uses a `Task` to represent the survey containing a list of `Step`s, which each returns a `Result`.
In the API, the task is an [`RPOrderedTask`](https://pub.dev/documentation/research_package/latest/research_package_model/RPOrderedTask-class.html) object and the steps are [`RPQuestionStep`](https://pub.dev/documentation/research_package/latest/research_package_model/RPQuestionStep-class.html) objects. 
Results are saved as [`RPTaskResult`](https://pub.dev/documentation/research_package/latest/research_package_model/RPTaskResult-class.html) objects.

Below is an example of a hierarchy with a task, three steps, each with a specific answer type.

<img src="https://raw.githubusercontent.com/cph-cachet/research.package/master/documentation/images/survey_result_hierarchy_figure.png" height="150">

### BLoC Architecture

ResearchPackage follows the [BLoC architecture](https://medium.com/flutterpub/architecting-your-flutter-project-bd04e144a8f1),
which is recommended by the [Flutter Team](https://www.youtube.com/watch?v=PLHln7wHgPE).
In ResearchPackage, the [BlocTask](https://pub.dev/documentation/research_package/latest/research_package_model/BlocTask-class.html) is holding the StreamControllers needed for the communication.

Following the BLoC architecture, ResearchPackage uses streams and callbacks for internal communication (e.g. between Task and Steps). 
There is a BLoC class responsible for the communication between the task and the steps it's containing ([BlocTask](https://pub.dev/documentation/research_package/latest/research_package_model/BlocTask-class.html)). Communication between the question container and their question body is made possible via callback functions.


## Style and UI Theme

Research Package is accessing the parent application's style through Flutter's `context` feature. This means that the given `Theme` of the application is shared also with Research Package and appears in its styling (colors, font styles...). 
As an example, the [example application](https://github.com/cph-cachet/research.package/tree/master/example/research_package_demo_app) shows how the theme colors of the parent application are modified, and this is refelcted in the ResearchPackage screens.

See [this article by the Flutter team](https://flutter.dev/docs/cookbook/design/themes) on how to Theme your application.


## How to set up a ResearchPackage project

Research Package is [published to `pub.dev`](https://pub.dev/packages/research_package) and all you have to do is to add its dependency to your `pubspec.yaml` file.

```dart
  dependencies:
     research_package: ^0.1.0
```

After you run the `flutter packages get` command, you are able to import and start using ResearchPackage. 
You can import the whole package including the Model and UI libraries:

```dart
import 'package:research_package/research_package.dart';
```

Or you can decide which library of the package you want to use:

``` dart
import 'package:research_package/model.dart';
import 'package:research_package/ui.dart';
```

## Limitations

Research Package currently supports only a few [answer formats](answer-formats) which can be put on separate pages or combined in one page (using a `FormStep`).
Moreover, currently only `OrderedTask` is available meaning that branching and navigating between steps and questions are not supported (yet). 

Nonetheless, we are constantly working on the package so these features, as well as more type of questions will be implemeted in the future.
