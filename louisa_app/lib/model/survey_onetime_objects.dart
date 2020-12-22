// import 'package:research_package/model.dart';
import 'package:louisa_app/screen/survey_daily_screen.dart';
import 'package:research_package/research_package.dart';

//----- Yes & No answers
List<RPChoice> yesNo = [
  RPChoice.withParams('Yes', 0),
  RPChoice.withParams('No', 1),
];

RPChoiceAnswerFormat yesNoChoiceAnswerFormat =
    RPChoiceAnswerFormat.withParams(ChoiceAnswerStyle.SingleChoice, yesNo);
RPBooleanAnswerFormat yesNoAnswerFormat =
    RPBooleanAnswerFormat.withParams('Yes', 'No');
//-----------

// ----- Gender Question -----

RPQuestionStep femaleQuestionStep = RPQuestionStep.withAnswerFormat(
    'femaleQuestionId', 'Are you female?', yesNoChoiceAnswerFormat);

RPQuestionStep maleQuestionStep = RPQuestionStep.withAnswerFormat(
    'maleQuestionId', 'Are you male?', yesNoChoiceAnswerFormat);

RPQuestionStep otherQuestionStep = RPQuestionStep.withAnswerFormat(
    'otherQuestionId',
    'Do you identify as some other gender?',
    yesNoChoiceAnswerFormat);

// * Jump Rules
RPStepJumpRule femaleBranchRule =
    RPStepJumpRule(femaleQuestionStep.identifier, {
  0: raceEthnicityQuestionStep.identifier,
  1: maleQuestionStep.identifier,
});

RPStepJumpRule maleBranchRule = RPStepJumpRule(maleQuestionStep.identifier, {
  0: raceEthnicityQuestionStep.identifier,
  1: otherQuestionStep.identifier,
});

RPStepJumpRule otherBranchRule = RPStepJumpRule(otherQuestionStep.identifier, {
  0: raceEthnicityQuestionStep.identifier,
  1: femaleQuestionStep.identifier,
});

//----- Race/Ethnicity Question <MultipleChoice> -----
List<RPChoice> raceEthnicity = [
  RPChoice.withParams('African American/Black ', 1),
  RPChoice.withParams('American Indian or Alaska Native', 2),
  RPChoice.withParams('Asian', 3),
  RPChoice.withParams('Cajun', 4),
  RPChoice.withParams('Caucasian/White', 5),
  RPChoice.withParams('Hispanic', 6),
  RPChoice.withParams('Other', 7, true),
];

RPChoiceAnswerFormat raceEthnicityAnswerFormat =
    RPChoiceAnswerFormat.withParams(
        ChoiceAnswerStyle.MultipleChoice, raceEthnicity);

RPQuestionStep raceEthnicityQuestionStep = RPQuestionStep.withAnswerFormat(
  'raceEthnicityQuestionStepID',
  'Race/Ethnicity',
  raceEthnicityAnswerFormat,
);

// RPFormStep formStep = RPFormStep.withTitle(
//   'formstepID',
//   [raceEthnicityQuestionStep, raceEthnicityOtherQuestionStep],
//   'Race/Ethnicity',
//   optional: false,
// );

//----- Income Question <SingleChoice> -----
List<RPChoice> income = [
  RPChoice.withParams('Less than \$15,000', 1),
  RPChoice.withParams('\$15,000 to \$24,999', 2),
  RPChoice.withParams('\$25,000 to \$34,999', 3),
  RPChoice.withParams('\$35,000 to \$49,999', 4),
  RPChoice.withParams('\$50,000 to \$74,999', 5),
  RPChoice.withParams('\$75,000 to \$99,999', 6),
  RPChoice.withParams('\$100,000 or more', 7),
];

RPChoiceAnswerFormat incomeAnswerFormat =
    RPChoiceAnswerFormat.withParams(ChoiceAnswerStyle.SingleChoice, income);

RPQuestionStep incomeQuestionStep = RPQuestionStep.withAnswerFormat(
    'incomeQuestionId', 'What is your household income?', incomeAnswerFormat);

//----- Education Question <SingleChoice> -----
List<RPChoice> education = [
  RPChoice.withParams('Did not finish high school', 1),
  RPChoice.withParams('High school graduate', 2),
  RPChoice.withParams('Some college', 3),
  RPChoice.withParams('College graduate', 4),
  RPChoice.withParams('Some post-graduate studies', 5),
  RPChoice.withParams('Graduate degree', 6),
];

