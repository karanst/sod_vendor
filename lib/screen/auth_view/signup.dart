
import 'package:fixerking/screen/auth_view/login.dart';
import 'package:fixerking/screen/auth_view/registration.dart';
import 'package:fixerking/utils/app_button.dart';
import 'package:fixerking/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';


class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  var mobileController =TextEditingController();
  final _formKey = GlobalKey<FormState>();

  var dropdownValue;

  var items = [
    'Restaurants / Hotels / Cafes',
    'Bike',
    '3 wheeler',
    '4 wheeler',
    'Mehendi Artist',
    'Event Planner',
    'Handy Man Services',
  ];
  LocationPermission? permission;
  Position? currentLocation;
  double? lat, long;
  Future getUserCurrentLocation() async {
    permission = await Geolocator.requestPermission();
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((position) {
      if (mounted)
        setState(() {
          currentLocation = position;
          lat = currentLocation!.latitude;
          long = currentLocation!.longitude;
        });
    });
    print("LOCATION===" + currentLocation.toString());
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserCurrentLocation();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.PrimaryDark,
      body: SingleChildScrollView(
          child:Form(
            key: _formKey,
            child: Column(
              children: [
                Container(
                  height: 25,
                  color: AppColor().colorBg1(),
                ),
              Image.asset(
              'images/splash_bg.png',
              // 'assets/images/login_logo.png',
              fit: BoxFit.fill,
            ),


                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height - 100,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(
                                'images/Splashscreen.png'
                            ),
                          fit: BoxFit.contain
                        ),

                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 40.0, bottom: 40),
                          child: Text(
                            "Sign Up",
                            style: TextStyle(
                                fontSize: 30,
                                color: AppColor().colorBg1(),
                                fontWeight: FontWeight.w500),
                          ),
                        ),


                        Padding(
                          padding: const EdgeInsets.only(left: 15.0, right: 15),
                          child: Container(
                              padding: EdgeInsets.only(right: 12,left: 12, top: 12),
                            height: 60,
                            width: MediaQuery.of(context).size.width,
                            decoration:
                            BoxDecoration(
                              color: AppColor().colorBg1(),
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all( color: AppColor().colorSecondary(),),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                hint: Text("Select Vendor Type",
                                style: TextStyle(
                                  color: AppColor().colorPrimary()
                                ),),
                                dropdownColor: AppColor().colorBg1(),
                                value: dropdownValue,
                                icon:  Padding(
                                  padding: const EdgeInsets.only(bottom: 8.0),
                                  child: Icon(Icons.keyboard_arrow_down_rounded,  color: AppColor().colorPrimary(),),
                                ),
                                elevation: 16,
                                style:  TextStyle(color: AppColor().colorPrimary(),fontWeight: FontWeight.bold),
                                underline: Container(
                                  // height: 2,
                                  color:  AppColor().colorPrimary(),
                                ),
                                onChanged: (String? value) {
                                  // This is called when the user selects an item.
                                  setState(() {
                                    dropdownValue = value!;
                                  });
                                },
                                items: items
                                    .map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child:
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(value),
                                        Divider(
                                          thickness: 2,
                                          color: AppColor().colorPrimary(),
                                        )
                                      ],
                                    ),
                                  );
                                }).toList(),
                              ),

                            )

                            // DropdownButtonHideUnderline(
                            //   child: DropdownButton(
                            //     // isExpanded: true,
                            //     value: dropdownvalue,
                            //     icon: const Icon(Icons.keyboard_arrow_down,size: 35,),
                            //     elevation: 10,
                            //     onChanged: (String? value) {
                            //       setState(() {
                            //         dropdownvalue = value!;
                            //       });
                            //       print("this is dropdown value ==========>$value");
                            //     },
                            //     items: items.map<DropdownMenuItem<String>>((String value) {
                            //       return DropdownMenuItem<String>(
                            //         value: value,
                            //         child: Text(value),
                            //       );
                            //     }).toList(),
                            //   ),
                            // ),
                          ),
                        ),
                        // TextFormField(
                        //   validator: (msg){
                        //     if (msg! .isEmpty){
                        //       return "please enter your name";}
                        //   },
                        //   decoration: InputDecoration(
                        //       hintText: "Your Name"),
                        // ),
                        // SizedBox(
                        //   height: 20,
                        // ),
                        // TextFormField(
                        //   validator: (msg){
                        //     if (msg! .isEmpty){
                        //       return "please enter valid email";}
                        //   },
                        //   keyboardType:TextInputType.emailAddress,
                        //   decoration: InputDecoration(
                        //       hintText: "Email"),
                        // ),
                        // SizedBox(
                        //   height: 20,
                        // ),
                        // TextFormField(
                        //   validator: (msg) {
                        //     if(msg!.isEmpty ){
                        //       return"Please Enter Number " ;}
                        //     if(msg.length!=10){
                        //       return "Please Enter valid Number" ;
                        //     }
                        //   },
                        //   decoration: InputDecoration(
                        //       hintText: ' Mobil no.'
                        //   ),
                        // ),
                        // SizedBox(
                        //   height: 20,
                        // ),
                        // TextFormField(
                        //   validator: (msg) {
                        //     if(msg!.isEmpty ){
                        //       return"Please Enter Valid Password " ;}
                        //     if(msg.length!=10){
                        //       return "Please Enter valid Password" ;
                        //     }
                        //   },
                        //   decoration: InputDecoration(
                        //       hintText: 'Password'
                        //   ),
                        // ),
                        // SizedBox(
                        //   height: 20,
                        // ),
                        // TextFormField(
                        //   validator: (msg){
                        //     if (msg! .isEmpty){
                        //       return "please enter valid Password";}
                        //   },
                        //   keyboardType:TextInputType.emailAddress,
                        //   decoration: InputDecoration(
                        //       hintText: "Confirm Password"),
                        // ),
                        SizedBox(
                          height: 60,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 15.0, right: 15),
                          child: AppBtn(
                            label: "Submit",
                            onPress: (){
                              if (dropdownValue == null || dropdownValue == "") {
                                Fluttertoast.showToast(msg: "Please select vendor type");
                              }else{
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) =>
                                        VendorRegisteration(
                                          role: dropdownValue.toString(),
                                          lat: lat,
                                          long: long,
                                        )));

                              }
                            },
                          ),
                        ),
                        // ElevatedButton(
                        //   onPressed: (){
                        //   if (_formKey.currentState!.validate())
                        //     Navigator.push(context, MaterialPageRoute(builder: (context)=> VendorRegisteration(
                        //       role: dropdownValue.toString(),
                        //     )));
                        // },
                        //   child:
                        //   Text("Submit", style: TextStyle(fontSize: 18, color: AppColor().colorPrimary(),),),
                        //   style: ElevatedButton.styleFrom(
                        //     elevation: 0,
                        //     primary: AppColor().colorBg1(),
                        //     shape: RoundedRectangleBorder(
                        //       borderRadius: BorderRadius.circular(15),
                        //     ),
                        //     fixedSize: Size(320, 45),
                        //   ),
                        // ),
                        SizedBox(height: 30,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Already have an account? ",style: TextStyle(fontWeight: FontWeight.w400,  color: AppColor().colorBg1(), fontSize: 16),),
                            GestureDetector(
                              //   onTap: (){},
                              child: Text("Log in",style: TextStyle(color: AppColor().colorBg1(),fontSize: 16, decoration: TextDecoration.underline, fontWeight: FontWeight.w600),),
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context) =>Login()));
                              },
                            ),
                          ],
                        )
                        // InkWell(
                        //   onTap: () {
                        //     Navigator.push(
                        //         context,
                        //         MaterialPageRoute(
                        //             builder: (context) => verification()));
                        //   },
                        //
                        //   child: Container(
                        //     decoration: BoxDecoration(
                        //         color: Colors.blueAccent,
                        //         borderRadius: BorderRadius.circular(30.0)),
                        //     height: 50,
                        //     width: 300,
                        //     child: Center(
                        //       child: Text(
                        //         "SignUp",
                        //         style: TextStyle(
                        //             color: Colors.white,
                        //             fontWeight: FontWeight.bold,
                        //             fontSize: 18),
                        //       ),
                        //     ),
                        //   ),
                        //
                        //
                        // ),
                        //
                      ],
                    ),
                  ),
                ),
              ],
            ),)
      ),
    );
  }
}