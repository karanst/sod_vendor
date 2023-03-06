import 'dart:convert';

import 'package:fixerking/api/api_path.dart';
import 'package:fixerking/screen/profile/edit_profile.dart';
import 'package:fixerking/screen/profile/edit_service_profile.dart';
import 'package:fixerking/token/token_string.dart';
import 'package:fixerking/utils/app_button.dart';
import 'package:fixerking/utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../new model/GetProfileModel.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  bool change = true;
  @override
  void setState(VoidCallback fn) {
    super.setState(fn);
    print(change);
  }

  void initState() {
    super.initState();
    // checkingLogin();
    Future.delayed(Duration(milliseconds: 500), () {
      return getProfile();
    });
  }

  GetProfileModel? profileModel;

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor().colorPrimary(),
      appBar: AppBar(
        backgroundColor: AppColor().colorPrimary(),
        elevation: 0,
        centerTitle: true,
        title: Text("Profile"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Padding(
                    padding: const EdgeInsets.only(top: 40),
                    child: Container(
                      padding: EdgeInsets.only(top: 5),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: AppColor().colorSecondary(),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(45),
                            topRight: Radius.circular(45),
                          )),
                      child: Container(
                          height:
                              MediaQuery.of(context).size.height + 150 ,
                          width: MediaQuery.of(context).size.width,
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(45),
                                topRight: Radius.circular(45),
                              )),
                          child: Padding(
                            padding:
                                const EdgeInsets.only(left: 30.0, right: 30),
                            child: profileModel == null
                                ? Center(
                                    child: Center(
                                        child: Container(
                                      height: 30,
                                      width: 30,
                                      child: CircularProgressIndicator(
                                        color: colors.primary,
                                      ),
                                    )),
                                  )
                                : Container(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          height: MediaQuery.of(context)
                                              .size
                                              .height *
                                              .1,
                                        ),
                                        Text(
                                          "${profileModel!.data![0].uname}",
                                          style: TextStyle(fontSize: 25),
                                        ),
                                        SizedBox(
                                          height: 30,
                                        ),
                                        Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text("Name:",
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.w600
                                                  ),),
                                                SizedBox(
                                                  height: 15,
                                                ),
                                                Text("Email:",
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.w600
                                                  ),),
                                                SizedBox(
                                                  height: 15,
                                                ),
                                                Text("Mobile Number:",
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.w600
                                                  ),),
                                                SizedBox(
                                                  height: 15,
                                                ),
                                                type == "2"|| type == "3"|| type =="4"?
                                                    SizedBox.shrink()
                                              :  Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      type == "1" ? "Store Name:"
                                                          : "Company Name",
                                                      style: TextStyle(
                                                          fontWeight: FontWeight.w600
                                                      ),),
                                                    SizedBox(
                                                      height: 15,
                                                    ),
                                                    Text("GST  Number:",
                                                      style: TextStyle(
                                                          fontWeight: FontWeight.w600
                                                      ),),
                                                    SizedBox(
                                                      height: 15,
                                                    ),
                                                  ],
                                                ),
                                                type == "1" ?
                                                Text("FSSAI No.:",
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.w600
                                                  ),)
                                                : SizedBox.shrink(),
                                                   SizedBox(
                                                  height: type == "1" ? 15 : 0,
                                                ),
                                                type == "1" ?
                                                Text(
                                                  "Store Description:",
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.w600
                                                  ),)
                                                : SizedBox.shrink(),
                                                SizedBox(
                                                  height: type == "1" ? 15: 0,
                                                ),
                                                Text("Address:",
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.w600
                                                  ),),

                                                SizedBox(
                                                  height: 50,
                                                ),
                                                // Text("Bank Details:",
                                                //   style: TextStyle(
                                                //       fontWeight: FontWeight.w600
                                                //   ),),
                                                // SizedBox(
                                                //   height: 15,
                                                // ),
                                                Text("Aadhaar Card:",
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.w600
                                                  ),),
                                                SizedBox(
                                                  height: 50,
                                                ),
                                                Text("Pan Card:",
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.w600
                                                  ),),

                                                SizedBox(
                                                  height: 50,
                                                ),
                                                Text("Bank Details:",
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.w600
                                                  ),),
                                                SizedBox(
                                                  height: 10,
                                                )
                                              ],
                                            ),
                                            Column(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                    "${profileModel!.data![0].uname}"),
                                                SizedBox(
                                                  height: 15,
                                                ),
                                                Text(
                                                    "${profileModel!.data![0].email}"),
                                                SizedBox(
                                                  height: 15,
                                                ),
                                                Text(
                                                    "${profileModel!.data![0].mobile}"),
                                                SizedBox(
                                                  height: 15,
                                                ),
                                                type == "2"|| type == "3"|| type =="4"?
                                                SizedBox.shrink()
                                                    :
                                                    Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Text(type == "1"?
                                                        "${profileModel!.data![0].storeName}"
                                                            : "${profileModel!.data![0].companyName}"),
                                                        SizedBox(
                                                          height: 15,
                                                        ),
                                                        Text(
                                                          "${profileModel!.data![0].gstNo}",
                                                          // maxLines: 3,
                                                          style: TextStyle(
                                                              overflow:
                                                              TextOverflow
                                                                  .ellipsis),
                                                        ),
                                                        SizedBox(
                                                          height: 15,
                                                        ),
                                                      ],
                                                    ),

                                             type == "1"?  Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "${profileModel!.data![0].fssai}",
                                                    // maxLines: 3,
                                                    style: TextStyle(
                                                        overflow:
                                                        TextOverflow
                                                            .ellipsis),
                                                  ),
                                                  SizedBox(
                                                    height: 15,
                                                  ),
                                                  Text(
                                                    "${profileModel!.data![0].storeDescription}",
                                                    // maxLines: 3,
                                                    style: TextStyle(
                                                        overflow:
                                                        TextOverflow
                                                            .ellipsis),
                                                  ),
                                                  SizedBox(
                                                    height: 15,
                                                  ),
                                                ],
                                              )
                                                : SizedBox.shrink(),

                                                Container(
                                                    width: 170,
                                                    child: Text(
                                                      "${profileModel!.data![0].address}",
                                                      maxLines: 3,
                                                      style: TextStyle(
                                                          overflow:
                                                          TextOverflow
                                                              .ellipsis),
                                                    )),
                                                SizedBox(
                                                  height: 5,
                                                ),

                                                SizedBox(
                                                  height: 15,
                                                ),
                                                profileModel!.data![0]
                                                    .adharCard ==
                                                    null ||
                                                    profileModel!.data![0]
                                                        .adharCard ==
                                                        ""
                                                    ? SizedBox.shrink()
                                                    : Container(
                                                    height: 50,
                                                    width: 80,
                                                    child: ClipRRect(
                                                        borderRadius:
                                                        BorderRadius
                                                            .circular(
                                                            6),
                                                        child:
                                                        Image.network(
                                                          "${profileModel!.data![0].adharCard.toString()}",
                                                          fit:
                                                          BoxFit.fill,
                                                        ))),

                                                SizedBox(
                                                  height: 15,
                                                ),
                                                profileModel!.data![0]
                                                    .pancard ==
                                                    null ||
                                                    profileModel!.data![0]
                                                        .pancard ==
                                                        ""
                                                    ? SizedBox.shrink()
                                                    : Container(
                                                    height: 50,
                                                    width: 80,
                                                    child: ClipRRect(
                                                        borderRadius:
                                                        BorderRadius
                                                            .circular(
                                                            6),
                                                        child:
                                                        Image.network(
                                                          "${profileModel!.data![0].pancard.toString()}",
                                                          fit:
                                                          BoxFit.fill,
                                                        ))),

                                              ],
                                            )
                                          ],
                                        ),
                                        bankDetails == null || bankDetails == "" ?
                                            SizedBox.shrink():
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [

                                            bankDetails['UPI'] == null || bankDetails['UPI'] == "" ?
                                                SizedBox.shrink():
                                            Row(
                                              children: [
                                                Text("UPI : ${bankDetails['UPI'].toString()}")
                                              ],
                                            ),

                                            bankDetails['account_number'] == null ||  bankDetails['account_number'] == ""?
                                            SizedBox.shrink()
                                            :  Padding(
                                              padding: const EdgeInsets.only(right: 40.0),
                                              child: Column(
                                                children: [
                                                  Row(
                                                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Text("Account Number : ",
                                                        style: TextStyle(
                                                            fontWeight: FontWeight.w600
                                                        ),),
                                                      const SizedBox(width: 10,),
                                                      Text(bankDetails['account_number'].toString())
                                                    ],
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.only(top:8.0, bottom: 8),
                                                    child: Row(
                                                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Text("Account Holder Name : ",
                                                          style: TextStyle(
                                                              fontWeight: FontWeight.w600
                                                          ),),
                                                        const SizedBox(width: 10,),
                                                        Text(bankDetails['account_holder_name'].toString())
                                                      ],
                                                    ),
                                                  ),
                                                  Row(
                                                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Text("Bank Name : ",
                                                        style: TextStyle(
                                                            fontWeight: FontWeight.w600
                                                        ),),
                                                      const SizedBox(width: 10,),
                                                      Text(bankDetails['bank_name'].toString())
                                                    ],
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.only(top: 8.0, bottom: 8),
                                                    child: Row(
                                                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Text("IFSC Code : ",
                                                          style: TextStyle(
                                                              fontWeight: FontWeight.w600
                                                          ),),
                                                        const SizedBox(width: 10,),
                                                        Text(bankDetails['ifsc_code'].toString())
                                                      ],
                                                    ),
                                                  ),
                                                  Row(
                                                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Text("Account Type : ",
                                                      style: TextStyle(
                                                        fontWeight: FontWeight.w600
                                                      ),),
                                                      const SizedBox(width: 10,),
                                                      Text(bankDetails['account_type'].toString())
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 25,
                                        ),
                                        AppBtn(
                                          onPress: () async {
                                            var result = await  Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (
                                                          context) =>
                                                          EditNewProfile(
                                                            model: profileModel!
                                                                .data![
                                                            0],
                                                            upi:
                                                            bankDetails['UPI'] == ""|| bankDetails['UPI'] == null ?
                                                                "" :bankDetails['UPI']
                                                            ,
                                                            bankName: bankDetails['bank_name'] == ""|| bankDetails['bank_name'] == null ?
                                                            ""
                                                            : bankDetails['bank_name'],
                                                            accNo: bankDetails['account_number'] == ""|| bankDetails['account_number'] == null ?
                                                            ""
                                                                : bankDetails['account_number'],
                                                            accHolderName: bankDetails['account_holder_name'] == ""|| bankDetails['account_holder_name'] == null ?
                                                            ""
                                                                : bankDetails['account_holder_name'],
                                                            ifsc:  bankDetails['ifsc_code'] == ""|| bankDetails['ifsc_code'] == null ?
                                                            "" : bankDetails['ifsc_code'],
                                                            accountType :bankDetails['account_type'] == ""|| bankDetails['account_type'] == null ?
                                                            "Savings" : bankDetails['account_type'],
                                                          )));

                                            if(result = true){
                                             await getProfile();
                                            }

                                          },
                                          label: "Edit Profile",
                                        ),

                                        SizedBox(
                                          height: 10,
                                        ),



                                      ],
                                    ),
                                  ),
                          )),
                    )),
                Positioned(
                  top: 0,
                  // left: MediaQuery.of(context).size.width * .38,
                  child: Center(
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10)),
                        height: 100,
                        width: 100,
                        child: profileModel == null
                            ? Center(
                                child: Icon(Icons.person),
                              )
                            : ClipRRect(
                                borderRadius: BorderRadius.circular(6),
                                child: Image.network(
                                  "${profileModel!.data![0].profileImage}",
                                  fit: BoxFit.fill,
                                ),
                              ),
                        // ClipRRect(
                        //   borderRadius: BorderRadius.circular(200),
                        //   child: Image.network("${getProfilenew![0].profileImage}"),
                        // )
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String? uid;
  String? type;
  var bankDetails;

  getProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? uid = prefs.getString(TokenString.userid);
    type =prefs.getString(TokenString.type);

    var headers = {
      'Cookie': 'ci_session=3ab2e0bfe4c2535c351d13c7ca58f780dce6aa8f'
    };
    var request = http.MultipartRequest('POST',
        Uri.parse('${Apipath.getProfileApi}'));
    request.fields.addAll({
      'vid': '${uid.toString()}'
      //'$uid'
    });
    print("this is request =====>>>>> ${request.fields.toString()}");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      print("this response @@ ${response.statusCode}");
      final str = await response.stream.bytesToString();
      bankDetails = jsonDecode(str)['data'][0]['band_details'];
      var result = GetProfileModel.fromJson(json.decode(str));
      setState(() {
        profileModel = result;

      });
      return GetProfileModel.fromJson(json.decode(str));
    } else {
      return null;
    }
  }
}