RPChoiceAnswerFormat educationAnswerFormat =
    RPChoiceAnswerFormat.withParams(ChoiceAnswerStyle.SingleChoice, education);

RPQuestionStep educationQuestionStep = RPQuestionStep.withAnswerFormat(
    'educationQuestionId',
    'How much schooling have you had?',
    educationAnswerFormat);

//----- Exercise Question <YesNo> -----
RPQuestionStep exerciseQuestionStep = RPQuestionStep.withAnswerFormat(
    'exerciseQuestionId',
    'Do you exercise for at least 30 minutes three times a week?',
    yesNoChoiceAnswerFormat);

// ! If previous answer is Yes
List<RPChoice> exerciseLocation = [
  RPChoice.withParams('Outside', 1),
  RPChoice.withParams('Inside', 2),
];
RPChoiceAnswerFormat exerciseLocationAnswerFormat =
    RPChoiceAnswerFormat.withParams(
        ChoiceAnswerStyle.SingleChoice, exerciseLocation);

RPQuestionStep exerciseLocationQuestionStep = RPQuestionStep.withAnswerFormat(
    'exerciseLocationQuestionId',
    'Where do you exercise the most?',
    exerciseLocationAnswerFormat);

RPStepJumpRule exerciseBranchRule =
    RPStepJumpRule(exerciseQuestionStep.identifier, {
  0: exerciseLocationQuestionStep.identifier,
  1: howLongOutsideQuestionStep.identifier,
});

//----- How Long Outside Question <YesNo> -----
RPQuestionStep howLongOutsideQuestionStep = RPQuestionStep.withAnswerFormat(
    'howLongOutsideQuestionId',
    'Do you spend more than 10 hours per week outside for your job?',
    yesNoAnswerFormat);

//----- Number of Household Question <Integer> -----
RPIntegerAnswerFormat numberOfHouseholdAnswerFormat =
    RPIntegerAnswerFormat.withParams(0, 1000);
RPQuestionStep numberOfHouseholdQuestionStep = RPQuestionStep.withAnswerFormat(
    'numberOfHouseholdQuestionId',
    'How many people live in your house?',
    numberOfHouseholdAnswerFormat);

//----- Cigarettes Question <YesNo> -----
RPQuestionStep cigarettesQuestionStep = RPQuestionStep.withAnswerFormat(
    'cigarettesQuestionId',
    'Do you currently smoke cigarettes?',
    yesNoAnswerFormat);

//----- Vape Question <YesNo> -----

RPQuestionStep vapeQuestionStep = RPQuestionStep.withAnswerFormat(
    'vapeQuestionId', 'Do you currently vape?', yesNoAnswerFormat);

//----- Tabacco Question <YesNo> -----
RPQuestionStep tabaccoQuestionStep = RPQuestionStep.withAnswerFormat(
    'tabaccoQuestionId',
    'Have you used tobacco in the past?',
    yesNoAnswerFormat);

//----- Household Smoking Question <SingleChoice> -----
RPQuestionStep householdSmokingQuestionStep = RPQuestionStep.withAnswerFormat(
    'householdSmorkingQuestionId',
    'Does anyone else in your house smoke?',
    yesNoAnswerFormat);

//----- Health Question 1 <MultipleChoice> -----
RPInstructionStep healthQuestionInstruction = RPInstructionStep(
  identifier: 'healthQuestionId',
  title: 'Health Questions',
)..text =
    'Now, we would like to ask you a few questions about your health problems over the years.';

List<RPChoice> health = [
  RPChoice.withParams('Arthritis', 1),
  RPChoice.withParams('Breathing problems', 2),
  RPChoice.withParams('Cancer', 3),
  RPChoice.withParams('COVID-19', 4),
  RPChoice.withParams('Depression', 5),
  RPChoice.withParams('Diabetes', 6),
  RPChoice.withParams('Heart problems or stroke', 7),
  RPChoice.withParams('Immune system problems', 8),
  RPChoice.withParams('Neurologic/brain problems', 9),
  RPChoice.withParams('Obesity', 10),
  RPChoice.withParams('Thyroid problems', 11),
  RPChoice.withParams('Other', 12, true),
  RPChoice.withParams('Not sure', 13),
];

