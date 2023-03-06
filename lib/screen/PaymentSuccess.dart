import 'package:fixerking/screen/BottomBars/bottom_bar.dart';
import 'package:fixerking/screen/home_screen.dart';
import 'package:fixerking/utils/app_button.dart';
import 'package:fixerking/utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class PaymentSuccess extends StatefulWidget {
  const PaymentSuccess({Key? key}) : super(key: key);

  @override
  State<PaymentSuccess> createState() => _PaymentSuccessState();
}

class _PaymentSuccessState extends State<PaymentSuccess> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor().colorEdit(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: Image.asset("images/payment_icon.png"),
            ),
            Center(
              child: Text("Payment Successful",
                  style: TextStyle(fontSize: 25, color: AppColor().colorTextPrimary())),
            ),
            SizedBox(height: 10,),
            Text("Lorem ipusm dolor sit amet consectetuer elit, sed diam",
                style: TextStyle(fontSize: 15, color: AppColor().colorTextSecondary())
            ),
            SizedBox(height: 60,),
            AppBtn(
              size: MediaQuery.of(context).size.width -60,
              label: "Back to Home",
              onPress: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => BottomBar()));
              },
            ),
            // Container(
            //   height: 50,
            //   width: MediaQuery.of(context).size.width/ 1.2,
            //   decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: AppColor.PrimaryDark),
            //   child: InkWell(
            //     onTap: () {
            //       Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
            //     },
            //       child: Center(child: Text("Back to Home", style: TextStyle(fontSize: 20, color: AppColor().colorBg1())))),)
          ],
        ),
      ),
    );
  }
}
