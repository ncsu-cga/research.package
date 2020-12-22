part of research_package_model;

/// The [RPNavigableOrderedTask] class adds conditional step navigation to the behavior inherited from the [RPOrderedTask] class.
///
/// It's able to show different questions based on previous answers by using [RPPredicateStepNavigationRule]s.
/// This task allows participant to go back to/looping through previous questions. In that case only the last answer given to the question will be saved.
class RPNavigableOrderedTask extends RPOrderedTask {
  Map<String, RPStepNavigationRule> _stepNavigationRules;
//  List<RPSkipStepNavigationRule> _skipStepNavigationRules;
//  List<RPStepModifier> _stepModifiers;
  bool shouldReportProgress;

  // MS: For RPPredicateStepNavigationRule case
  Map<String, List<RPStep>> predicateSteps;
  RPNavigableOrderedTask(String identifier, steps,
      {closeAfterFinished = true,
      shouldReportProgress = true,
      String navigationPageId,
      this.predicateSteps})
      : super(identifier, steps,
            closeAfterFinished: closeAfterFinished,
            navigationPageId: navigationPageId) {
    _stepNavigationRules = Map<String, RPStepNavigationRule>();
  }

  /// A dictionary of step identifier Strings and their corresponding navigation rule([RPStepNavigationRule]).
  Map<String, RPStepNavigationRule> get stepNavigationRules =>
      this._stepNavigationRules;

  // Future init() async {
  //   print('Init');
  // }

//  List<RPSkipStepNavigationRule> get skipStepNavigationRules => this._skipStepNavigationRules;
//  List<RPStepModifier> get stepModifiers => this._stepModifiers;
//  bool get shouldReportProgress => this._shouldReportProgress;

  /// Returns the step after a specified step if there's any, taking the [RPStepNavigationRule]s into consideration.
  ///
  /// If the specified step is ```null``` then it returns the first step.
  /// Returns ```null``` if [step] was the last one in the sequence.
  @override
  RPStep getStepAfterStep(RPStep step, RPTaskResult result) {
    RPStep _stepToReturn;

    _returnNextQuestion() {
      int nextIndex = _steps.indexOf(step) + 1;

      if (nextIndex < _steps.length) {
        _stepToReturn = _steps[nextIndex];
      } else {
        _stepToReturn = null;
      }
    }

    if (step == null) {
      _stepToReturn = _steps.first;
      return _stepToReturn;
    }

    if (_stepNavigationRules.containsKey(step.identifier)) {
      RPStepNavigationRule rule = _stepNavigationRules[step.identifier];

      switch (rule.runtimeType) {
        case RPStepReorganizerRule:
          RPStepResult tempResult =
              (rule as RPStepReorganizerRule).resultSelector.getResult();
          List identifiersToKeep = [];
          (tempResult.results["answer"] as List<RPChoice>).forEach((element) {
            String id =
                (rule as RPStepReorganizerRule)._removalMap[element.value];
            identifiersToKeep.add(id);
          });

          RPStep _lastStep;
          if (steps.last.runtimeType == RPCompletionStep) {
            _lastStep = steps.last;
          }

          steps.removeWhere(
              (step) => !identifiersToKeep.contains(step.identifier));

          steps.add(_lastStep);

          _returnNextQuestion();

          break;
        case RPStepJumpRule:
          RPStepJumpRule jumpRule = (rule as RPStepJumpRule);
          RPStepResult tempResult =
              (rule as RPStepJumpRule).resultSelector.getResult();

          _stepToReturn = _steps.firstWhere((step) =>
              step.identifier ==
              jumpRule._answerMap[tempResult.results["answer"].first.value]);

          break;
        case RPPredicateStepNavigationRule:
          // Remove predicate steps from task items
          int _currentIdx = _steps.indexOf(step);
          if (predicateSteps != null) {
            // Get current step index and length
            if (predicateSteps.containsKey(step.identifier)) {
              // print('items remove: ');
              for (var i = _currentIdx; i < _steps.length; i++) {
                predicateSteps[step.identifier].forEach((item) {
                  if (_steps[i].identifier == item.identifier) {
                    print(item.identifier);
                    steps.remove(_steps[i]);
                  }
                });
              }
            }
          }
          // Add predicate steps based on answers
          int _counter = _currentIdx;
          (rule as RPPredicateStepNavigationRule)
              .resultPredicatesWithDestinationIdentifiers
              .forEach((resultPredicate, destinationStepIdentifier) {
            print(resultPredicate.getPredictionResult());
            if (resultPredicate.getPredictionResult()) {              
                predicateSteps[step.identifier].asMap().forEach((idx, item) {
                  if (destinationStepIdentifier == item.identifier) {
                    _counter++;
                    // print('insert: ' +
                    //     'At: ' +
                    //     _counter.toString() +
                    //     ' ' +
                    //     item.identifier);
                    steps.insert(_counter, item);
                  }
                });
              
            }
          });
          _returnNextQuestion();
          break;
        case RPDirectStepNavigationRule:
          String destinationStepIdentifier =
              (rule as RPDirectStepNavigationRule).destinationStepIdentifier;
          _steps.forEach((step) {
            if (step.identifier == destinationStepIdentifier) {
              _stepToReturn = step;
            }
          });
          break;
        default:
          throw ("Navigation Rule's type ${_stepNavigationRules[step.identifier].runtimeType} is not a navigation rule type");
          break;
      }
    } else {
      _returnNextQuestion();
    }

    return _stepToReturn;
  }

  /// Adds a navigation rule to step using its identifier.
  ///
  /// ```
  ///   RPNavigableOrderedTask navigableSurveyTask = RPNavigableOrderedTask(
  ///     "NavigableTaskID",
  ///     [
  ///       instructionStep,
  ///       questionStep1,
  ///       questionStep2,
  ///     ],
  ///   )
  ///   ..setNavigationRuleForTriggerStepIdentifier(someNavigationRule, questionStep1.identifier);
  /// ```
  setNavigationRuleForTriggerStepIdentifier(
      RPStepNavigationRule stepNavigationRule, String triggerStepIdentifier) {
    _stepNavigationRules[triggerStepIdentifier] = stepNavigationRule;
  }

  /// Returns the navigation rule for the given step identifier
  RPStepNavigationRule navigationRuleForTriggerStepIdentifier(
      String triggerStepIdentifier) {
    return _stepNavigationRules[triggerStepIdentifier];
  }

  /// Removes the navigation rule from the given step using its identifier
  removeNavigationRuleForTriggerStepIdentifier(String triggerStepIdentifier) {
    _stepNavigationRules.remove(triggerStepIdentifier);
  }

//  setSkipNavigationRule(RPSkipStepNavigationRule skipStepNavigationRule, String stepIdentifier) {
//    // TODO
//  }

//  RPSkipStepNavigationRule skipNavigationRuleForStepIdentifier(String stepIdentifier) {
//    // TODO
//  }

//  removeSkipNavigationRuleForStepIdentifier(String stepIdentifier) {
//    // TODO
//  }

//  setStepModifier(RPStepModifier stepModifier, String stepIdentifier) {
//    // TODO
//  }

//  RPStepModifier stepModifierForStepIdentifier(String stepIdentifier) {
//    // TODO
//  }

//  removeStepModifierForStepIdentifier(String stepIdentifier) {
//    // TODO
//  }
}
