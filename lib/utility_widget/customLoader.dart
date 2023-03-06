import 'package:fixerking/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class CustomLoader extends StatelessWidget {

  final String? text;
  CustomLoader({this.text});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("${text}"),
          SizedBox(height: 8,),
          Center(
            child: Container(
            height: 30,
            width: 30,
            child: CircularProgressIndicator(
              color: colors.primary,
            ),
          )),
        ],
      ),
    );
  }
}

Widget loadingWidget(){
  return  Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text("Loading  ",
        style: TextStyle(
            fontSize: 18,
            color: AppColor().colorPrimary()
        ),),
      Center(
        child: LoadingAnimationWidget.staggeredDotsWave(
          color: AppColor().colorPrimary(),
          size: 30,
        ),
      ),
    ],
  );
}