import 'package:flutter/material.dart';
import 'package:research_package/research_package.dart';
import 'package:louisa_app/model/survey_daily_objects.dart';
import 'dart:convert';

class DailyHealthScreen extends StatelessWidget {
  static const id = "daily_health_screen";
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
      task: navigableDailyHealthSurveyTask,
      onSubmit: (result) {
        resultCallback(result);
      },
      onCancel: ([result]) {
        cancelCallBack(result);
      },
    );
  }
}
