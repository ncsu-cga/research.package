---
layout: single
title: Consent
permalink: /consent
toc: true
---

## Creating the Consent Document Model
### Consent Document Content

First you have to create your consent document model using the ResearchPackage classes.

First, the sections of the consent document ([RPConsentDocument](https://pub.dev/documentation/research_package/latest/research_package_model/RPConsentDocument-class.html)) has to be created.
ResearchPackage provides eigth predefined sections types with corresponding images and animations, plus a "Custom" option to build you own:

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

To create a section just instantiate [`RPConsentSection`](https://pub.dev/documentation/research_package/latest/research_package_model/RPConsentSection-class.html) with a type and then specify the summary (short text under the title) and the content which can be accessed after tapping on the "Learn more" button). 
The `content` attribute is core pievce of information to be shown to the user. In the end of the consent flow, the user has to agree to what is stated in each section's `content` field.

``` dart
RPConsentSection overviewSection = RPConsentSection.withParams(RPConsentSectionType.Overview)
..summary = "Welcome to this survey"
..content = "Overview dolor sit amet, consectetur adipiscing elit.";

RPConsentSection dataGatheringSection = RPConsentSection.withParams(RPConsentSectionType.DataGathering)
..summary = "This is a summary for Data Gathering."
..content = "Data Gathering dolor sit amet, consectetur adipiscing elit.";
```
A consent document in ResearchPackage is represented by [`RPConsentDocument`](https://pub.dev/documentation/research_package/latest/research_package_model/RPConsentDocument-class.html). 
Create one by specifying the title and the previously created sections.

``` dart
RPConsentDocument myConsentDocument = RPConsentDocument.withParams("Title", [overviewSection, dataGatheringSection]);
```
### Collecting a Consent Signature

An important part of obtaining the consent document is collecting the signature from the study participant. 
ResearchPackage comes with a built-in support for this.

First, you have to specify the signature you want to collect by creating a [`RPConsentSignature`](https://pub.dev/documentation/research_package/latest/research_package_model/RPConsentSignature-class.html) object with a unique id. The default one collects the user's full name and an image of the user's signature.

Then this the signature must be added to the consent document, as shown below:

``` dart
RPConsentSignature mySignature = RPConsentSignature.withIdentifier("uniqueSignatureID");

myConsentDocument.addSignature(mySignature);
```

### The Consent Task

As described in the [architecture](software-architecture), ResearchPackage uses a task as its core organizational unit. 
A [RPOrderedTask](https://pub.dev/documentation/research_package/latest/research_package_model/RPOrderedTask-class.html) is a sequence of steps where the sequence can not be changed.

To create a consent task you need two steps:

- [`RPVisualConsentStep`](https://pub.dev/documentation/research_package/latest/research_package_model/RPVisualConsentStep-class.html), which is responsible to guide the user through the different content sections in the consent document
- [`RPReviewConsentStep`](https://pub.dev/documentation/research_package/latest/research_package_model/RPConsentReviewStep-class.html), which is responsible to present the whole consent document to the user for review and then collect the signature.

An example of how these two steps are created is shown below:

``` dart
RPVisualConsentStep consentVisualStep = RPVisualConsentStep("visualStepID", myConsentDocument);

RPConsentReviewStep consentReviewStep = RPConsentReviewStep("consentReviewstepID", myConsentDocument)
..reasonForConsent = "By tapping AGREE you can take part in the study"
..text = "Agreed?"
..title = "Consent Review Step Title";
```

Optionally, you can also add a completion step in which you thank the user for joining the study or communicate some other information. This is done by creating a [`RPCompletionStep`](https://pub.dev/documentation/research_package/latest/research_package_model/RPCompletionStep-class.html).

``` dart
RPCompletionStep completionStep = RPCompletionStep("completionStepID")
  ..title = "Thank You!"
  ..text = "We saved your consent document";
```

Now that you have all the needed steps, these can be combined into an overal task for obtaining the consent. 
This is done by creating a [`RPOrderedTask`](https://pub.dev/documentation/research_package/latest/research_package_model/RPOrderedTask-class.html) with a unique string identifier and the list of the previously defined steps.

``` dart
RPOrderedTask consentTask = RPOrderedTask("consentTaskID", [consentVisualStep, consentReviewStep, completionStep]);
```

## Presenting the Task

The next step is to present the consent task. 
This is done using the UI library of ResearchPackage.

The [`RPUIOrderedTask`](https://pub.dev/documentation/research_package/latest/research_package_ui/RPUIOrderedTask-class.html) class will automatically present the task based on each step objects in the task. It also gives you the possibility to gather the results which is the signature in this case. 

This widget returns a full screen [`Scaffold`](https://docs.flutter.io/flutter/material/Scaffold-class.html) widget.
Therefore the recommended usage is to create a route which returns an [`RPUIOrderedTask](https://pub.dev/documentation/research_package/latest/research_package_ui/RPUIOrderedTask-class.html) and then navigate to this route. The minimum example is the following:
This widget returns a full screen [`Scaffold`](https://docs.flutter.io/flutter/material/Scaffold-class.html) widget. so the recommended usage is to create a route which returns an [RPUIOrderedTask`](https://pub.dev/documentation/research_package/latest/research_package_ui/RPUIOrderedTask-class.html) and then navigate to this route. The minimum example is the following:
This widget returns a full screen [`Scaffold`](https://docs.flutter.io/flutter/material/Scaffold-class.html) widget. so the recommended usage is to create a route which returns an [RPUIOrderedTask](https://pub.dev/documentation/research_package/latest/research_package_ui/RPUIOrderedTask-class.html) and then navigate to this route. The minimum example is the following:

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
