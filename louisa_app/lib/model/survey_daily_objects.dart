import 'package:research_package/research_package.dart';
import 'package:louisa_app/model/custom_step.dart';

//----- Yes & No answers
List<RPChoice> yesNo = [
  RPChoice.withParams('Yes', 0),
  RPChoice.withParams('No', 1),
];

RPChoiceAnswerFormat yesNoChoiceAnswerFormat =
    RPChoiceAnswerFormat.withParams(ChoiceAnswerStyle.SingleChoice, yesNo);
RPBooleanAnswerFormat yesNoAnswerFormat =
    RPBooleanAnswerFormat.withParams('Yes', 'No');

//----- Every Day Survey -----
RPInstructionStep dailyHealthQuestionInstruction = RPInstructionStep(
  identifier: 'dailyHealthQuestionInstructionId',
  title: 'Daily Health Questions',
)..text = 'Last, we would like to ask about how you are feeling today.';

RPQuestionStep symptomsTodayQuestionStep = RPQuestionStep.withAnswerFormat(
    'symptomsTodayQuestionId',
    'Do you feel any health symptoms today?',
    yesNoChoiceAnswerFormat);
RPStepJumpRule symptomsTodayBranchRule =
    RPStepJumpRule(symptomsTodayQuestionStep.identifier, {
  0: symptomsQuestionStep.identifier,
  1: completionStep.identifier,
});
List<RPChoice> symptoms = [
  RPChoice.withParams('Body aches', 1),
  RPChoice.withParams('Burning eyes, nose, or throat', 2),
  RPChoice.withParams('Chest pain/heart palpitations', 3),
  RPChoice.withParams('Cough/sneezing', 4),
  RPChoice.withParams('Diarrhea/nausea/vomiting', 5),
  RPChoice.withParams('Dizziness', 6),
  RPChoice.withParams('Tiredness', 7),
  RPChoice.withParams('Fever', 8),
  RPChoice.withParams('Headache', 9),
  RPChoice.withParams('Itchy skin', 10),
  RPChoice.withParams('Loss of smell', 11),
  RPChoice.withParams('Difficulty breathing', 12),
  RPChoice.withParams('Swelling', 13),
  RPChoice.withParams('Other', 14),
];

RPChoiceAnswerFormat symptomsAnswerFormat =
    RPChoiceAnswerFormat.withParams(ChoiceAnswerStyle.MultipleChoice, symptoms);

RPQuestionStep symptomsQuestionStep = RPQuestionStep.withAnswerFormat(
  'symptomsQuestionStepID',
  '(if they feel symptoms today) Which symptoms do you feel today?',
  symptomsAnswerFormat,
);

RPResultPredicate choice911Predicate =
    RPResultPredicate.forChoiceQuestionResult(
        resultSelector: RPResultSelector.forStepId('symptomsQuestionStepID'),
        expectedValue: [3, 12],
        choiceQuestionResultPredicateMode:
            ChoiceQuestionResultPredicateMode.Containing);

RPResultPredicate choiceCallDoctorPredicate =
    RPResultPredicate.forChoiceQuestionResult(
        resultSelector: RPResultSelector.forStepId('symptomsQuestionStepID'),
        expectedValue: [14],
        choiceQuestionResultPredicateMode:
            ChoiceQuestionResultPredicateMode.Containing);

RPPredicateStepNavigationRule dialogNavigationRule =
    RPPredicateStepNavigationRule(
  {
    choice911Predicate: dialog911Step.identifier,
    choiceCallDoctorPredicate: dialogDoctorStep.identifier,
    // noNextChoicePredicate: dailyHealthQuestionInstruction.identifier,
  },
);

RPCompletionStep completionStep = RPCompletionStep("completionID")
  ..title = "Finished"
  ..text = "Thank you for filling out the survey!";

CustomStep dialog911Step = CustomStep('call911ID')..dialog = 'CALL_EMERGENCY';
CustomStep dialogDoctorStep = CustomStep('callDoctorID')
  ..dialog = 'CALL_DOCTOR';

Map<String, List<CustomStep>> dialogPredicateSteps = {
  'symptomsQuestionStepID': [dialog911Step, dialogDoctorStep]
};

RPNavigableOrderedTask navigableDailyHealthSurveyTask = RPNavigableOrderedTask(
    'dailyHealthSurveyTaskID',
    [
      // dailyHealthQuestionInstruction,
      // symptomsTodayQuestionStep,
      symptomsQuestionStep,
      dialog911Step,

      dialogDoctorStep,

      completionStep,
    ],
    // closeAfterFinished: false,
    predicateSteps: dialogPredicateSteps)
  // ..setNavigationRuleForTriggerStepIdentifier(
  //     symptomsTodayBranchRule, symptomsTodayQuestionStep.identifier)
  ..setNavigationRuleForTriggerStepIdentifier(
      dialogNavigationRule, symptomsQuestionStep.identifier);
