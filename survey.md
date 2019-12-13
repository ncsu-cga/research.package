---
layout: single
title: Survey
permalink: /survey
toc: true
---

## Attention

**Since Research Package supports only the single choice answer format at the moment this tutorial is limited to a single scenario.**

Creating surveys is on of Research Package main modules (besides obtaining informed consent). This tutorial will guide you through how to create the needed domain model objects for a survey task, how to present it on the UI and finally how to collect the results.

## Creating Model Objects

As usual, Research Package uses a Task to represent the survey containing the Steps. In this case the Task object will be an [RPOrderedTask]() object and the steps which it holds are [RPQuestionStep]() objects. (With optional [RPInstructionStep]() at the beginning and [RPCompletionStep]() at the end)

### Creating steps

#### Instruction Step

You can present instructions to the user, put them to context or show footnotes with the [RPInstructionStep](). An Instruction Step is useful any time you want to provide some instruction for the user at the beginning or during a survey.
Here's how you can create one:

```dart
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

Let's create an actual Question Step. An [RPQuestionStep]() is a generic step that needs a child of [RPAnswerFormat]() on which depends what kind of question will the step present.

You can create as many question steps as you desire.

Let's have a look at the available Answer Formats in Research Package.

##### Single Choice

In order to create the question step we have to set up the answer format first with a list of choices ([RPChoice]()) and the answer style.

The UI representation of this Answer Format looks like this:

<img src="https://github.com/cph-cachet/research.package/blob/master/documentation/images/SingleChoiceAnswerFormat.png" width="300">

Here's how to create a single choice answer format:

```dart
// First create the list of choices
List<RPChoice> choices = [
  RPChoice("All of the time", 5),
  RPChoice("Most of the time", 4),
  RPChoice("More than half of the time", 3),
  RPChoice("Less than half of the time", 2),
  RPChoice("Some of the time", 1),
  RPChoice("At no time", 0),
];

// Pass the list of choices to the constructor
RPChoiceAnswerFormat choiceAnswerFormat = RPChoiceAnswerFormat(ChoiceAnswerStyle.SingleChoice, choices);
```

A single choice question format allows the user to pick one single element from a previously created set of options. The easiest way to create this step is by using the `.withAnswerFormat` constructor as the following:

```dart
RPQuestionStep choiceQuestionStep = RPQuestionStep.withAnswerFormat(
  "questionStep1ID",
  "I have felt cheerful and in good spirits",
  choiceAnswerFormat,
);
```

##### Multiple Choice

##### Integer

#### Form Step

#### Completion Step

Although it's not obligatory, creating a Completion Step and appending it to the list of steps is a good idea because we can assure the user that we saved the result and the survey is over. Here's how to create an [RPCompletionStep]():

```dart
RPCompletionStep completionStep = RPCompletionStep("completionStepID")
  ..title = "Thank You!"
  ..text = "The survey is over and we saved your result";
```

## The Survey Task

Now that you have all the needed steps, you can create the Task for the survey. To do so you have to create an [RPOrderedTask]() with a unique string identifier and the list of previously created steps.

```dart
RPOrderedTask surveyTask = RPOrderedTask("surveyTaskID", [consentVisualStep, choiceQuestionStep, completionStep]);
```

## Presenting the Task

The next step is to present the Survey Task (`surveyTask`). To achieve this you have to use the UI library of Research Package.

The [RPUIOrderedTask]() class will automatically present the task based on the Step objects in the Task object. It also gives you the possibility to gather the results. (For the result hierarchy see the section later)

This widget returns a full screen [Scaffold](https://docs.flutter.io/flutter/material/Scaffold-class.html) widget so the recommended usage is to create a route which returns an [RPUIOrderedTask]() and then navigate to this route. The minimum example is the following:

```dart
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

```dart
void resultCallback(RPTaskResult result) {
   // Do whatever you want with the result
   // In this case we are just printing the result's keys
   print(result.results.keys);
}
```

After creating the function you just have to pass it to the Task widget when creating. This changes the build function of our example above to the following:

```dart
@override
Widget build(BuildContext context) {
   return RPUIOrderedTask(
      task: task,
      onSubmit: resultCallback,
   );
}
```
