import 'package:fixerking/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class MYDialog {
  static showAlertDialogWithTwobtn(BuildContext context,
      {String? title, String? body, String? bta, Function? funtionName}) {
    Widget oknot = TextButton(
      child: Text("No"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        var mysize = MediaQuery.of(context).size;
        return Material(
          color: Colors.transparent,
          child: Center(
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(60),
                  bottomLeft: Radius.circular(60)),
              child: Container(
                height: mysize.height * 0.28,
                width: mysize.height * 0.4,
                decoration: BoxDecoration(color: Colors.white),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          child: Text(
                        title!,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20.0.sp,
                            fontWeight: FontWeight.bold),
                      )),
                      Container(
                          margin: EdgeInsets.only(bottom: 10.0, top: 10.0),
                          child: Text(
                            body!,
                            style: TextStyle(
                                color: Colors.black, fontSize: 10.0.sp),
                          )),
                      // butn
                      Spacer(),
                      Container(
                        margin: EdgeInsets.only(bottom: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Container(
                                height: 30,
                                width: 60,
                                alignment: Alignment.center,
                                child: Text(
                                  "NO",
                                  style: TextStyle(color: Colors.white),
                                ),
                                decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(20.0)),
                              ),
                            ),
                            InkWell(
                              onTap: () => funtionName!(),
                              child: Container(
                                height: 30,
                                width: 60,
                                alignment: Alignment.center,
                                margin: EdgeInsets.only(left: 20),
                                child: Text(
                                  "YES",
                                  style: TextStyle(color: Colors.white),
                                ),
                                decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(20.0)),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  static loadingDialog(BuildContext context) {
    var Mysize = MediaQuery.of(context).size;
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Material(
          color: Colors.transparent,
          child: new Stack(
            children: <Widget>[
              new Container(
                alignment: AlignmentDirectional.center,
                decoration: new BoxDecoration(
                  color: Colors.white70,
                ),
                child: new Container(
                  decoration: new BoxDecoration(
                      color: AppColor.PrimaryDark,
                      borderRadius: new BorderRadius.circular(10.0)),
                  width: 300.0,
                  height: 200.0,
                  alignment: AlignmentDirectional.center,
                  child: new Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      new Center(
                        child: new SizedBox(
                          height: 50.0,
                          width: 50.0,
                          child: new CircularProgressIndicator(
                            value: null,
                            strokeWidth: 7.0,
                          ),
                        ),
                      ),
                      new Container(
                        margin: const EdgeInsets.only(top: 25.0),
                        child: new Center(
                          child: new Text(
                            "loading.. wait...",
                            style: new TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  static onTapShowSpaceGuide(context) {
    print("ddd");
    showDialog(
      context: context,
      builder: (BuildContext context) {
        var mysize = MediaQuery.of(context).size;
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Material(
                  color: Colors.transparent,
                  child: Container(
                    color: Colors.white,
                    margin:
                        EdgeInsets.symmetric(horizontal: mysize.height / 35.0),
                    padding: EdgeInsets.symmetric(
                      horizontal: mysize.width / 10.0,
                    ),
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(
                              vertical: mysize.height / 25),
                          decoration: BoxDecoration(
                              // boxShadow: [boxShadow.inputDecoration()],
                              border: Border.all(color: Colors.grey.shade300),
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5)),
                          child: Container(
                            width: mysize.width,
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                isExpanded: true,
                                iconEnabledColor:
                                    AppColor.PrimaryDark, // game changer
                                hint: Container(
                                    margin: EdgeInsets.only(left: 20.0),
                                    child: Text('Select Number Items')),
                                items: <String>['A', 'B', 'C', 'D']
                                    .map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: new Text(value),
                                  );
                                }).toList(),
                                onChanged: (_) {},
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )),
            ),
            // SizedBox(
            //   height: mysize.height / 25,
            // ),
            // ClipRRect(
            //   borderRadius: BorderRadius.circular(60),
            //   child: Material(
            //       child: InkWell(
            //     onTap: () {
            //       Navigator.pop(context);
            //     },
            //     child: ClipRRect(
            //       borderRadius: BorderRadius.circular(60),
            //       child: Container(
            //           // margin: EdgeInsets.only(top: mysize.height / 10),
            //           decoration: BoxDecoration(
            //               color: Colors.white, shape: BoxShape.circle),
            //           height: mysize.height / 7,
            //           width: mysize.width / 4,
            //           child: Icon(
            //             Icons.clear_rounded,
            //             size: mysize.height / 20,
            //           )),
            //     ),
            //   )),
            // )
          ],
        );
      },
    );
  }

  static showBottomSheet(BuildContext context) {
    return showModalBottomSheet<void>(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: 200,
            color: Colors.amber,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const Text('Modal BottomSheet'),
                  ElevatedButton(
                    child: const Text('Close BottomSheet'),
                    onPressed: () => Navigator.pop(context),
                  )
                ],
              ),
            ),
          );
        });
  }
}
