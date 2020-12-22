import 'package:flutter/material.dart';
import 'package:research_package/research_package.dart';
import 'package:louisa_app/model/survey_daily_objects.dart';
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';

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

  void launchUrl(String url) async {
    if (await canLaunch(url)) {
      launch(url);
    } else {
      throw "Could not launch $url";
    }
  }

  @override
  Widget build(BuildContext context) {
    return RPUITask(
      task: navigableDailyHealthSurveyTask,
      onSubmit: (result) {
        print('pressed');
        // resultCallback(result);
        // Navigator.of(context).pop();
        // Navigator.pushNamed(context, Test.id);

        // launchUrl('tel:+19842207351');

        // if Chest pain/heart palpitations or shortness of breath
        // You should call 911[hyperlink] right away
        // if Yes to Other condition
        // A medical consultation may be advisable. Would you like to call DOCTOR’S NAME?
      },
      onCancel: ([result]) {
        cancelCallBack(result);
      },
    );
  }
}

// Future _call911Dialog(BuildContext context) async {
//   return showDialog(
//       context: context,
//       barrierDismissible: true,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text('Call 911?'),
//           content: RichText(
//             text: TextSpan(
//               style: TextStyle(color: Colors.blue),
//               recognizer: TapGestureRecognizer()
//                 ..onTap = () async {
//                   final url = 'https://github.com/flutter/gallery/';
//                   if (await canLaunch(url)) {
//                     await launch(
//                       url,
//                       forceSafariVC: false,
//                     );
//                   }
//                 },
//             ),
//           ),
//         );
//       });
// }

// enum ConfirmAction { CANCEL, ACCEPT }

// Future _asyncConfirmDialog(BuildContext context) async {
//   return showDialog(
//     context: context,
//     barrierDismissible: false, // user must tap button for close dialog!
//     builder: (BuildContext context) {
//       return AlertDialog(
//         title: Text(''),
//         content: const Text(
//           'If you are 18 years of age or older and would like to enter '
//           'your health information, we will let you know how your symptoms '
//           'compare to others in the community as well as informing you about '
//           'the environment.',
//         ),
//         actions: [
//           FlatButton(
//             child: const Text('CANCEL'),
//             onPressed: () {
//               Navigator.of(context).pop(ConfirmAction.CANCEL);
//               // Navigator.pushNamed(context, WelcomeScreen.id);
//             },
//           ),
//           FlatButton(
//             child: const Text('ACCEPT'),
//             onPressed: () {
//               Navigator.of(context).pop(ConfirmAction.ACCEPT);
//               // Navigator.pushNamed(context, SignUpScreen.id);
//             },
//           )
//         ],
//       );
//     },
//   );
// }
