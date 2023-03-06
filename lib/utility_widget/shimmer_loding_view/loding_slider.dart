import 'package:fixerking/utility_widget/shimmer_loding_view/shimmer_custom_widget.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class LodingSliderView extends StatefulWidget {
  const LodingSliderView({Key? key}) : super(key: key);

  @override
  _LodingSliderViewState createState() => _LodingSliderViewState();
}

class _LodingSliderViewState extends State<LodingSliderView> {
  @override
  Widget build(BuildContext context) {
    var Mysize = MediaQuery.of(context).size;
    return Container(
        width: Mysize.width * 0.9,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(30.0)),
        child: Card(
            elevation: 8.0,
            child: Shimmer.fromColors(
              baseColor: Color(0xffdddddd),
              highlightColor: Colors.white30,
              child: CustomWidget.rectangular(height: 130),
            )));
  }
}
