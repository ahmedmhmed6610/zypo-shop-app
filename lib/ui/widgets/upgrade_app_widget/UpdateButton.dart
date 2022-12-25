// import 'package:flutter/material.dart';
// import 'package:shop/ui/widgets/upgrade_app_widget/upgrade_widget.dart';
// import 'package:upgrader/upgrader.dart';
//
// class _UpdateButton extends StatelessWidget {
//   const _UpdateButton({
//     Key? key,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return UpgradeWidget(
//       upgrader: Upgrader(
//         //! This is a bit of a hack to allow the alert dialog to be shown
//         //! repeatedly.
//         durationUntilAlertAgain: const Duration(milliseconds: 500),
//         showReleaseNotes: false,
//         showIgnore: false,
//       ),
//       builder: (context, upgrader) => CircleAvatar(
//         child: IconButton(
//           onPressed: () {
//             upgrader.checkVersion(context: context);
//           },
//           icon: const Icon(Icons.upload),
//         ),
//       ),
//     );
//   }
// }
