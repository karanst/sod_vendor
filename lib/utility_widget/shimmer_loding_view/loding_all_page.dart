import 'package:fixerking/utility_widget/shimmer_loding_view/loding_slider.dart';
import 'package:fixerking/utility_widget/shimmer_loding_view/shimmer_custom_widget.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class LodingAllPage extends StatefulWidget {
  const LodingAllPage({Key? key}) : super(key: key);

  @override
  _LodingAllPageState createState() => _LodingAllPageState();
}

class _LodingAllPageState extends State<LodingAllPage> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        physics: ScrollPhysics(),
        itemCount: 10,
        itemBuilder: (BuildContext context, int index) {
          return Shimmer.fromColors(
              baseColor: Color(0xffdddddd),
              highlightColor: Colors.white30,
              child: ListTile(
                // leading: CustomWidget.circular(height: 64, width: 64),
                title: Align(
                  alignment: Alignment.centerLeft,
                  child: CustomWidget.rectangular(
                    height: 40,
                    width: MediaQuery.of(context).size.width * 0.5,
                  ),
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: CustomWidget.rectangular(height: 30),
                ),
              ));
        });
  }
}
