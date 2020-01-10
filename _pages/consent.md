---
layout: single
title: Consent
permalink: /consent
toc: true
---

## Creating the Consent Document Model
### Consent Document Content

First you have to create your consent document model using Research Package classes.

As a first step you have to create the sections which your Consent Document ([RPConsentDocument](https://pub.dev/documentation/research_package/latest/research_package_model/RPConsentDocument-class.html)) will contain. Research Package provides 8 pre defined section ([RPConsentSectionType]()) type with corresponding images and animation and a "Custom" option to build you own:
* Overview,
* DataGathering,
* Privacy,
* DataUse,
* TimeCommitment,
* StudyTasks,
* StudySurvey,
* Withdrawing,
* Custom

> You will see that `.withParams` or `.withIdentifier` constructors are being used. This is needed because of the JSON serialization which requires an empty constructor for all the classes eligible for serialization.

To create a section just instantiate [RPConsentSection]() with a type and then specify the summary (short text under the title) and the content which can be accessed after tapping on the "Learn more" button). The `content` attribute is very important because at the end the user has to agree to all sections `content` field.

``` dart
RPConsentSection overviewSection = RPConsentSection.withParams(RPConsentSectionType.Overview)
..summary = "Welcome to this survey"
..content = "Overview dolor sit amet, consectetur adipiscing elit.";

RPConsentSection dataGatheringSection = RPConsentSection.withParams(RPConsentSectionType.DataGathering)
..summary = "This is a summary for Data Gathering."
..content = "Data Gathering dolor sit amet, consectetur adipiscing elit.";
```
A consent document in Research Package is represented by [RPConsentDocument](https://pub.dev/documentation/research_package/latest/research_package_model/RPConsentDocument-class.html). Create one by specifying the Title and the previously created sections.
``` dart
RPConsentDocument myConsentDocument = RPConsentDocument.withParams("Title", [overviewSection, dataGatheringSection]);
```
### Collecting a Consent Signature

An important part of obtaining the consent document is collecting signatures. Research Package comes with a built-in support for that.

First, you have to specify the signature you want to collect by creating a [RPConsentSignature](https://pub.dev/documentation/research_package/latest/research_package_model/RPConsentSignature-class.html) object with a unique id. The default one collects the user's full name and an image of their signature.

As the next step you have to add this previously created signature to your consent document.

``` dart
RPConsentSignature mySignature = RPConsentSignature.withIdentifier("uniqueSignatureID");

myConsentDocument.addSignature(mySignature);
```

### The Consent Task

As stated in [About Research Package](1.-About-Research-Package) page, Research Package uses Task as its core organizational unit. An [RPOrderedTask](https://pub.dev/documentation/research_package/latest/research_package_model/RPOrderedTask-class.html) is a sequence of steps where the sequence can not be changed.

To create a Consent Task you need two steps:
- [RPVisualConsentStep](https://pub.dev/documentation/research_package/latest/research_package_model/RPVisualConsentStep-class.html), which is responsible to guide the user through the different content sections in the Consent Document
- [RPReviewConsentStep](https://pub.dev/documentation/research_package/latest/research_package_model/RPConsentReviewStep-class.html), which is responsible to present the whole Consent Document to the user for review and then collect the signature.

Create these two steps! Both of them need a Consent Document object which they will be connected to.

``` dart
RPVisualConsentStep consentVisualStep = RPVisualConsentStep("visualStepID", myConsentDocument);

RPConsentReviewStep consentReviewStep = RPConsentReviewStep("consentReviewstepID", myConsentDocument)
..reasonForConsent = "By tapping AGREE you can take part in the study"
..text = "Agreed?"
..title = "Consent Review Step Title";
```

Optionally, you can also add a Completion Step where you can thank the user for joining the study or communicate some other information. To do so, you have to create an [RPCompletionStep]().

``` dart
RPCompletionStep completionStep = RPCompletionStep("completionStepID")
  ..title = "Thank You!"
  ..text = "We saved your consent document";
```

Now that you have all the needed steps, you can create the Task for obtaining the consent. To do so you have to create an [RPOrderedTask](https://pub.dev/documentation/research_package/latest/research_package_model/RPOrderedTask-class.html) with a unique string identifier and the list of previously created steps.

``` dart
RPOrderedTask consentTask = RPOrderedTask("consentTaskID", [consentVisualStep, consentReviewStep, completionStep]);
```

## Presenting the Task

The next step is to present the Consent Task. To achieve this you have to use the UI library of Research Package.

The [RPUIOrderedTask](https://pub.dev/documentation/research_package/latest/research_package_ui/RPUIOrderedTask-class.html) class will automatically present the task based on the Step objects in the Task object. It also gives you the possibility to gather the results which is the signature in this case. 

This widget returns a full screen [Scaffold](https://docs.flutter.io/flutter/material/Scaffold-class.html) widget so the recommended usage is to create a route which returns an [RPUIOrderedTask](https://pub.dev/documentation/research_package/latest/research_package_ui/RPUIOrderedTask-class.html) and then navigate to this route. The minimum example is the following:

``` dart
class ConsentDocumentTaskRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RPUIOrderedTask(
      task: consentTask,
      onSubmit: () {} // Collecting results, see next section
    );
  }
}
```

## Collecting results

Gathering the results from a task is made possible by passing a callback function to the [RPUIOrderedTask](https://pub.dev/documentation/research_package/latest/research_package_ui/RPUIOrderedTask-class.html) widget's onSubmit input parameter. The onSubmit event is triggered when the user has finished with the last step in the the list of steps passed to the Task object.

**To learn more about the result objects and their structure visit the [corresponding page](https://github.com/cph-cachet/research.package/wiki/2.-Software-Architecture#results-hierarchy).**

You should create a function which needs an input parameter with [RPTaskResult](https://pub.dev/documentation/research_package/latest/research_package_model/RPTaskResult-class.html) type. A minimum example is the following:

``` dart
void resultCallback(RPTaskResult result) {
   // Do whatever you want with the result
   // In this case we are just printing the result's keys
   print(result.results.keys);
}
```

After creating the function you just have to pass it to the Task widget when creating. This changes the build function of our example above to the following:

``` dart
@override
Widget build(BuildContext context) {
   return RPUIOrderedTask(
      task: task,
      onSubmit: resultCallback,
   );
}
```