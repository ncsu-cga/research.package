---
layout: single
title: Software Architecture
permalink: /software-architecture
toc: true
---

This tutotial describes the overall software architecture of ResearchPackage.

## Data Flow

Research Package uses streams and regular callbacks for internal communication (e.g. between Task and Steps). 
There is a BLoC file responsible for the communication between the Task and the Steps it's containing ([BlocTask](https://pub.dev/documentation/research_package/latest/research_package_model/BlocTask-class.html)). The communication between the Question Container and their Question Body is made possible by regular callback functions.

## Bloc

The [BlocTask](https://pub.dev/documentation/research_package/latest/research_package_model/BlocTask-class.html) is only holding the StreamControllers needed for the communication.

## Results

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