RPChoiceAnswerFormat healthAnswerFormat =
    RPChoiceAnswerFormat.withParams(ChoiceAnswerStyle.MultipleChoice, health);

RPQuestionStep healthQuestionStep = RPQuestionStep.withAnswerFormat(
  'healthQuestionStepID',
  'Have you ever been told by a doctor that you have any of these health problems?',
  healthAnswerFormat,
);

// Respiratory Predicate
RPResultPredicate respiratoryChoicePredicate =
    RPResultPredicate.forChoiceQuestionResult(
        resultSelector: RPResultSelector.forStepId('healthQuestionStepID'),
        expectedValue: [2],
        choiceQuestionResultPredicateMode:
            ChoiceQuestionResultPredicateMode.Containing);
// Cancer Predicate
RPResultPredicate cancerChoicePredicate =
    RPResultPredicate.forChoiceQuestionResult(
        resultSelector: RPResultSelector.forStepId('healthQuestionStepID'),
        expectedValue: [3],
        choiceQuestionResultPredicateMode:
            ChoiceQuestionResultPredicateMode.Containing);
// Heart Predicate
RPResultPredicate heartChoicePredicate =
    RPResultPredicate.forChoiceQuestionResult(
        resultSelector: RPResultSelector.forStepId('healthQuestionStepID'),
        expectedValue: [7],
        choiceQuestionResultPredicateMode:
            ChoiceQuestionResultPredicateMode.Containing);
// Immune Predicate
RPResultPredicate immuneChoicePredicate =
    RPResultPredicate.forChoiceQuestionResult(
        resultSelector: RPResultSelector.forStepId('healthQuestionStepID'),
        expectedValue: [8],
        choiceQuestionResultPredicateMode:
            ChoiceQuestionResultPredicateMode.Containing);

// Neuro Predicate
RPResultPredicate neuroChoicePredicate =
    RPResultPredicate.forChoiceQuestionResult(
        resultSelector: RPResultSelector.forStepId('healthQuestionStepID'),
        expectedValue: [9],
        choiceQuestionResultPredicateMode:
            ChoiceQuestionResultPredicateMode.Containing);

// RPResultPredicate noNextChoicePredicate =
//     RPResultPredicate.forChoiceQuestionResult(
//         resultSelector: RPResultSelector.forStepId('healthQuestionStepID'),
//         expectedValue: [6, 7, 8, 9, 10, 11, 12, 13],
//         choiceQuestionResultPredicateMode:
//             ChoiceQuestionResultPredicateMode.Containing);

// RPDirectStepNavigationRule directStepNavRule =
//     RPDirectStepNavigationRule(dailyHealthQuestionInstruction.identifier);

// RPStepJumpRule healthBranchRule =
//     RPStepJumpRule(healthQuestionStep.identifier, {
//   0: dailyHealthQuestionInstruction.identifier,
//   1: respiratoryQuestionStep.identifier,
//   2: cancerQuestionStep.identifier,
//   3: dailyHealthQuestionInstruction.identifier,
//   4: dailyHealthQuestionInstruction.identifier,
//   5: dailyHealthQuestionInstruction.identifier,
//   6: heartQuestionStep.identifier,
//   7: immuneQuestionStep.identifier,
//   8: neuroQuestionStep.identifier,
//   9: dailyHealthQuestionInstruction.identifier,
//   10: dailyHealthQuestionInstruction.identifier,
//   11: dailyHealthQuestionInstruction.identifier,
//   12: dailyHealthQuestionInstruction.identifier,
// });

//----- Respiratory <MultipleChoice>
List<RPChoice> respiratory = [
  RPChoice.withParams('Allergies', 1),
  RPChoice.withParams('Asbestosis', 2),
  RPChoice.withParams('Asthma', 3),
  RPChoice.withParams('Bronchitis', 4),
  RPChoice.withParams('COPD (chronic obstructive pulmonary disease)', 5),
  RPChoice.withParams('Emphysema', 6),
  RPChoice.withParams('Sleep apnea', 7),
  RPChoice.withParams('Other', 8),
  RPChoice.withParams('Not sure', 9),
];

RPChoiceAnswerFormat respiratoryAnswerFormat = RPChoiceAnswerFormat.withParams(
    ChoiceAnswerStyle.MultipleChoice, respiratory);

RPQuestionStep respiratoryQuestionStep = RPQuestionStep.withAnswerFormat(
  'respiratoryQuestionStepID',
  'Have you ever been told by a doctor that you have any of these breathing problems?',
  respiratoryAnswerFormat,
);

