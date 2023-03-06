import 'dart:convert';

import 'package:fixerking/api/api_path.dart';
import 'package:fixerking/new%20model/wallet_transactions_model.dart';
import 'package:fixerking/token/token_string.dart';
import 'package:fixerking/utils/app_button.dart';
import 'package:fixerking/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../new model/GetProfileModel.dart';

class Wallet extends StatefulWidget {
  const Wallet({Key? key}) : super(key: key);

  @override
  State<Wallet> createState() => _WalletState();
}

class _WalletState extends State<Wallet> {
  bool change = true;
  @override
  void setState(VoidCallback fn) {
    super.setState(fn);
    print(change);
  }

  String? uid;
  String? type;
  String? wallet;
  String? referralCode;
  String? userName;
  bool show = false;
  bool isUpi = false;
  int? _value = 1;

  TextEditingController accountHolderController = TextEditingController();
  TextEditingController accountNoController = TextEditingController();
  TextEditingController ifscController = TextEditingController();
  TextEditingController confmAccountNumController = TextEditingController();
  TextEditingController bankNameController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController upiController = TextEditingController();
  List accountType = [
    'Savings',
    'Current'
  ];
  var accTypeValue;


  Future getWithdrawlHistory() async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString(TokenString.userid);

    var request = http.MultipartRequest(
        'POST', Uri.parse('${Apipath.getWalletHistory}'));
    request.fields.addAll({'user_id': '${userId.toString()}'
      // '${userId.toString()}'
    });
    print("this is request !! ${request.fields}");

