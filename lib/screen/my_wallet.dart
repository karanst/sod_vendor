// import 'dart:convert';
//
// import 'package:fixerking/modal/New%20models/WalletHistory.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart';
// import 'package:razorpay_flutter/razorpay_flutter.dart';
// import 'package:sizer/sizer.dart';
//
// import '../api/api_path.dart';
// import '../api/api_services.dart';
// import '../modal/purchase_plan_model.dart';
// import '../token/app_token_data.dart';
// import '../utility_widget/utility_widget.dart';
// import '../utils/colors.dart';
// import '../utils/utility_hlepar.dart';
// import 'package:http/http.dart' as http;
//
// class WalletScreen extends StatefulWidget {
//   String walletAmount;
//    WalletScreen({
//      required this.walletAmount, Key? key}) : super(key: key);
//
//   @override
//   State<WalletScreen> createState() => _WalletScreenState();
// }
//
// class _WalletScreenState extends State<WalletScreen> {
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   Razorpay _razorpay = Razorpay();
//   bool buttonLogin = false;
//   StateSetter? dialogState;
//   TextEditingController amtC =TextEditingController();
//   TextEditingController msgC =TextEditingController();
//   var planI;
//   List<Data> walletHistory = [];
//
//   String? validateField(String value, String? msg) {
//     if (value.length == 0)
//       return msg;
//     else
//       return null;
//   }
//
//   _showDialog() async {
//     bool payWarn = false;
//     await dialogAnimate(context,
//         StatefulBuilder(builder: (BuildContext context1, StateSetter setStater) {
//           dialogState = setStater;
//           return AlertDialog(
//             contentPadding: const EdgeInsets.all(0.0),
//             shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.all(Radius.circular(5.0))),
//             content: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Padding(
//                     padding: EdgeInsets.fromLTRB(20.0, 20.0, 0, 2.0),
//                     child: Text("Add Money",
//                      // getTranslated(context, 'ADD_MONEY')!,
//                       style: Theme.of(this.context)
//                           .textTheme
//                           .subtitle1!
//                           .copyWith(color: AppColor().colorTextPrimary()),
//                     //  Theme.of(context).colorScheme.fontColor),
//                     ),
//                   ),
//                   Divider(color: AppColor().colorTextSecondary()),
//                   Form(
//                     key: _formKey,
//                     child: Flexible(
//                       child: SingleChildScrollView(
//                           child: new Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               mainAxisSize: MainAxisSize.min,
//                               children: <Widget>[
//                                 Padding(
//                                     padding: EdgeInsets.fromLTRB(20.0, 0, 20.0, 0),
//                                     child: TextFormField(
//                                       keyboardType: TextInputType.number,
//                                       validator: (val) => validateField(val!,
//                                           "This Field is Required"
//                                           //getTranslated(context, 'FIELD_REQUIRED')
//                                       ),
//                                       autovalidateMode:
//                                       AutovalidateMode.onUserInteraction,
//                                       style: TextStyle(
//                                         color: AppColor().colorTextPrimary(),
//                                       ),
//                                       decoration: InputDecoration(
//                                         hintText: "Amount",
//                                        // getTranslated(context, "AMOUNT"),
//                                         hintStyle: Theme.of(this.context)
//                                             .textTheme
//                                             .subtitle1!
//                                             .copyWith(
//                                             color: AppColor().colorTextSecondary(),
//                                             fontWeight: FontWeight.normal),
//                                       ),
//                                       controller: amtC,
//                                     )),
//                                 Padding(
//                                     padding: EdgeInsets.fromLTRB(20.0, 0, 20.0, 0),
//                                     child: TextFormField(
//                                       autovalidateMode:
//                                       AutovalidateMode.onUserInteraction,
//                                       style: TextStyle(
//                                         color: AppColor().colorTextPrimary(),
//                                       ),
//                                       decoration: new InputDecoration(
//                                         hintText: "Message",
//                                         //(context, 'MSG'),
//                                         hintStyle: Theme.of(this.context)
//                                             .textTheme
//                                             .subtitle1!
//                                             .copyWith(
//                                             color: AppColor().colorTextSecondary(),
//                                             // Theme.of(context)
//                                             //     .colorScheme
//                                             //     .lightBlack,
//                                             fontWeight: FontWeight.normal),
//                                       ),
//                                       controller: msgC,
//                                     )),
//                                 //Divider(),
//                                 // Padding(
//                                 //   padding: EdgeInsets.fromLTRB(20.0, 10, 20.0, 5),
//                                 //   child: Text("Select Payment Method",
//                                 //     //getTranslated(context, 'SELECT_PAYMENT')!,
//                                 //     style: Theme.of(context).textTheme.subtitle2,
//                                 //   ),
//                                 // ),
//                                 Divider(),
//                                 payWarn
//                                     ? Padding(
//                                   padding: const EdgeInsets.symmetric(
//                                       horizontal: 20.0),
//                                   child: Text("Please Select Payment Method..!!",
//                                   //  getTranslated(context, 'payWarning')!,
//                                     style: Theme.of(context)
//                                         .textTheme
//                                         .caption!
//                                         .copyWith(color: Colors.red),
//                                   ),
//                                 )
//                                     : Container(),
//
//                                 // paypal == null
//                                 //     ? Center(child: CircularProgressIndicator())
//                                 //     : Column(
//                                 //     mainAxisAlignment: MainAxisAlignment.start,
//                                 //     children: getPayList()),
//                               ])),
//                     ),
//                   )
//                 ]),
//             actions: <Widget>[
//               new ElevatedButton(
//                 style: ElevatedButton.styleFrom(
//                   primary: AppColor().colorPrimary()
//                 ),
//                   child: Text("Cancel",
//                    // getTranslated(context, 'CANCEL')!,
//                     style: Theme.of(this.context).textTheme.subtitle2!.copyWith(
//                        // color: AppColor().colorTextSecondary(),
//                        // Theme.of(context).colorScheme.lightBlack,
//                         fontWeight: FontWeight.bold),
//                   ),
//                   onPressed: () {
//                   amtC.clear();
//                   msgC.clear();
//                     Navigator.pop(context1);
//                   }),
//               new ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                       primary: AppColor().colorPrimary()
//                   ),
//                   child: Text("Send",
//                    // getTranslated(context, 'SEND')!,
//                     style: Theme.of(this.context).textTheme.subtitle2!.copyWith(
//                         color: AppColor().colorTextPrimary(),
//                         //Theme.of(context).colorScheme.fontColor,
//                         fontWeight: FontWeight.bold),
//                   ),
//                   onPressed: () {
//                     final form = _formKey.currentState!;
//                     if (form.validate() && amtC.text != '0') {
//                       form.save();
//                       print("purchase Plan");
//                       // print("purchase Plan2 ==== $price");
//                       // price = int.parse(item.price.toString()) * 100;
//
//                       checkOut();
//                       amtC.clear();
//                       msgC.clear();
//                       // if (payMethod == null) {
//                       //   dialogState!(() {
//                       //     payWarn = true;
//                       //   });
//                       // } else {
//                       //   if (payMethod!.trim() ==
//                       //       getTranslated(context, 'STRIPE_LBL')!.trim()) {
//                       //     stripePayment(int.parse(amtC.text));
//                       //   } else if (payMethod!.trim() ==
//                       //       getTranslated(context, 'RAZORPAY_LBL')!.trim())
//                       //     razorpayPayment(double.parse(amtC.text));
//                       //   else if (payMethod!.trim() ==
//                       //       "Pay Now"){
//                       //     CashFreeHelper cashFreeHelper = new CashFreeHelper(amtC.text.toString(), context, (result){
//                       //       print(result['txMsg']);
//                       //       // setSnackbar(result['txMsg'], _checkscaffoldKey);
//                       //       if(result['txStatus']=="SUCCESS"){
//                       //         sendRequest(result['signature'], "CashFree");
//                       //       }else{
//                       //         setSnackbar1("Transaction cancelled and failed",context );
//                       //       }
//                       //       //placeOrder(result.paymentId);
//                       //     });
//                       //
//                       //     cashFreeHelper.init();
//                       //   }
//                       //   else if (payMethod!.trim() ==
//                       //       getTranslated(context, 'PAYSTACK_LBL')!.trim())
//                       //     paystackPayment(context, int.parse(amtC.text));
//                       //   else if (payMethod == getTranslated(context, 'PAYTM_LBL'))
//                       //     paytmPayment(double.parse(amtC.text));
//                       //   else if (payMethod ==
//                       //       getTranslated(context, 'PAYPAL_LBL')) {
//                       //     paypalPayment((amtC.text).toString());
//                       //   } else if (payMethod ==
//                       //       getTranslated(context, 'FLUTTERWAVE_LBL'))
//                       //     flutterwavePayment(amtC.text);
//                         Navigator.pop(context1);
//                       }
//                     }
//                  // }
//                   )
//             ],
//           );
//         }));
//   }
//
//   checkOut() {
//     int amount  = int.parse(amtC.text.toString()) * 100;
//     var options = {
//       'key': "rzp_test_CpvP0qcfS4CSJD",
//       'amount': amount,
//       'currency': 'INR',
//       'name': 'Antsnest',
//       'description': '',
//       // 'prefill': {'contact': userMobile, 'email': userEmail},
//     };
//     print("OPTIONS ===== $options");
//     _razorpay.open(options);
//   }
//   Future<void> _handlePaymentSuccess(PaymentSuccessResponse response) async {
//    // var userId = await MyToken.getUserID();
//     UtilityHlepar.getToast("Payment Successful");
//     //purchasePlan("$userId", planI,"${response.paymentId}");
//     addWalletMoney(response.paymentId);
//     // Do something when payment succeeds
//   }
//
//   void _handlePaymentError(PaymentFailureResponse response) {
//     // Do something when payment fails
//     print("FAILURE === ${response.message}");
//     // UtilityHlepar.getToast("${response.message}");
//     UtilityHlepar.getToast("Payment Failed");
//   }
//
//   void _handleExternalWallet(ExternalWalletResponse response) {
//     // Do something when an external wallet was selected
//   }
//   Future purchasePlan(userId, planId, txnId) async {
//
//     var request = http.MultipartRequest('POST', Uri.parse('${Apipath.BASH_URL}purchase_plan'));
//     request.fields.addAll({
//       'user_id': '$userId',
//       'plan_id': '$planId',
//       'transaction_id': '$txnId'
//     });
//
//     print(request);
//     print("PURCHACE PLAN PARAM" + request.fields.toString());
//
//     http.StreamedResponse response = await request.send();
//
//     if (response.statusCode == 200) {
//       final str = await response.stream.bytesToString();
//       final jsonResponse = PurchasePlanModel.fromJson(json.decode(str));
//       if(jsonResponse.responseCode == "1"){
//         UtilityHlepar.getToast("Plan Purchases Successfully!");
//         Navigator.pop(context,true);
//       }
//       return PurchasePlanModel.fromJson(json.decode(str));
//     }
//     else {
//       return null;
//     }
//   }
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     getWalletHistory();
//     // getUserDetails();
//     //UNCOMMENT
//     _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
//     _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
//     _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
//   }
//
//   @override
//   void dispose() {
//     // TODO: implement dispose
//     super.dispose();
//     amtC.clear();
//     msgC.clear();
//     _razorpay.clear();//UNCOMMENT
//   }
//
//   addWalletMoney(txnId)async{
//     var userId = await MyToken.getUserID();
//     var parameter = {
//       "transaction_id" : txnId,
//       "amount": amtC.text.toString(),
//       "user_id": userId,
//     };
//     print(parameter.toString());
//     var response = await ApiService.postAPI(
//         path: Apipath.addMoneyToWallet, parameters: parameter);
//
//     if (response.statusCode == 200) {
//       var getData = json.decode(response.body);
//       String? msg = getData["msg"];
//       final snackBar = SnackBar(
//         content:  Text(msg!),
//         backgroundColor: AppColor().colorPrimary(),
//       );
//       ScaffoldMessenger.of(context).showSnackBar(snackBar);
//     }
//     else{
//       final snackBar = SnackBar(
//         content:  Text("Something went wrong!"),
//         backgroundColor: AppColor().colorPrimary(),
//       );
//       ScaffoldMessenger.of(context).showSnackBar(snackBar);
//     }
//   }
//
//   Future<WalletHistory> getWalletHistory()async {
//     var userId = await MyToken.getUserID();
//     var parameter = {
//
//       "user_id": userId,
//     };
//     print(parameter.toString());
//     var response = await ApiService.postAPI(
//         path: Apipath.getWalletHistory, parameters: parameter);
//
//     if (response.statusCode == 200) {
//       var data = WalletHistory.fromJson(json.decode(response.body));
//       //jsonDecode(response.body);
//
//       walletHistory = data.data!;
//      // print(walletHistory.toString());
//       // String? msg = getData["msg"];
//       // final snackBar = SnackBar(
//       //   content:  Text(msg!),
//       //   backgroundColor: AppColor().colorPrimary(),
//       // );
//       // ScaffoldMessenger.of(context).showSnackBar(snackBar)
//     }
//     else{
//       final snackBar = SnackBar(
//         content:  Text("Something went wrong!"),
//         backgroundColor: AppColor().colorPrimary(),
//       );
//       ScaffoldMessenger.of(context).showSnackBar(snackBar);
//
//     }
//     return WalletHistory.fromJson(jsonDecode(response.body));
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         backgroundColor: AppColor.PrimaryDark,
//         title: Text("Wallet"),
//       ),
//       body: Container(
//         child: Stack(
//           children: [
//             showContent(),
//           ],
//         ),
//       ),
//     );
//   }
//   dialogAnimate(BuildContext context, Widget dialge) {
//     return showGeneralDialog(
//         barrierColor:AppColor().colorTextPrimary().withOpacity(0.5),
//         transitionBuilder: (context, a1, a2, widget) {
//           return Transform.scale(
//             scale: a1.value,
//             child: Opacity(opacity: a1.value, child: dialge),
//           );
//         },
//         transitionDuration: Duration(milliseconds: 200),
//         barrierDismissible: true,
//         barrierLabel: '',
//         context: context,
//         // pageBuilder: null
//         pageBuilder: (context, animation1, animation2) {
//           return Container();
//         } //as Widget Function(BuildContext, Animation<double>, Animation<double>)
//     );
//   }
//   showContent() {
//     return SingleChildScrollView(
//       // controller: controller,
//       child: Column(
//          // mainAxisSize: MainAxisSize.min,
//           children: [
//         Padding(
//           padding: const EdgeInsets.only(top: 5.0),
//           child: Card(
//             elevation: 0,
//             child: Padding(
//               padding: const EdgeInsets.all(18.0),
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Icon(
//                         Icons.account_balance_wallet,
//                         // color: Theme.of(context).colorScheme.fontColor,
//                       ),
//                       Text(
//                         "Current Balance ",
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: 10,),
//                   Container(
//                     child: Text(
//                       "₹ ${widget.walletAmount}",
//                       style: TextStyle(
//                         fontSize: 20,
//                         fontWeight: FontWeight.w600
//                       ),
//                     ),
//                   ),
//                   Container(
//                       margin: EdgeInsets.only(top:15, bottom: 15),
//                       child: InkWell(
//                         onTap: () {
//                           _showDialog();
//                         },
//                         child: UtilityWidget.lodingButton(
//                             buttonLogin: buttonLogin, btntext: 'Add Money'),
//                       )),
//                 ],
//               ),
//             ),
//           ),
//         ),
//         FutureBuilder<WalletHistory>(
//           future: getWalletHistory(),
//           builder: (context, snapshot){
//             if(snapshot.hasData){
//               return Container(
//                 height: 400,
//                 child: ListView.builder(
//                     itemCount: walletHistory.length,
//                     itemBuilder: (context, index){
//                       return Card(
//                         child: Padding(
//                           padding: const EdgeInsets.symmetric(horizontal: 15.0),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Row(
//                                 children: [
//                                   Container(
//                                     width: 60,
//                                     height: 60,
//                                     color: Colors.white,
//                                     child: ClipRRect(
//                                         borderRadius:
//                                         BorderRadius.circular(10.0),
//                                         child:
//                                         Image.asset(
//                                           "images/wallet_icon.png",
//                                           fit: BoxFit.cover,
//                                           width: 100,
//                                           height: 200,)
//                                     ),
//                                   ),
//                                   Column(
//                                     crossAxisAlignment: CrossAxisAlignment.start,
//                                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                     children: [
//
//                                       Text(
//                                         "Amount added",
//                                         //  ['amount'].toString(),
//                                         style: TextStyle(
//                                           color: Colors.green,
//                                           fontSize: 15,
//                                           fontWeight: FontWeight.w500,
//
//                                         ),
//                                       ),
//                                       Text(
//                                         walletHistory[index].createdAt.toString(),
//                                         //  ['amount'].toString(),
//                                         style: TextStyle(
//                                           color: AppColor().colorTextPrimary(),
//                                           fontSize: 13,
//                                           fontWeight: FontWeight.w500,
//
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ],
//                               ),
//                               Text(
//                                 "₹ " + walletHistory[index].amount.toString(),
//                                 //  ['amount'].toString(),
//                                 style: TextStyle(
//                                   color: AppColor().colorPrimary(),
//                                   fontSize: 18,
//                                   fontWeight: FontWeight.w600,
//
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       );
//                     }),
//               );
//             }
//             return Container(child: Center(child: Image.asset("images/icons/loader.gif"),),);
//           }
//
//         )
//       ]),
//     );
//   }
// }