//----- Cancer <MultipleChoices> -----
List<RPChoice> cancer = [
  RPChoice.withParams('Breast cancer', 1),
  RPChoice.withParams('Cervical cancer', 2),
  RPChoice.withParams('Colorectal cancer', 3),
  RPChoice.withParams('Leukemia/Lymphoma', 4),
  RPChoice.withParams('Liver cancer', 5),
  RPChoice.withParams('Lung cancer', 6),
  RPChoice.withParams('Melanoma', 7),
  RPChoice.withParams('Mesothelioma', 8),
  RPChoice.withParams('Mouth/throat cancer', 9),
  RPChoice.withParams('Pancreatic cancer', 10),
  RPChoice.withParams('Prostate cancer', 11),
  RPChoice.withParams('Thyroid cancer', 12),
  RPChoice.withParams('Other', 13),
  RPChoice.withParams('Not sure', 14),
];

RPChoiceAnswerFormat cancerAnswerFormat =
    RPChoiceAnswerFormat.withParams(ChoiceAnswerStyle.MultipleChoice, cancer);

RPQuestionStep cancerQuestionStep = RPQuestionStep.withAnswerFormat(
  'cancerQuestionStepID',
  '(if they check cancer) Have you ever been told by a doctor that you have any of these kinds of cancer?',
  cancerAnswerFormat,
);

//----- Heart <MultipleChoice>

List<RPChoice> heart = [
  RPChoice.withParams('Congestive heart failure', 1),
  RPChoice.withParams('Coronary artery disease', 2),
  RPChoice.withParams('Heart attack', 3),
  RPChoice.withParams('High blood pressure', 4),
  RPChoice.withParams('Irregular heartbeat', 5),
  RPChoice.withParams('Stroke', 6),
  RPChoice.withParams('Other', 7),
  RPChoice.withParams('Not sure', 8),
];

RPChoiceAnswerFormat heartAnswerFormat =
    RPChoiceAnswerFormat.withParams(ChoiceAnswerStyle.MultipleChoice, heart);

RPQuestionStep heartQuestionStep = RPQuestionStep.withAnswerFormat(
  'heartQuestionStepID',
  '(if they check heart problems) Have you ever been told by a doctor that you have any of these kinds of problems?',
  heartAnswerFormat,
);

//----- Immune <MultipleChoice> -----
List<RPChoice> immune = [
  RPChoice.withParams('Allergies', 1),
  RPChoice.withParams(
      'Autoimmune disease (e.g., Multiple Sclerosis, Crohn’s Disease, Lupus)',
      2),
  RPChoice.withParams('AIDS', 3),
  RPChoice.withParams('Other', 4),
  RPChoice.withParams('Not sure', 5),
];

RPChoiceAnswerFormat immuneAnswerFormat =
    RPChoiceAnswerFormat.withParams(ChoiceAnswerStyle.MultipleChoice, immune);

RPQuestionStep immuneQuestionStep = RPQuestionStep.withAnswerFormat(
  'immuneQuestionStepID',
  '(if they check immune system problems) Have you ever been told by a doctor that you have any of these kinds of problems?',
  immuneAnswerFormat,
);

//----- Neuro <MultipleChoice> -----
List<RPChoice> neuro = [
  RPChoice.withParams('Epilepsy', 1),
  RPChoice.withParams('Multiple Sclerosis', 2),
  RPChoice.withParams('Parkinson’s Disease', 3),
  RPChoice.withParams('Stroke', 4),
  RPChoice.withParams('Other', 5),
  RPChoice.withParams('Not sure', 6),
];

RPChoiceAnswerFormat neuroAnswerFormat =
    RPChoiceAnswerFormat.withParams(ChoiceAnswerStyle.MultipleChoice, neuro);

RPQuestionStep neuroQuestionStep = RPQuestionStep.withAnswerFormat(
  'neuroQuestionStepID',
  '(if they check nervous system/brain problems) Have you ever been told by a doctor that you have any of these kinds of problems?',
  neuroAnswerFormat,
);

//----- Every Day Survey -----
RPInstructionStep dailyHealthQuestionInstruction = RPInstructionStep(
  identifier: 'dailyHealthQuestionInstructionId',
  title: 'Daily Health Questions',
)..text = 'Last, we would like to ask about how you are feeling today.';

