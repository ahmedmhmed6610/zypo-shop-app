
import 'package:flutter/material.dart';


class CirclerProgressIndicatorWidget extends StatelessWidget {
   CirclerProgressIndicatorWidget({Key? key, required this.isLoading}) : super(key: key);
   bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isLoading,
      child: Container(
          decoration: const BoxDecoration(
            // image: DecorationImage(
            //     image: AssetImage(Assets
            //         .imagesBackgroundRequestReviewFatora),
            //     fit: BoxFit.contain),
              color: Colors.transparent),
          child: const Center(
              child: CircularProgressIndicator(
                color: Colors.red,
              ))),
    );
  }
}
