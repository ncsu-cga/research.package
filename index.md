---
layout: single
#title: Welcome to ResearchPackage
---

#Welcome to ResearchPackage

ResearchPackage is a Flutter [package](https://pub.dartlang.org/packages/research_package) for building research study apps on Android and iOS using [Flutter](https://flutter.dev).

ResearchPackage is a Flutter implementation of the [Apple ResearchKit](https://www.researchandcare.org/researchkit/) available for iOS (just like  [ResearchStack](http://researchstack.org/)). The overarching goal of ResearchPackage is to enable developers and researchers to design and build cross-platform (iOS and Android) research applications using the same codebase. The API and UX design of ResearchPackage follows the API and UX of ResearchKit almost 1:1 (with a few adaptations to Flutter, including applying more to a reactive programming model).

ResearchPackage is designed from the ground up to meet the requirements of most scientific research, including capturing participant consent, extensible input tasks, and the security and privacy needs necessary for IRB approval. 
The main features of ResearchPackage are:

- [Obtaining informed consent](consent) from participants, including support for a signature.
- [Creating surveys](survey) and questionnaires with a wide range of answer formats (e.g., likert scale, date pickers, image pickers, etc.)

ResearchPackage is part of the overall CACHET Research Platform (CARP) with also provides a Flutter package for mobile and wearable sensing -- called [CARP Mobile Sensing](https://pub.dev/packages/carp_mobile_sensing). By combining ResearchPackage with CARP Mobile Sensing, support for what is called ["Active Tasks"](https://www.researchandcare.org/researchkit/) in ResearchKit can be implemented.






- Survey - [How it's done in ResearchKit](http://researchkit.org/docs/docs/Survey/CreatingSurveys.html) - Implemented in RP
- Active Task - [How it's done in ResearchKit](http://researchkit.org/docs/docs/ActiveTasks/ActiveTasks.html) - Can be implemented later with the help of flutter [plugins](https://github.com/cph-cachet/flutter-plugins) by CACHET.





[![pub package](https://img.shields.io/pub/v/research_package.svg)](https://pub.dartlang.org/packages/research_package)



Research Package is a Flutter package for creating surveys and obtaining informed consent containing models, UI elements and screens. 
The motivation is coming from two similar native libraries [ResearchStack](http://researchstack.org/) on Android and [ResearchKit](http://researchkit.org/) on iOS.

The main modules of the above mentioned libraries are which are also the main features of Research Package:
- Consent - [How it's done in ResearchKit](http://researchkit.org/docs/docs/InformedConsent/InformedConsent.html) - Implemented in RP
- Survey - [How it's done in ResearchKit](http://researchkit.org/docs/docs/Survey/CreatingSurveys.html) - Implemented in RP
- Active Task - [How it's done in ResearchKit](http://researchkit.org/docs/docs/ActiveTasks/ActiveTasks.html) - Can be implemented later with the help of flutter [plugins](https://github.com/cph-cachet/flutter-plugins) by CACHET.

To find out more visit [Research Package's website](https://www.researchpackage.org).
  
## Getting Started

Research Package is published to Pub: [![pub package](https://img.shields.io/pub/v/research_package.svg)](https://pub.dartlang.org/packages/research_package) 

You can start using it by adding it to your dependencies.

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

Remember, that objects starting with `RP` are part of the Model (like `RPConsentDocument`) while those which start with `RPUI` are part of the UI library (like `RPUIVisualConsentStep`).

## Documentation

Visit the website of the project at [researchpackage.org](https://www.researchpackage.org) for more information and tutorials.

You can find the API documentation generated for pub [here](https://pub.dev/documentation/research_package/latest/).

## Example application

To get an overview of Research Package's features have a look at the example application [here](https://pub.dev/packages/research_package#-example-tab-).

## Similarity to ResearchKit and ResearchStack

Research Package is clearly similar to these two existent framework. A goal with the package was to help developers enjoy the same features with Flutter's cross-platform framework. 
The names, functionalities and most of the logic are similar or identical to the previously mentioned two framework. This way we believe that the transition for those who have used them before will be easier and smoother.

## Current stage

The project is work in progress. New Answer Formats are being added to the survey module of the framework constanly. 
The available Answer Formats are the following at the moment:
- Single Choice
- Multiple Choice
- Integer

## Use Cases

One of the goals for the package was to make it capable of handling a [WHO5](https://www.psykiatri-regionh.dk/who-5/Documents/WHO5_English.pdf) survey. As an example at this point Research Package can obtain the informed consent from the participant, show the WHO5 survey questions and collect the results.

## Who is backing this project?

Research Package is made by [CACHET - Copenhagen Center for Health Technology](http://www.cachet.dk/).

## How can I contribute?

We are more than happy to take contributions and feedback. Use the [Issues](https://github.com/cph-cachet/research.package/issues) page to file an issue or feature request.

## Useful Links
In order to familiarize with the framework and potentially extend it, it might worth to have a look at these links about Research Kit and Research Stack.  

- ResearchKit
  - [Official Tutorial on how to use ResearchKit in ObjectiveC](http://researchkit.org/docs/docs/Survey/CreatingSurveys.html)
You can get a good understading of the flow and the basic concepts.
Also there's a useful presentation of the different AnswerFormats.
  - [Hierarchy of objects in ResearchKit](http://researchkit.org/docs/hierarchy.html)
This is a good representation of a possible file/class hierarchy for ResearchPackage.
  - [Tutorial on how to use ResearchKit in Swift](https://www.raywenderlich.com/1820-researchkit-tutorial-with-swift-getting-started)
  - [Sample Apps for ResearchKit in Swift](https://github.com/ResearchKit/ResearchKit/tree/master/samples)

- ResearchStack
  - [Sample App for ResearchStack](https://github.com/ResearchStack/SampleApp)
  - [Tutorial on how to use ResearchStack in Java](https://www.raywenderlich.com/637-researchstack-tutorial-getting-started)