    http.StreamedResponse response = await request.send();
    print("this is request !! 11111${response}");
    if (response.statusCode == 200) {
      print("this response @@ ${response.statusCode}");
      final str = await response.stream.bytesToString();
      var datas = WalletTransactionsModel.fromJson(json.decode(str));
      return WalletTransactionsModel.fromJson(json.decode(str));
    } else {
      return null;
    }
  }

  Future withdrawRequest() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString(TokenString.userid);

    var request = http.MultipartRequest(
        'POST', Uri.parse('${Apipath.withdrawRequestUrl}'));
    request.fields.addAll({
      'user_id': '${userId.toString()}',
      'amount': '${amountController.text.toString()}',
      'upi_id':'${upiController.text.toString()}',
      'ac_no': '${accountNoController.text.toString()}',
      'ac_holder_name': '${accountHolderController.text.toString()}',
      'ifsc_code': '${ifscController.text.toString()}',
      'bank_name': '${bankNameController.text.toString()}',
      'account_type': accTypeValue == null ? "" : '${accTypeValue.toString()}'
    });
    print("this is request !! ${request.fields}");

    http.StreamedResponse response = await request.send();
    print("this is request !! 11111${response}");
    if (response.statusCode == 200) {
      print("this response @@ ${response.statusCode}");
      final str = await response.stream.bytesToString();
      Fluttertoast.showToast(msg: "Request sent successfully!!");
    } else {
      return null;
    }
  }


  void checkingLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      uid = prefs.getString(TokenString.userid).toString();
      type = prefs.getString(TokenString.type).toString();
      wallet = prefs.getString(TokenString.walletBalance).toString();
      referralCode = prefs.getString(TokenString.referralCode).toString();
      userName = prefs.getString(TokenString.userName).toString();
    });
    print("this id uid ${uid.toString()} aand ${type}");
  }
  void initState() {
    super.initState();
    checkingLogin();
    getWithdrawlHistory();
    // Future.delayed(Duration(milliseconds: 500), () {
    //   return getprofile();
    // });
  }

  GetProfileModel? profileModel;
  int _selectedIndex = 0;

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor().colorPrimary(),
      appBar: AppBar(
        backgroundColor: AppColor().colorPrimary(),
        elevation: 0,
        centerTitle: true,
        title: Text("Wallet"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [

            Container(
              padding: EdgeInsets.only(top: 5),
              width: MediaQuery.of(context).size.width,
              // height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                  color: AppColor().colorSecondary(),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(45),
                    topRight: Radius.circular(45),
                  )),
              child: Container(
                // height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(45),
                        topRight: Radius.circular(45),
                      )),
                  child: Padding(
                      padding:
                      const EdgeInsets.only(left: 10.0, right: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 20.0, bottom: 15),
                              child: Text("Available Balance",
                                style: TextStyle(
                                    fontSize: 24
                                ),),
                            ),
                          ),
                          Center(
                            child: Text(
                              wallet == null || wallet == ""?
                            " ₹ 0" :  "₹ ${wallet.toString()}",
                              style: TextStyle(
                                  fontSize: 34,
                                fontWeight: FontWeight.w600
                              ),),
                          ),
                          const SizedBox(height: 10,),
                          AppBtn(
                            onPress: (){
                              setState((){
                                show = !show;
                              });
                            },
                            label: "Withdraw Amount",
                          ),

                          Visibility(
                            visible: show,
                              child:  Column(crossAxisAlignment: CrossAxisAlignment.start,

                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10, left: 10),
                                    child: Text('Amount'),
                                  ),

                                  Padding(
                                    padding: const EdgeInsets.only(top: 10.0, bottom: 10),
                                    child: Container(
                                      // height: 50,
                                      child: TextFormField(
                                        keyboardType: TextInputType.number,
                                          controller: amountController,
                                          validator: (msg) {
                                            if (msg!.isEmpty) {
                                              return "Please Enter Amount";
                                            }
                                          },
                                          decoration: InputDecoration(
                                              border: OutlineInputBorder(
                                                  borderRadius: BorderRadius.circular(15)))
                                        // decoration: InputDecoration(
                                        //   border: OutlineInputBorder(),
                                        // ),
                                      ),
                                    ),
                                  ),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Radio(
                                              value: 1,
                                              fillColor: MaterialStateColor.resolveWith((states) => AppColor().colorPrimary()),
                                              groupValue: _value,
                                              onChanged: (int? value) {
                                                setState(() {
                                                  _value = value!;
                                                  isUpi = false;
                                                });
                                              }),
                                          Text(
                                            "Bank Upi",
                                            style: TextStyle(color: AppColor.PrimaryDark),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Radio(
                                              value: 2,
                                              fillColor: MaterialStateColor.resolveWith((states) => AppColor().colorPrimary()),
                                              groupValue: _value,
                                              onChanged: (int? value) {
                                                setState(() {
                                                  _value = value!;
                                                  isUpi = true;
                                                });
                                              }),
                                          Text(
                                            "Bank Account",
                                            style: TextStyle(color: AppColor.PrimaryDark),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  isUpi == false
                                      ? Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(left: 10),
                                        child: Text('UPI Id'),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                        // height: 50,
                                        child: TextFormField(
                                            controller: upiController,
                                            validator: (msg) {
                                              if (msg!.isEmpty) {
                                                return "Please Enter UPI Id ";
                                              }
                                            },
                                            decoration: InputDecoration(
                                                border: OutlineInputBorder(
                                                    borderRadius: BorderRadius.circular(15)))
                                          // decoration: InputDecoration(
                                          //   border: OutlineInputBorder(),
                                          // ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      AppBtn(
                                        label: "Submit",
                                        onPress: (){
                                            if (amountController.text.isNotEmpty) {
                                              if(double.parse(amountController.text.toString()) <= double.parse(wallet.toString())) {
                                                if (upiController.text
                                                    .isNotEmpty) {
                                                  withdrawRequest();
                                                } else {
                                                  Fluttertoast.showToast(
                                                      msg: "Please enter valid Upi ID");
                                                }
                                              }else{
                                                Fluttertoast.showToast(
                                                    msg: "Withdraw amount is not more than available amount!");
                                              }
                                            } else {
                                              Fluttertoast.showToast(
                                                  msg: "Please enter amount you want to withdraw!");
                                            }

                                        },
                                      )

                                    ],
                                  )
                                      : SizedBox.shrink(),
                                  isUpi == true
                                      ? Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(left: 10),
                                        child: Text('Account Holder Name'),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                        // height: 50,
                                        child: TextFormField(
                                            controller: accountHolderController,
                                            // validator: (msg) {
                                            //   if (msg!.isEmpty) {
                                            //     return "Please Enter Account Holder Name ";
                                            //   }
                                            // },
                                            decoration: InputDecoration(
                                                border: OutlineInputBorder(
                                                    borderRadius: BorderRadius.circular(15)))
                                          // decoration: InputDecoration(
                                          //   border: OutlineInputBorder(),
                                          // ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 10),
                                        child: Text('Account Number'),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                        // height: 50,
                                        child: TextFormField(
                                            controller: accountNoController,
                                            keyboardType: TextInputType.number,
                                            validator: (msg) {
                                              if (msg!.isEmpty) {
                                                return "Please Enter Account Number";
                                              }
                                            },
                                            decoration: InputDecoration(
                                                counterText: "",
                                                border: OutlineInputBorder(
                                                    borderRadius: BorderRadius.circular(15)))
                                          // decoration: InputDecoration(
                                          //   border: OutlineInputBorder(),
                                          // ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 10),
                                        child: Text('Confirm Account Number'),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                        // height: 50,
                                        child: TextFormField(
                                            controller: confmAccountNumController,
                                            keyboardType: TextInputType.number,
                                            validator: (msg) {
                                              if(msg != confmAccountNumController.text){
                                                return "Account number and confirm account number must be same";
                                              }
                                            },
                                            decoration: InputDecoration(
                                                counterText: "",
                                                border: OutlineInputBorder(
                                                    borderRadius: BorderRadius.circular(15)))
                                          // decoration: InputDecoration(
                                          //   border: OutlineInputBorder(),
                                          // ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 10),
                                        child: Text('Bank Name'),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                        // height: 50,
                                        child: TextFormField(
                                            controller: bankNameController,
                                            // validator: (msg) {
                                            //   if (msg!.isEmpty) {
                                            //     return "Please Enter Bank Name ";
                                            //   }
                                            // },
                                            decoration: InputDecoration(
                                                border: OutlineInputBorder(
                                                    borderRadius: BorderRadius.circular(15)))
                                          // decoration: InputDecoration(
                                          //   border: OutlineInputBorder(),
                                          // ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 10),
                                        child: Text('IFSC Code'),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                        // height: 50,
                                        child: TextFormField(
                                            controller: ifscController,
                                            // validator: (msg) {
                                            //   if (msg!.isEmpty) {
                                            //     return "Please Enter IFSC Code";
                                            //   }
                                            // },
                                            decoration: InputDecoration(
                                                border: OutlineInputBorder(
                                                    borderRadius: BorderRadius.circular(15)))
                                          // decoration: InputDecoration(
                                          //   border: OutlineInputBorder(),
                                          // ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 10),
                                        child: Text('Account Type'),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Padding(
                                        padding:
                                        const EdgeInsets.only(top: 5.0, bottom: 10),
                                        child: Container(
                                          height: 60,
                                          padding: EdgeInsets.only(left: 10),
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(15),
                                              border: Border.all(
                                                  color: Colors.black.withOpacity(0.7))),
                                          child: DropdownButton(
                                            // Initial Value
                                            value: accTypeValue,
                                            underline: Container(),
                                            isExpanded: true,
                                            // Down Arrow Icon
                                            icon: Icon(Icons.keyboard_arrow_down),
                                            hint: Text("Select Account Type"),
                                            // Array list of items
                                            items: accountType.map((items) {
                                              return DropdownMenuItem(
                                                value: items,
                                                child: Container(
                                                    child: Text(items.toString())),
                                              );
                                            }).toList(),
                                            // After selecting the desired option,it will
                                            // change button value to selected value
                                            onChanged: (newValue) {
                                              setState(() {
                                                accTypeValue = newValue!;
                                                print(
                                                    "selected category ${accTypeValue.toString()}");
                                              });
                                            },
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      AppBtn(
                                        label: "Submit",
                                        onPress: (){
                                          if(amountController.text.isNotEmpty){
                                            if(accountNoController.text.isNotEmpty
                                                && accountHolderController.text.isNotEmpty &&
                                            bankNameController.text.isNotEmpty && ifscController.text.isNotEmpty
                                            ){
                                              if(accountNoController.text.toString() == confmAccountNumController.text.toString()){
                                                withdrawRequest();
                                              }else{
                                                Fluttertoast.showToast(msg: "Account no. and confirm account no. should be same");
                                              }

                                            }else{
                                              Fluttertoast.showToast(msg: "Please enter valid Bank Details");
                                            }
                                          }else{
                                            Fluttertoast.showToast(msg: "Please enter amount you want to withdraw!");
                                          }
                                        },
                                      )
                                    ],
                                  )
                                      : SizedBox.shrink(),
                                ],
                              )),

                          Padding(
                            padding: const EdgeInsets.only(top: 15, left: 8.0, bottom: 10),
                            child: Text("Transactions",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16
                            ),),
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height,
                            child: FutureBuilder(
                                future: getWithdrawlHistory(),
                                builder: (BuildContext context, AsyncSnapshot snapshot) {
                                  WalletTransactionsModel? model = snapshot.data;
                                  // print("this is moddel ==========>>>>> ${model!.products![0].productPrice.toString()}");
                                  if (snapshot.hasData) {
                                    return
                                      // model!.error == false ?
                                      Container(
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(20)),
                                      child:
                            ListView.builder(
                                shrinkWrap: true,
                                physics: ScrollPhysics(),
                                itemCount: model!.data!.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8,
                                        right: 8,
                                        bottom: 10.0),
                                    child: Card(
                                      elevation: 0,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(
                                              15)),
                                      child: Container(
                                        padding:
                                        const EdgeInsets.all(10),
                                        // only(left: 85, right: 20),
                                        height: 90,
                                        width: MediaQuery.of(context)
                                            .size
                                            .width,
                                        decoration: BoxDecoration(
                                            border: Border.all(color: AppColor().colorPrimary()),
                                            borderRadius:
                                            BorderRadius.circular(
                                                15)),
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment
                                              .start,
                                          crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              child: Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment
                                                    .spaceBetween,
                                                crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    width: 40,
                                                    height: 40,
                                                    child: Image.asset('images/country.png'),
                                                    decoration: BoxDecoration(
                                                      color: AppColor.PrimaryDark,
                                                      shape: BoxShape.circle,

                                                    ),
                                                  ),
                                                  ///Image
                                                  /*Container(
                                                            height: 60,
                                                            width: 60,
                                                            decoration:
                                                            BoxDecoration(
                                                              borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                  10),
                                                            ),
                                                            child: ClipRRect(
                                                              borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                  10),
                                                              child: Image
                                                                  .network(
                                                                "${model.products![index].profileImage.toString()}",
                                                                fit: BoxFit
                                                                    .fill,
                                                              ),
                                                            ),
                                                          ),*/
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.only(top: 10.0),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .start,
                                                      mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .center,
                                                      children: [
                                                        // Text("${userName.toString}",
                                                        //   style:
                                                        //   TextStyle(
                                                        //     color: Colors
                                                        //         .black,
                                                        //     fontSize:
                                                        //     14,
                                                        //     fontWeight:
                                                        //     FontWeight
                                                        //         .bold,
                                                        //   ),
                                                        // ),
                                                        SizedBox(height: 7,),
                                                        Container(
                                                          width: 140,
                                                          child: Text(
                                                            "${model.data![index].createdAt.toString()}",
                                                            maxLines: 3,
                                                            style: TextStyle(
                                                              fontSize: 14,
                                                              color: colors.subTxtClr,
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                            height: 5),


                                                      ],
                                                    ),
                                                  ),


                                                  // Row(
                                                  //   children: [
                                                  //     Text("",),
                                                  //       //"${model.products![index].revStars.toString()}",),
                                                  //     const SizedBox(width: 5,),
                                                  //     // ListView.builder(
                                                  //     //   shrinkWrap: true,
                                                  //     //   scrollDirection: Axis.horizontal,
                                                  //     //   itemBuilder: (context, index){
                                                  //     //     return Icon(Icons.star,
                                                  //     //       color: AppColor().colorSecondary(),
                                                  //     //       size: 16,);
                                                  //     //   },
                                                  //     //   itemCount:
                                                  //     //   model.products![index].revStars.toString() == "1.0"?
                                                  //     //   1 :
                                                  //     //   model.products![index].revStars.toString() == "2.0"?
                                                  //     //   2 :
                                                  //     //   model.products![index].revStars.toString() == "3.0"?
                                                  //     //   3 :
                                                  //     //   model.products![index].revStars.toString() == "4.0"?
                                                  //     //   4 : 5
                                                  //     //   ,
                                                  //     // ),
                                                  //   ],
                                                  // )
                                                ],
                                              ),
                                            ),
                                            Column(
                                              children: [
                                                Text("₹ ${model.data![index].amount.toString()}",
                                                  style: TextStyle(
                                                      fontSize: 20
                                                  ),),
                                                Container(
                                                  height: 35,
                                                  padding: EdgeInsets.only(top: 5, bottom: 5, left: 10, right: 10),
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(10),
                                                    color:
                                                    model.data![index].status == "0"?
                                                    AppColor().colorSecondary()
                                                        : model.data![index].status == "1"?
                                                    Colors.green
                                                        : model.data![index].status == "2"?
                                                    Colors.red
                                                        :Colors.white,
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      model.data![index].status == "0"?
                                                      "Pending"
                                                          : model.data![index].status == "1"?
                                                      "Approved"
                                                          : model.data![index].status == "2"?
                                                      "Pending"
                                                          :"",
                                                      style: TextStyle(
                                                        color:  model.data![index].status == "0"?
                                                        AppColor().colorPrimary()
                                                            : model.data![index].status == "1"?
                                                        Colors.white
                                                            : model.data![index].status == "2"?
                                                        Colors.white
                                                            :Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            )

                                            // Row(
                                            //   children: [
                                            //     Card(
                                            //       elevation: 2,
                                            //       child: InkWell(
                                            //           onTap: () {
                                            //             // Navigator.push(
                                            //             //     context,
                                            //             //     MaterialPageRoute(
                                            //             //         builder: (context) => EditProducts(
                                            //             //           productsModel: model.products![index],
                                            //             //         )));
                                            //           },
                                            //           child: Icon(
                                            //             Icons.edit,
                                            //             color: AppColor
                                            //                 .PrimaryDark,
                                            //           )),
                                            //     ),
                                            //     SizedBox(
                                            //       width: 6,
                                            //     ),
                                            //     InkWell(
                                            //       onTap: () {
                                            //         deleteProduct(model
                                            //             .products![
                                            //         index]
                                            //             .productId
                                            //             .toString());
                                            //       },
                                            //       child: Card(
                                            //         elevation: 2,
                                            //         child: Icon(
                                            //           Icons
                                            //               .delete_forever_rounded,
                                            //           color:
                                            //           Colors.red,
                                            //         ),
                                            //       ),
                                            //     ),
                                            //   ],
                                            // ),

                                            // Container(
                                            //   height: 25,
                                            //   width: 80,
                                            //   decoration: BoxDecoration(
                                            //       color: AppColor.PrimaryDark,
                                            //       borderRadius: BorderRadius.circular(30)),
                                            //   child: const Center(
                                            //     child: Text(
                                            //       "View",
                                            //       style: TextStyle(color: Colors.white),
                                            //     ),
                                            //   ),
                                            // )
                                            // AppBtn(
                                            //   title: "View",
                                            //   onPress: (){
                                            //
                                            //   },
                                            //   height: 15,
                                            //   width: 70,
                                            //   fSize: 14,
                                            // )
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                  //cardWidget(model, i
                                }),
                                );
                                //     : Container(
                                //   height:
                                //   MediaQuery.of(context).size.height / 1.5,
                                //   child: Center(
                                //       child: Text("No Transactions Found!!")),
                                // );
                              } else if (snapshot.hasError) {
                                return Icon(Icons.error_outline);
                              } else {
                                return Container(
                                  height: MediaQuery.of(context).size.height,
                                  child: Center(
                                    child: Container(
                                        height: 30,
                                        width: 30,
                                        // MediaQuery.of(context).size.height / 1.5,
                                        child: CircularProgressIndicator(
                                          color: AppColor.PrimaryDark,
                                        )),
                                  ),
                                );
                              }
                            }),
                          )

                        ],
                      )
                  )),
            ),
          ],
        ),
      ),
    );
  }

  var bankDetails;


}


