import 'package:fixerking/utils/colors.dart';
import 'package:flutter/material.dart';
class AppBtn extends StatelessWidget {
  final String? label;
  final double? size;
  final VoidCallback? onPress;
  const AppBtn({Key? key, this.label, this.onPress, this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Container(
          height: 43,
          width:  size,
          // MediaQuery.of(context).size.width/ 1.2,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: AppColor().colorSecondary()),
          child: Center(child: Text("${label.toString()}", style: TextStyle(fontSize: 18, color: AppColor.PrimaryDark)))
      ),
    );
  }
}