RPQuestionStep symptomsTodayQuestionStep = RPQuestionStep.withAnswerFormat(
    'symptomsTodayQuestionId',
    'Last, we would like to ask about how you are feeling today.\nDo you feel any health symptoms today?',
    yesNoAnswerFormat);

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

RPCompletionStep completionStep = RPCompletionStep("completionID")
  ..title = "Finished"
  ..text = "Thank you for filling out the survey!";

// ----- TASK -----
// Predicate Step Navigation Rule
RPPredicateStepNavigationRule healthChoiceNavigationRule =
    RPPredicateStepNavigationRule(
  {
    respiratoryChoicePredicate: respiratoryQuestionStep.identifier,
    cancerChoicePredicate: cancerQuestionStep.identifier,
    heartChoicePredicate: heartQuestionStep.identifier,
    immuneChoicePredicate: immuneQuestionStep.identifier,
    neuroChoicePredicate: neuroQuestionStep.identifier,
    // noNextChoicePredicate: dailyHealthQuestionInstruction.identifier,
  },
);
// RPPredicateStepNavigationRule immuneChoiceNavigationRule =
//     RPPredicateStepNavigationRule(
//   {
//     respiratoryChoicePredicate: respiratoryQuestionStep.identifier,
//     cancerChoicePredicate: cancerQuestionStep.identifier,
//     heartChoicePredicate: heartQuestionStep.identifier,
//     immuneChoicePredicate: immuneQuestionStep.identifier,
//     neuroChoicePredicate: neuroQuestionStep.identifier,
//     noNextChoicePredicate: dailyHealthQuestionInstruction.identifier,
//   },
// );
Map<String, dynamic> healthPredicateSteps = {
  'healthQuestionStepID': [
    respiratoryQuestionStep,
    cancerQuestionStep,
    heartQuestionStep,
    immuneQuestionStep,
    neuroQuestionStep,
  ]
};

RPNavigableOrderedTask navigableSurveyTask = RPNavigableOrderedTask(
  'NavigableTaskID',
  [
    femaleQuestionStep,
    maleQuestionStep,
    otherQuestionStep,
    raceEthnicityQuestionStep,
    incomeQuestionStep,
    educationQuestionStep,
    exerciseQuestionStep,
    exerciseLocationQuestionStep,
    howLongOutsideQuestionStep,
    numberOfHouseholdQuestionStep,
    cigarettesQuestionStep,
    vapeQuestionStep,
    tabaccoQuestionStep,
    householdSmokingQuestionStep,
    healthQuestionInstruction,
    healthQuestionStep,
    respiratoryQuestionStep,
    cancerQuestionStep,
    heartQuestionStep,
    immuneQuestionStep,
    neuroQuestionStep,
    // dailyHealthQuestionInstruction,
    // symptomsTodayQuestionStep,
    // symptomsQuestionStep,
    completionStep,
  ],
  predicateSteps: healthPredicateSteps,
  closeAfterFinished: false,
  navigationPageId: DailyHealthScreen.id,
)
..setNavigationRuleForTriggerStepIdentifier(
    femaleBranchRule, femaleQuestionStep.identifier)
..setNavigationRuleForTriggerStepIdentifier(
    maleBranchRule, maleQuestionStep.identifier)
..setNavigationRuleForTriggerStepIdentifier(
    otherBranchRule, otherQuestionStep.identifier)
..setNavigationRuleForTriggerStepIdentifier(
    exerciseBranchRule, exerciseQuestionStep.identifier)
..setNavigationRuleForTriggerStepIdentifier(
    healthChoiceNavigationRule, healthQuestionStep.identifier);

// ..setNavigationRuleForTriggerStepIdentifier(
// directStepNavRule, healthQuestionStep.identifier);

// ..setNavigationRuleForTriggerStepIdentifier(
//     healthBranchRule, healthQuestionStep.identifier);

// ..setNavigationRuleForTriggerStepIdentifier(
//     noFemaleNavigationRule, femaleQuestionStep.identifier)
// ..setNavigationRuleForTriggerStepIdentifier(
//     noMaleNavigationRule, maleQuestionStep.identifier)
// ..setNavigationRuleForTriggerStepIdentifier(
//     yesExerciseNavigationRule, exerciseQuestionStep.identifier);
//RPDirectStepNavigationRule navigationRuleAfterSmokingResult =
//    RPDirectStepNavigationRule(imageChoiceQuestionStep.identifier);