class WithdrawWalletAmount extends StatefulWidget {
  const WithdrawWalletAmount({Key? key}) : super(key: key);

  @override
  State<WithdrawWalletAmount> createState() => _WithdrawWalletAmountState();
}

class _WithdrawWalletAmountState extends State<WithdrawWalletAmount> {

  TextEditingController accountHolderController = TextEditingController();
  TextEditingController accountNoController = TextEditingController();
  TextEditingController ifscController = TextEditingController();
  // TextEditingController accountTypeController = TextEditingController();
  TextEditingController bankNameController = TextEditingController();
  List accountType = [
    'Savings',
    'Current'
  ];
  var accTypeValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor().colorPrimary(),
      appBar: AppBar(
        backgroundColor: AppColor().colorPrimary(),
        elevation: 0,
        centerTitle: true,
        title: Text("Wallet"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [

            Container(
              padding: EdgeInsets.only(top: 5),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                  color: AppColor().colorSecondary(),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(45),
                    topRight: Radius.circular(45),
                  )),
              child: Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(45),
                        topRight: Radius.circular(45),
                      )),
                  child: Padding(
                      padding:
                      const EdgeInsets.only(left: 20.0, right: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text('Account Holder Name'),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            // height: 50,
                            child: TextFormField(
                                controller: accountHolderController,
                                // validator: (msg) {
                                //   if (msg!.isEmpty) {
                                //     return "Please Enter Account Holder Name ";
                                //   }
                                // },
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15)))
                              // decoration: InputDecoration(
                              //   border: OutlineInputBorder(),
                              // ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text('Account Number'),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            // height: 50,
                            child: TextFormField(
                                controller: accountNoController,
                                keyboardType: TextInputType.number,
                                // validator: (msg) {
                                //   if (msg!.isEmpty) {
                                //     return "Please Enter Account Number";
                                //   }
                                // },
                                decoration: InputDecoration(
                                    counterText: "",
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15)))
                              // decoration: InputDecoration(
                              //   border: OutlineInputBorder(),
                              // ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text('Bank Name'),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            // height: 50,
                            child: TextFormField(
                                controller: bankNameController,
                                // validator: (msg) {
                                //   if (msg!.isEmpty) {
                                //     return "Please Enter Bank Name ";
                                //   }
                                // },
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15)))
                              // decoration: InputDecoration(
                              //   border: OutlineInputBorder(),
                              // ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text('IFSC Code'),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            // height: 50,
                            child: TextFormField(
                                controller: ifscController,
                                // validator: (msg) {
                                //   if (msg!.isEmpty) {
                                //     return "Please Enter IFSC Code";
                                //   }
                                // },
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15)))
                              // decoration: InputDecoration(
                              //   border: OutlineInputBorder(),
                              // ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text('Account Type'),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding:
                            const EdgeInsets.only(top: 5.0, bottom: 10),
                            child: Container(
                              height: 60,
                              padding: EdgeInsets.only(left: 10),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(7),
                                  border: Border.all(
                                      color: Colors.black.withOpacity(0.7))),
                              child: DropdownButton(
                                // Initial Value
                                value: accTypeValue,
                                underline: Container(),
                                isExpanded: true,
                                // Down Arrow Icon
                                icon: Icon(Icons.keyboard_arrow_down),
                                hint: Text("Select Account Type"),
                                // Array list of items
                                items: accountType.map((items) {
                                  return DropdownMenuItem(
                                    value: items,
                                    child: Container(
                                        child: Text(items.toString())),
                                  );
                                }).toList(),
                                // After selecting the desired option,it will
                                // change button value to selected value
                                onChanged: (newValue) {
                                  setState(() {
                                    accTypeValue = newValue!;
                                    print(
                                        "selected category ${accTypeValue.toString()}");
                                  });
                                },
                              ),
                            ),
                          ),

                          AppBtn(
                            onPress: (){},
                            label: "Withdraw",
                          )
                        ],
                      )
                  )),
            ),
          ],
        ),
      ),
    );
  }
}

