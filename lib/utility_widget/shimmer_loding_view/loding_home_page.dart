import 'package:fixerking/utility_widget/shimmer_loding_view/shimmer_custom_widget.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class LodingHomePage extends StatelessWidget {
  const LodingHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 15),
            child: Shimmer.fromColors(
                baseColor: Color(0xffdddddd),
                highlightColor: Colors.white30,
                child: CustomWidget.rectangular(height: 90)),
            height: 90,
          ),
          ListView.builder(
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
              }),
        ],
      ),
    );
  }
}