// ----- Test navigation -----

// Chooice
List<RPChoice> choices = [
  RPChoice.withParams('A', 1),
  RPChoice.withParams('B', 2),
  RPChoice.withParams('C', 3),
  RPChoice.withParams('D', 4),
  RPChoice.withParams('E', 5),
];

List<RPChoice> choicesFruits = [
  RPChoice.withParams('banana', 1),
  RPChoice.withParams('apple', 2),
  RPChoice.withParams('grape', 3),
];

List<RPChoice> choicesVeg = [
  RPChoice.withParams('cucumber', 1),
  RPChoice.withParams('kale', 2),
  RPChoice.withParams('celery', 3),
];

List<RPChoice> choicesCar = [
  RPChoice.withParams('Carola', 1),
  RPChoice.withParams('Edge', 2),
  RPChoice.withParams('Civic', 3),
];

// Answer format
RPChoiceAnswerFormat answerFormat =
    RPChoiceAnswerFormat.withParams(ChoiceAnswerStyle.MultipleChoice, choices);
RPChoiceAnswerFormat answerFormatFruits = RPChoiceAnswerFormat.withParams(
    ChoiceAnswerStyle.MultipleChoice, choicesFruits);
RPChoiceAnswerFormat answerFormatVeg = RPChoiceAnswerFormat.withParams(
    ChoiceAnswerStyle.MultipleChoice, choicesVeg);
RPChoiceAnswerFormat answerFormatCar = RPChoiceAnswerFormat.withParams(
    ChoiceAnswerStyle.MultipleChoice, choicesCar);

// Step
RPQuestionStep questionStep = RPQuestionStep.withAnswerFormat(
    'questionStepId', 'Select multiple', answerFormat);
RPQuestionStep questionStepFruits = RPQuestionStep.withAnswerFormat(
    'questionFuritsStepId', 'Select multiple', answerFormatFruits);
RPQuestionStep questionStepVeg = RPQuestionStep.withAnswerFormat(
    'questionVegStepId', 'Select multiple', answerFormatVeg);
RPQuestionStep questionStepCar = RPQuestionStep.withAnswerFormat(
    'questionCarStepId', 'Select multiple', answerFormatCar);

// Predicate
RPResultPredicate choicePredicate = RPResultPredicate.forChoiceQuestionResult(
    resultSelector: RPResultSelector.forStepId('questionStepId'),
    expectedValue: [1],
    choiceQuestionResultPredicateMode:
        ChoiceQuestionResultPredicateMode.Containing);
RPResultPredicate choicePredicateB = RPResultPredicate.forChoiceQuestionResult(
    resultSelector: RPResultSelector.forStepId('questionStepId'),
    expectedValue: [2],
    choiceQuestionResultPredicateMode:
        ChoiceQuestionResultPredicateMode.Containing);
RPResultPredicate choicePredicateC = RPResultPredicate.forChoiceQuestionResult(
    resultSelector: RPResultSelector.forStepId('questionStepId'),
    expectedValue: [3],
    choiceQuestionResultPredicateMode:
        ChoiceQuestionResultPredicateMode.Containing);
//Navigation Rules
RPPredicateStepNavigationRule navigationRule = RPPredicateStepNavigationRule(
  {
    choicePredicate: questionStepVeg.identifier,
    choicePredicateC: questionStepCar.identifier,
    choicePredicateB: dailyHealthQuestionInstruction.identifier,
  },
);

// RPStepReorganizerRule reorganizerRule =
//     RPStepReorganizerRule(questionStep.identifier, {
//   0: questionStepVeg.identifier,
//   1: questionStepCar.identifier,
// });

// RPPredicateStepNavigationRule navigationRuleC = RPPredicateStepNavigationRule(
//   {
//     choicePredicateC: questionStepCar.identifier,
//   },
// );

// Tasks
RPNavigableOrderedTask navigableSurveyTask5 =
    RPNavigableOrderedTask('navTaskId', [
  questionStep,
  questionStepVeg,
  questionStepCar,
  dailyHealthQuestionInstruction,
])
      ..setNavigationRuleForTriggerStepIdentifier(
          navigationRule, questionStep.identifier);
// ..setNavigationRuleForTriggerStepIdentifier(
//     navigationRuleC, questionStep.identifier);
