import 'package:flutter/material.dart';
import 'package:research_package/research_package.dart';
import 'package:louisa_app/model/survey_onetime_objects.dart';
import 'dart:convert';

class OneTimeHealthScreen extends StatelessWidget {
  static const id = "one_time_health_screen";
  String _encode(Object object) =>
      const JsonEncoder.withIndent(' ').convert(object);

  void resultCallback(RPTaskResult result) {
    // Do anything with the result
    print(_encode(result));
  }

  void cancelCallBack(RPTaskResult result) {
    // Do anything with the result at the moment of the cancellation
    print("The result so far:\n" + _encode(result));
  }

  @override
  Widget build(BuildContext context) {
    return RPUITask(
      task: navigableSurveyTask,
      onSubmit: (result) {
        resultCallback(result);
      },
      onCancel: ([result]) {
        cancelCallBack(result);
      },
    );
  }
}

// class OneTimeHealthScreen extends StatelessWidget {
//   static const id = "one_time_health_screen";

//   String _encode(Object object) =>
//       const JsonEncoder.withIndent(' ').convert(object);

//   RPOrderedTask createTasks(RPTaskResult result) {
//     // Do anything with the resultList
//   void resultCallback(RPTaskResult result) {
//     // Do anything with the result
//     print(_encode(result));
//   }

//   void cancelCallBack(RPTaskResult result) {
//     // Do anything with the result at the moment of the cancellation
//     print("The result so far:\n" + _encode(result));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return RPUITask(
//       task: navigableSurveyTask,
//       onSubmit: (result) {
//         resultCallback(result);
//         // Navigator.push(
//         //   context,
//         //   MaterialPageRoute(builder: (context) => OneTimeHealthScreen2(result)),
//         // );
//       },
//       onCancel: ([result]) {
//         cancelCallBack(result);
//       },
//     );
//   }
// }
