
import 'dart:convert';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:fixerking/screen/Add%20Services%20Products/products_services_screen.dart';
import 'package:fixerking/screen/auth_view/verify_otp.dart';
import 'package:fixerking/screen/home_screen.dart';
import 'package:fixerking/screen/manage_Service.dart';
import 'package:fixerking/screen/profile/profile.dart';
import 'package:fixerking/screen/profile_screen.dart';
import 'package:fixerking/screen/verify_otp.dart';
import 'package:fixerking/token/token_string.dart';
import 'package:fixerking/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BottomBarDelivery extends StatefulWidget {
  final String? type, bookingId;
  final int? index;
  const BottomBarDelivery({Key? key, this.type, this.bookingId, this.index}) : super(key: key);

  @override
  State<BottomBarDelivery> createState() => _BottomBarDeliveryState();
}

class _BottomBarDeliveryState extends State<BottomBarDelivery> {

  int _currentIndex = 0;
  var _selBottom = 0;

  List<dynamic> _handlePages =
  [ HomeScreen(), ProductsServicesScreen(),  ManageService(), Profile() ];


  @override
  void initState() {
    if(widget.index != null){
      setState(() {
        currentIndex = widget.index!;
      });
    }
    // getUserDataFromPrefs();
    super.initState();
    getUserDataFromPrefs();

  }
  String? type ;


  getUserDataFromPrefs() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    // String? userDataStr =
    // preferences.getString(SharedPreferencesKey.LOGGED_IN_USERRDATA);
    type = preferences.getString(TokenString.type);
    // Map<String, dynamic> userData = json.decode(userDataStr!);
    // print(userData);

    setState(() {
      // userID = userData['user_id'];
    });
  }

  int currentIndex = 0;
  bool isLoading = false;

  Widget _getBottomNavigator() {
    return Material(
      color: AppColor().colorTextSecondary(),
      //elevation: 2,
      child: CurvedNavigationBar(
        index: currentIndex,
        height: 50,
        backgroundColor: AppColor().colorGreyLight(),
        // backgroundColor: Color(0xfff4f4f4),
        items: <Widget>[
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: ImageIcon(
              AssetImage(
                  _currentIndex == 0 ?
                  'images/icons/home_fill.png'
                      : 'images/icons/home_fill.png'),
              color: AppColor().colorPrimary(),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(4.0),
            child: ImageIcon(
              AssetImage(
                  _currentIndex == 1?
                  'images/icons/product_fill.png'
                      : 'images/icons/product.png'),
              color: AppColor().colorPrimary(),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(4.0),
            child: ImageIcon(
              AssetImage(
                  _currentIndex == 2?
                  'images/icons/booking_fill.png'
                      : 'images/icons/booking.png'),
              color: AppColor().colorPrimary(),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(4.0),
            child: ImageIcon(
              AssetImage(
                  _currentIndex == 3 ?
                  'images/icons/profile_fill.png'
                      : 'images/icons/profile.png'),
              color: AppColor().colorPrimary(),
            ),
          ),

        ],
        onTap: (index) {
          print("current index here ${index}");
          setState(() {
            _currentIndex = index;
            _selBottom = _currentIndex;
            print("sel bottom ${_selBottom}");
            //_pageController.jumpToPage(index);
          });
        },
      ),
    );
  }

  Widget _getBottomNavigatorDelivery() {
    return Material(
      color: AppColor().colorTextSecondary(),
      //elevation: 2,
      child: CurvedNavigationBar(
        index: currentIndex,
        height: 50,
        backgroundColor: AppColor().colorGreyLight(),
        // backgroundColor: Color(0xfff4f4f4),
        items: <Widget>[
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: ImageIcon(
              AssetImage(
                  _currentIndex == 0 ?
                  'images/icons/home_fill.png'
                      : 'images/icons/home_fill.png'),
              color: AppColor().colorPrimary(),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(4.0),
            child: ImageIcon(
              AssetImage(
                  _currentIndex == 1?
                  'images/icons/booking_fill.png'
                      : 'images/icons/booking_fill.png'),
              color: AppColor().colorPrimary(),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(4.0),
            child: ImageIcon(
              AssetImage(
                  _currentIndex == 2 ?
                  'images/icons/profile_fill.png'
                      : 'images/icons/profile_fill.png'),
              color: AppColor().colorPrimary(),
            ),
          ),

        ],
        onTap: (index) {
          print("current index here ${index}");
          setState(() {
            _currentIndex = index;
            _selBottom = _currentIndex;
            print("sel bottom ${_selBottom}");
            //_pageController.jumpToPage(index);
          });
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<dynamic> _handlePagesDelivery = [
      HomeScreen(bookingId: widget.bookingId,),  ManageService(index: 0,isIcon: false,), Profile()
    ];
    return
      WillPopScope(
        onWillPop: () async {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Confirm Exit"),
              content: Text("Are you sure you want to exit?"),
              actions: <Widget>[
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: AppColor().colorPrimary()
                  ),
                  child: Text("YES"),
                  onPressed: () {
                    SystemNavigator.pop();
                  },
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: AppColor().colorPrimary()
                  ),
                  child: Text("NO"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            );
          }
      );
      return true;
    },
    child:

      Scaffold(
        body:
        // type == "2" || type == "3" || type == "4" ?
        _handlePagesDelivery[_currentIndex],
            // : _handlePages[_currentIndex],
        bottomNavigationBar:
        // type == "2" || type == "3" || type == "4" ?
        _getBottomNavigatorDelivery()
    )
      );
  }
}
