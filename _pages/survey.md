---
layout: single
title: Survey
permalink: /survey
toc: true
---

> ## Attention
> Research Package supports only a limited set of answer formats at the moment. 
single choice, multiple choice, integer, slider, date time, image choice) This tutorial is limited to present some of these scenarios and giving an introduction on how to combine them into one question (Form step).
For all the available answer formats please see the [list of available Answer Formats](/answer-formats)!

Creating surveys is on of Research Package main modules (besides obtaining informed consent). This tutorial will guide you through how to create the needed domain model objects for a survey task, how to present it on the UI, how to combine different questions on one screen and finally how to collect the results.

## Creating Model Objects

As usual, Research Package uses a Task to represent the survey containing the Steps. In this case the Task object will be an [RPOrderedTask]() object and the steps which it holds are [RPQuestionStep](https://pub.dev/documentation/research_package/latest/research_package_model/RPQuestionStep-class.html) objects. (With optional [RPInstructionStep](https://pub.dev/documentation/research_package/latest/research_package_model/RPInstructionStep-class.html) at the beginning and [RPCompletionStep](https://pub.dev/documentation/research_package/latest/research_package_model/RPCompletionStep-class.html) at the end)

> Later, you will see that `.withParams` constructors are being used. This is needed because of the JSON serialization which requires an empty constructor for all the classes eligible for serialization.

### Creating steps
#### Instruction Step
You can present instructions to the user, put them to context or show footnotes with the [RPInstructionStep](https://pub.dev/documentation/research_package/latest/research_package_model/RPInstructionStep-class.html). An Instruction Step is useful any time you want to provide some instruction for the user at the beginning or during a survey.
Here's how you can create one:

``` dart
RPInstructionStep instructionStep = RPInstructionStep(
    identifier: "instructionID",
    title: "Instructions",
    detailText:
        "Example: If you have felt cheerful and in good spirits more than half of the time during the last two weeks, put a tick in the box with the number 3 in the upper right corner.",
    footnote: "(1) Important footnote")
  ..text =
      "Please indicate for each of the five statements which is closest to how you have been feeling over the last two weeks. Notice that higher numbers mean better well-being.";
```

#### QuestionStep 
Let's create an actual Question Step. An [RPQuestionStep](https://pub.dev/documentation/research_package/latest/research_package_model/RPQuestionStep-class.html) is a generic step that needs a child of [RPAnswerFormat](https://pub.dev/documentation/research_package/latest/research_package_model/RPAnswerFormat-class.html) on which depends what kind of question will the step present.

You can create as many question steps as you desire.

Let's have a look at the available Answer Formats in Research Package.

##### Single Choice

In order to create the question step we have to set up the answer format first with a list of choices ([RPChoice](https://pub.dev/documentation/research_package/latest/research_package_model/RPChoice-class.html)) and the answer style. An `RPChoice` has a text which will be presented to the participant and a value which can be used for other purposes. When saving the result both of the fields will be saved.

The UI representation of this Answer Format looks like this:

<img src="https://raw.githubusercontent.com/cph-cachet/research.package/master/documentation/images/AnswerFormats/SingleChoiceAnswerFormat.png" width="300">

Here's how to create a single choice answer format: 

``` dart
// First create the list of choices
List<RPChoice> choices = [
  RPChoice.withParams("All of the time", 5),
  RPChoice.withParams("Most of the time", 4),
  RPChoice.withParams("More than half of the time", 3),
  RPChoice.withParams("Less than half of the time", 2),
  RPChoice.withParams("Some of the time", 1),
  RPChoice.withParams("At no time", 0),
];
```

After that the choices can be passed to the constructor of a choice Answer Format:

``` dart
// Pass the list of choices to the answer format constructor
RPChoiceAnswerFormat choiceAnswerFormat = RPChoiceAnswerFormat.withParams(ChoiceAnswerStyle.SingleChoice, choices);
```

A single choice question format allows the user to pick one single element from a previously created set of options. The easiest way to create this step is by using the `.withAnswerFormat` constructor as the following:

``` dart
RPQuestionStep choiceQuestionStep = RPQuestionStep.withAnswerFormat(
  "questionStep1ID",
  "I have felt cheerful and in good spirits",
  choiceAnswerFormat,
);
```
##### Multiple Choice

The Multiple Choice question is similar to the Single Choice with the difference that the participant is allowed to choose more than one option from the presented choices.

The UI representation of this Answer Format looks like this (see that the small hint text below the Title has changed indicating that the participant is allowed to choose more options as well):

<img src="https://raw.githubusercontent.com/cph-cachet/research.package/master/documentation/images/AnswerFormats/MultipleChoiceAnswerFormat.png" width="300">

The creation of a Question Step like that is similar to the Single Choice Answer Format presented above. First the [RPChoice](https://pub.dev/documentation/research_package/latest/research_package_model/RPChoice-class.html) objects need to be created and then passed to the the constructor of the [RPChoiceAnswerFormat](https://pub.dev/documentation/research_package/latest/research_package_model/RPChoiceAnswerFormat-class.html) used with the Multiple Choice [ChoiceAnswerStyle](https://pub.dev/documentation/research_package/latest/research_package_model/ChoiceAnswerStyle-class.html) like this: 

```dart
// Pass the list of choices to the answer format constructor
RPChoiceAnswerFormat choiceAnswerFormat = RPChoiceAnswerFormat.withParams(ChoiceAnswerStyle.MultipleChoice, choices);
```
##### Integer

With the Integer question the participants can enter a number between previously set upper and lower limit. As help a suffix can be also specified indicating for example the unit of the number (e.g. minutes, age...).

The UI representation of this Answer Format looks like the following:

<img src="https://raw.githubusercontent.com/cph-cachet/research.package/master/documentation/images/AnswerFormats/IntegerAnswerFormat.png" width="300">

First, the RPIntegerAnswerFormat needs to be instantiated by giving the constructor the lower limit, the upper limit and the suffix.

```dart
RPIntegerAnswerFormat weightIntegerAnswerFormat = RPIntegerAnswerFormat.withParams(0, 200, "KG");
```

Research Package will check if the input is an actual number and between the limits and lets the participant proceed only if these conditions suffice.

#### Form Step

There are situation when it's beneficial to show multiple questions on the same page as one logical block. For these needs you can use Form Step ([RPFormStep](https://pub.dev/documentation/research_package/latest/research_package_model/RPFormStep-class.html)). A Form Step consists of multiple [RPQuestionStep](https://pub.dev/documentation/research_package/latest/research_package_model/RPQuestionStep-class.html)s. (_Read more about it by clicking the links which brings you to the official API documentation_).

The Form Step is showing the Question Steps as a scrollable list. On the UI it looks like this:

<img src="https://raw.githubusercontent.com/cph-cachet/research.package/master/documentation/images/AnswerFormats/FormAnswerFormat.png" width="300">

The creation process of a Form Step works as the following:

First, create the Question Steps to show on the page:

```dart
// This is a Question Step with a Multiple Choice Answer Format. See how to create it above
RPQuestionStep instrumentChoiceQuestionStep =
RPQuestionStep.withAnswerFormat("instrumentChoiceQuestionStepID", "Which instrument are you playing?", instrumentsAnswerFormat);

// This is a Question Step with Integer Answer Format. See how to create it above
RPQuestionStep minutesQuestionStep =
RPQuestionStep.withAnswerFormat("minutesQuestionStepID", "How many minutes do you spend practicing a week?", minutesIntegerAnswerFormat);
```

Then, after the Question Steps are created add them to the constructor of a Form Step as a list.

```dart
RPFormStep formStep = RPFormStep.withTitle("formstepID",[instrumentChoiceQuestionStep, minutesQuestionStep], "Questions about music");
```

> **What Answer Format does the Form Step has?**
> As every Question Step, a Form Step also needs an Answer Format. Since it has multiple questions embedded it would be difficult to figure out which Answer Format to use. To solve this Research Package has a special Answer Format, the [RPFormAnswerFormat](https://pub.dev/documentation/research_package/latest/research_package_model/RPFormAnswerFormat-class.html). Since a Form Step can only take this specific Answer Format you don't have to give it to it. Research Package sets the corresponding value automatically as part of the constructor.

#### Completion Step
Although it's not obligatory, creating a Completion Step and appending it to the list of steps is a good idea because we can assure the user that we saved the result and the survey is over. Here's how to create an [RPCompletionStep]():

``` dart
RPCompletionStep completionStep = RPCompletionStep("completionStepID")
  ..title = "Thank You!"
  ..text = "The survey is over and we saved your result";
```
## The Survey Task

Now that you have all the needed steps, you can create the Task for the survey. To do so you have to create an [RPOrderedTask]() with a unique string identifier and the list of previously created steps.

``` dart
RPOrderedTask surveyTask = RPOrderedTask("surveyTaskID", [consentVisualStep, choiceQuestionStep, completionStep]);
```

## Presenting the Task

The next step is to present the Survey Task (`surveyTask`). To achieve this you have to use the UI library of Research Package.

The [RPUIOrderedTask]() class will automatically present the task based on the Step objects in the Task object. It also gives you the possibility to gather the results. (For the result hierarchy see the section later) 

This widget returns a full screen [Scaffold](https://docs.flutter.io/flutter/material/Scaffold-class.html) widget so the recommended usage is to create a route which returns an [RPUIOrderedTask]() and then navigate to this route. The minimum example is the following:

``` dart
class SurveyTaskRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RPUIOrderedTask(
      task: surveyTask,
      onSubmit: () {} // Collecting results, see next section
    );
  }
}
```

## Collecting results

Gathering the results from a task is made possible by passing a callback function to the [RPUIOrderedTask]() widget's onSubmit input parameter. The onSubmit event is triggered when the user has finished with the last step in the the list of steps passed to the Task object.

**To learn more about the result objects and their structure visit the [corresponding page](https://github.com/cph-cachet/research.package/wiki/2.-Software-Architecture#results-hierarchy).**

You should create a function which needs an input parameter with [RPTaskResult]() type. A minimum example is the following:

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
