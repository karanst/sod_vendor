
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sizer/sizer.dart';
import 'colors.dart';

class Common{
  toast(String msg){
    return Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: AppColor().colorPrimary(),
        textColor: AppColor().colorTextPrimary(),
        fontSize: 16.sp,
    );
  }

}