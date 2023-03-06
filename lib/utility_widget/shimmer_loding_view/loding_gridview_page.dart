import 'package:fixerking/utility_widget/shimmer_loding_view/shimmer_custom_widget.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class LodingGridView extends StatefulWidget {
  LodingGridView({Key? key}) : super(key: key);

  @override
  _LodingGridViewState createState() => _LodingGridViewState();
}

class _LodingGridViewState extends State<LodingGridView> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.90,
            mainAxisSpacing: 10.0,
            crossAxisSpacing: 10.0,
          ),
          itemCount: 8,
          itemBuilder: (BuildContext context, int index) {
            return Shimmer.fromColors(
                baseColor: Color(0xffdddddd),
                highlightColor: Colors.white30,
                child: Card(
                  elevation: 5.0,
                  child: CustomWidget.rectangular(height: 50),
                ));
          }),
    );
  }
}
