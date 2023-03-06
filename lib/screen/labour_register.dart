// import 'dart:convert';
// import 'dart:io';
//
// import 'package:fixerking/api/api_path.dart';
// import 'package:fixerking/modal/category_model.dart';
// import 'package:fixerking/screen/auth_view/login.dart';
// import 'package:fixerking/screen/auth_view/login_screen.dart';
// import 'package:fixerking/utils/colors.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:place_picker/entities/location_result.dart';
// import 'package:place_picker/widgets/place_picker.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:http/http.dart' as http;
// import 'package:intl/intl.dart';
//
// class RegisterLabour extends StatefulWidget {
//   const RegisterLabour({Key? key}) : super(key: key);
//
//   @override
//   State<RegisterLabour> createState() => _RegisterLabourState();
// }
//
// class _RegisterLabourState extends State<RegisterLabour> {
//
//
//   TextEditingController pickLocationController = TextEditingController();
//   TextEditingController vehicleController = TextEditingController();
//   TextEditingController nameController = TextEditingController();
//   TextEditingController mobileController = TextEditingController();
//   TextEditingController emailController = TextEditingController();
//   TextEditingController perKmController = TextEditingController();
//
//   String? selectedCategory;
//   String? selectedSubcategory;
//   AllCateModel? collectionModal;
//
//   List<Categories> catlist = [];
//
//   _getCollection() async {
//     var uri = Uri.parse('${Apipath.getCategoriesUrl}');
//     var request = new http.MultipartRequest("POST", uri);
//     Map<String, String> headers = {
//       "Accept": "application/json",
//     };
//     // print(baseUrl.toString());
//
//     request.headers.addAll(headers);
//     request.fields['type_id'] = "0";
//     // request.fields['vendor_id'] = userID;
//     var response = await request.send();
//     print(response.statusCode);
//     String responseData = await response.stream.transform(utf8.decoder).join();
//     var userData = json.decode(responseData);
//
//     if (mounted) {
//       setState(() {
//         collectionModal = AllCateModel.fromJson(userData);
//         catlist = AllCateModel.fromJson(userData).categories!;
//         print("ooooo ${collectionModal!.status} and ${collectionModal!.categories!.length} "
//           // "and ${userID}"
//         );
//       });
//     }
//     print(responseData);
//   }
//
//   Future<void> _showMyDialog() async {
//     return showDialog<void>(
//       context: context,
//       barrierDismissible: false, // user must tap button!
//       builder: (BuildContext context) {
//         return AlertDialog(
//           content: SingleChildScrollView(
//             child: ListBody(
//               children: const <Widget>[
//                 Text('User details sent successfully',
//                   style: TextStyle(
//                       fontSize: 16
//                   ),),
//                 Text('Waiting for admin approval',
//                   style: TextStyle(
//                       fontSize: 16
//                   ),),
//               ],
//             ),
//           ),
//           actions: <Widget>[
//             TextButton(
//               child: const Text('OK'),
//               onPressed: () {
//                 Navigator.push(context, MaterialPageRoute(builder: (context)=> Login()));
//
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }
//
//
//   List<Categories> subCatList = [];
//
//   File? rcImage;
//   File? aadharImage;
//   File? panImage;
//
//   void containerForSheet<T>({BuildContext? context, Widget? child}) {
//     showCupertinoModalPopup<T>(
//       context: context!,
//       builder: (BuildContext context) => child!,
//     ).then<void>((T? value) {});
//   }
//
//   uploadRCFromCamOrGallary(BuildContext context) {
//     containerForSheet<String>(
//       context: context,
//       child: CupertinoActionSheet(
//         actions: <Widget>[
//           CupertinoActionSheetAction(
//             child: Text(
//               "Camera",
//               style: TextStyle(color: Colors.black, fontSize: 15),
//             ),
//             onPressed: () {
//               getRCFromCamera();
//               Navigator.of(context, rootNavigator: true).pop("Discard");
//             },
//           ),
//           CupertinoActionSheetAction(
//             child: Text(
//               "Photo & Video Library",
//               style: TextStyle(color: Colors.black, fontSize: 15),
//             ),
//             onPressed: () {
//               getRCFromGallery();
//               Navigator.of(context, rootNavigator: true).pop("Discard");
//             },
//           ),
//         ],
//         cancelButton: CupertinoActionSheetAction(
//           child: Text(
//             "Cancel",
//             style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
//           ),
//           isDefaultAction: true,
//           onPressed: () {
//             // Navigator.pop(context, 'Cancel');
//             Navigator.of(context, rootNavigator: true).pop("Discard");
//           },
//         ),
//       ),
//     );
//   }
//
//   Future<void> getRCFromCamera() async {
//     PickedFile? pickedFile = await ImagePicker().getImage(
//       source: ImageSource.camera,
//     );
//     if (pickedFile != null) {
//       setState(() {
//         rcImage =  File(pickedFile.path);
//         // imagePath = File(pickedFile.path) ;
//         // filePath = imagePath!.path.toString();
//       });
//     }
//   }
//
//   Future<void> getRCFromGallery() async {
//     PickedFile? pickedFile = await ImagePicker().getImage(
//       source: ImageSource.gallery,
//     );
//     if (pickedFile != null) {
//       setState(() {
//         rcImage =  File(pickedFile.path);
//         // imagePath = File(pickedFile.path) ;
//         // filePath = imagePath!.path.toString();
//       });
//     }
//   }
//
//   uploadAadharFromCamOrGallary(BuildContext context) {
//     containerForSheet<String>(
//       context: context,
//       child: CupertinoActionSheet(
//         actions: <Widget>[
//           CupertinoActionSheetAction(
//             child: Text(
//               "Camera",
//               style: TextStyle(color: Colors.black, fontSize: 15),
//             ),
//             onPressed: () {
//               getAadharFromCamera();
//               Navigator.of(context, rootNavigator: true).pop("Discard");
//             },
//           ),
//           CupertinoActionSheetAction(
//             child: Text(
//               "Photo & Video Library",
//               style: TextStyle(color: Colors.black, fontSize: 15),
//             ),
//             onPressed: () {
//               getAadharFromGallery();
//               Navigator.of(context, rootNavigator: true).pop("Discard");
//             },
//           ),
//         ],
//         cancelButton: CupertinoActionSheetAction(
//           child: Text(
//             "Cancel",
//             style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
//           ),
//           isDefaultAction: true,
//           onPressed: () {
//             // Navigator.pop(context, 'Cancel');
//             Navigator.of(context, rootNavigator: true).pop("Discard");
//           },
//         ),
//       ),
//     );
//   }
//
//   Future<void> getAadharFromCamera() async {
//     PickedFile? pickedFile = await ImagePicker().getImage(
//       source: ImageSource.camera,
//     );
//     if (pickedFile != null) {
//       setState(() {
//         aadharImage =  File(pickedFile.path);
//         // imagePath = File(pickedFile.path) ;
//         // filePath = imagePath!.path.toString();
//       });
//     }
//   }
//
//   Future<void> getAadharFromGallery() async {
//     PickedFile? pickedFile = await ImagePicker().getImage(
//       source: ImageSource.gallery,
//     );
//     if (pickedFile != null) {
//       setState(() {
//         aadharImage =  File(pickedFile.path);
//         // imagePath = File(pickedFile.path) ;
//         // filePath = imagePath!.path.toString();
//       });
//     }
//   }
//
//   uploadPanFromCamOrGallary(BuildContext context) {
//     containerForSheet<String>(
//       context: context,
//       child: CupertinoActionSheet(
//         actions: <Widget>[
//           CupertinoActionSheetAction(
//             child: Text(
//               "Camera",
//               style: TextStyle(color: Colors.black, fontSize: 15),
//             ),
//             onPressed: () {
//               getPanFromCamera();
//               Navigator.of(context, rootNavigator: true).pop("Discard");
//             },
//           ),
//           CupertinoActionSheetAction(
//             child: Text(
//               "Photo & Video Library",
//               style: TextStyle(color: Colors.black, fontSize: 15),
//             ),
//             onPressed: () {
//               getPanFromGallery();
//               Navigator.of(context, rootNavigator: true).pop("Discard");
//             },
//           ),
//         ],
//         cancelButton: CupertinoActionSheetAction(
//           child: Text(
//             "Cancel",
//             style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
//           ),
//           isDefaultAction: true,
//           onPressed: () {
//             // Navigator.pop(context, 'Cancel');
//             Navigator.of(context, rootNavigator: true).pop("Discard");
//           },
//         ),
//       ),
//     );
//   }
//
//   Future<void> getPanFromCamera() async {
//     PickedFile? pickedFile = await ImagePicker().getImage(
//       source: ImageSource.camera,
//     );
//     if (pickedFile != null) {
//       setState(() {
//         panImage =  File(pickedFile.path);
//         // imagePath = File(pickedFile.path) ;
//         // filePath = imagePath!.path.toString();
//       });
//     }
//   }
//
//   Future<void> getPanFromGallery() async {
//     PickedFile? pickedFile = await ImagePicker().getImage(
//       source: ImageSource.gallery,
//     );
//     if (pickedFile != null) {
//       setState(() {
//         panImage =  File(pickedFile.path);
//         // imagePath = File(pickedFile.path) ;
//         // filePath = imagePath!.path.toString();
//       });
//     }
//   }
//
//
//   Widget imageRC() {
//     return Material(
//       elevation: 2,
//       borderRadius: BorderRadius.circular(15),
//       child: InkWell(
//         onTap: () {
//           uploadRCFromCamOrGallary(context);
//         },
//         child: Container(
//           height: 100,
//           width: 100,
//           decoration: BoxDecoration(
//               border: Border.all(color: Colors.grey),
//               borderRadius: BorderRadius.circular(15)
//           ),
//           child: ClipRRect(
//             borderRadius: BorderRadius.circular(15),
//             child: rcImage != null ?
//             Image.file(rcImage!, fit: BoxFit.cover)
//                 : Column(
//               children: [
//                 Icon(Icons.person, size: 60),
//                 Text("Upload RC Book")
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget imageAadhar() {
//     return Material(
//       elevation: 2,
//       borderRadius: BorderRadius.circular(15),
//       child: InkWell(
//         onTap: () {
//           uploadAadharFromCamOrGallary(context);
//         },
//         child: Container(
//           height: 130,
//           width: 130,
//           decoration: BoxDecoration(
//               border: Border.all(color: Colors.grey),
//               borderRadius: BorderRadius.circular(15)
//           ),
//           child: ClipRRect(
//             borderRadius: BorderRadius.circular(15),
//             child: aadharImage != null ?
//             Image.file(aadharImage!, fit: BoxFit.cover)
//                 : Column(
//               children: [
//                 Icon(Icons.person, size: 60),
//                 Text("Upload Aadhar")
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget imagePan() {
//     return Material(
//       elevation: 2,
//       borderRadius: BorderRadius.circular(15),
//       child: InkWell(
//         onTap: () {
//           uploadPanFromCamOrGallary(context);
//         },
//         child: Container(
//           height: 130,
//           width: 130,
//           decoration: BoxDecoration(
//               border: Border.all(color: Colors.grey),
//               borderRadius: BorderRadius.circular(15)
//           ),
//           child: ClipRRect(
//             borderRadius: BorderRadius.circular(15),
//             child: panImage != null ?
//             Image.file(panImage!, fit: BoxFit.cover)
//                 : Column(
//               children: [
//                 Icon(Icons.person, size: 60),
//                 Text("Upload Pan Card")
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//
//
//   submitRequest()async{
//
//     print("checking date submit request");
//     var headers = {
//       'Cookie': 'ci_session=cf2fmpq7vue0kthvj5s046uv4m2j5r11'
//     };
//     var request = http.MultipartRequest('POST', Uri.parse('${Apipath.labourRegistrationUrl}'));
//     request.fields.addAll({
//       'name': '${nameController.text.toString()}',
//       'mobile': '${mobileController.text.toString()}',
//       'email':'${emailController.text.toString()}',
//       'address': '${pickLocationController.text.toString()}',
//       'category_id': '${selectedCategory.toString()}',
//       'experience': '${selectExperience.toString()}',
//       'per_day_charge':'${perKmController.text.toString()}'
//
//     });
//     // if (rcImage != null) {
//     // }
//     // if (aadharImage != null) {
//     request.files.add(
//         await http.MultipartFile.fromPath('adhar_card', aadharImage!.path));
//     // }
//     // if (panImage != null) {
//     request.files.add(
//         await http.MultipartFile.fromPath('pancard', panImage!.path));
//     // }
//
//     print("ok ${request.fields} ${request.files}");
//     request.headers.addAll(headers);
//
//     var response = await request.send();
//
//     if (response.statusCode == 200) {
//       var finalResult = await response.stream.bytesToString();
//       print("this is respoinse @@ ${response.statusCode}");
//       _showMyDialog();
//       // final jsonResponse = ServiceRequestModel.fromJson(json.decode(finalResult));
//       // print("checking json response ${jsonResponse.msg} and ${jsonResponse.responseCode}");
//       // if(finalResult.responseCode == "0"){
//       // }
//       // else{
//       //   Fluttertoast.showToast(msg: "${jsonResponse.msg}");
//       //   Navigator.push(context, MaterialPageRoute(builder: (context) => TabbarScreen()));
//       // }
//
//     }
//     else {
//       Fluttertoast.showToast(msg: "Something went wrong!!");
//       print(response.reasonPhrase);
//     }
//
//   }
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     _getCollection();
//   }
//   String _dateValue = '';
//   String addId = '';
//   var dateFormate;
//   String _pickedLocation = '';
//   String? pickLat;
//   String? pickLong;
//   String? dropLat;
//   String? dropLong;
//   // Future getAddress(id) async {
//   //   var request =
//   //   http.MultipartRequest('POST', Uri.parse('$getAddressUrl'));
//   //   request.fields.addAll({'id': '$id', 'user_id': '$userID'});
//   //
//   //   print(request);
//   //   print(request.fields);
//   //
//   //   http.StreamedResponse response = await request.send();
//   //   if (response.statusCode == 200) {
//   //     final str = await response.stream.bytesToString();
//   //     final jsonResponse = AddressModel.fromJson(json.decode(str));
//   //     if (jsonResponse.responseCode == "1") {
//   //       setState(() {
//   //         _pickedLocation =
//   //         "${jsonResponse.data![0].address!}, ${jsonResponse.data![0].building}";
//   //       });
//   //     }
//   //     print(_pickedLocation);
//   //     return AddressModel.fromJson(json.decode(str));
//   //   } else {
//   //     return null;
//   //   }
//   // }
//   // void _showDialog(){
//   //   showDialog(
//   //     context: context,
//   //     builder: (ctx) => AlertDialog(
//   //       // insetPadding: EdgeInsets.zero,
//   //       shape: RoundedRectangleBorder(
//   //         borderRadius: BorderRadius.circular(30),
//   //       ),
//   //       title: const Center(
//   //         child: Text("Summary",style: TextStyle(
//   //             color: backgroundblack,
//   //             fontSize: 16,
//   //             fontWeight: FontWeight.w600
//   //         ),),
//   //       ),
//   //       content: SingleChildScrollView(
//   //           child: Container(
//   //             child:  Column(
//   //               crossAxisAlignment: CrossAxisAlignment.start,
//   //               children: [
//   //                 rowElements("Pickup Location", '${pickLocationController.text.toString()}',),
//   //                 rowElements("Drop Location", '${dropLocationController.text.toString()}',),
//   //                 rowElements("Select Vehicle", '${selectVehicle.toString()}',),
//   //                 rowElements("Date", '${dateFormate.toString()}',),
//   //                 rowElements("Time", "${selectedTime!.format(context)}",),
//   //                 rowElements("Select Category", '${selectedCategory.toString()}',),
//   //                 rowElements("Select Subcategory", '${selectedSubcategory.toString()}',),
//   //                 rowElements("Dimension", "Height: ${heightController.text.toString()}  Width: ${widthController.text.toString()}"),
//   //                 rowElements("Weight", '${weightController.text.toString()}'),
//   //                 SizedBox(height: 20,),
//   //                 Center(
//   //                   child: Container(
//   //                     width: 250,
//   //                     height: 50,
//   //                     child: ElevatedButton(
//   //                       child: Text(
//   //                         'Confirm',
//   //                         style: TextStyle(
//   //
//   //                           fontSize: 20,
//   //                         ),
//   //                       ),
//   //                       style: ElevatedButton.styleFrom(
//   //                         shape: RoundedRectangleBorder(
//   //                             borderRadius: BorderRadius.circular(10)
//   //                         ),
//   //                         primary: backgroundblack,
//   //                       ),
//   //                       onPressed: () {
//   //                         submitRequest();
//   //                       },
//   //                     ),
//   //                   ),
//   //
//   //                 )
//   //
//   //               ],
//   //
//   //             ),
//   //           )
//   //       ),
//   //       actions: <Widget>[
//   //
//   //       ],
//   //     ),
//   //   );
//   //
//   //
//   //
//   //   if (_formKey.currentState!.validate()) {
//   //   } else {}
//   //
//   // }
//   final _formKey = GlobalKey<FormState>();
//
//
//   String convertDateTimeDisplay(String date) {
//     final DateFormat displayFormater = DateFormat('yyyy-MM-dd HH:mm:ss.SSS');
//     final DateFormat serverFormater = DateFormat('yyyy-MM-dd');
//     final DateTime displayDate = displayFormater.parse(date);
//     final String formatted = serverFormater.format(displayDate);
//     return formatted;
//   }
//
//   TimeOfDay? selectedTime;
//   String? sDate;
//
//   // submitRequest()async{
//   //
//   //   print("checking date ${sDate}");
//   //   var headers = {
//   //     'Cookie': 'ci_session=cf2fmpq7vue0kthvj5s046uv4m2j5r11'
//   //   };
//   //   var request = http.MultipartRequest('POST', Uri.parse('$bookDeliveryUrl'));
//   //   request.fields.addAll({
//   //     'pickup_location': '${pickLocationController.text.toString()}',
//   //     'drop_location':'${dropLocationController.text.toString()}',
//   //     'vehicle_type': '${selectVehicle.toString()}',
//   //     'date': '${sDate.toString()}',
//   //     'time': "${selectedTime!.format(context)}",
//   //     'height': '${heightController.text.toString()}',
//   //     'length': '${widthController.text.toString()}',
//   //     'weight': '${weightController.text.toString()}',
//   //     'pickup_lat': '${pickLat.toString()}',
//   //     'pickup_lng': '${pickLong.toString()}',
//   //     'drop_lat': '${dropLat.toString()}',
//   //     'drop_lng': '${dropLong.toString()}',
//   //     'user_id': '${userID}',
//   //     'category_id': '${selectedCategory.toString()}',
//   //     'sub_category_id': '${selectedSubcategory.toString()}',
//   //     // 'budget': '${priceController.text}'
//   //   });
//   //
//   //
//   //   print("ok ${request.fields}");
//   //   request.headers.addAll(headers);
//   //
//   //   http.StreamedResponse response = await request.send();
//   //
//   //   if (response.statusCode == 200) {
//   //     var finalResult = await response.stream.bytesToString();
//   //     final jsonResponse = ServiceRequestModel.fromJson(json.decode(finalResult));
//   //     print("checking json response ${jsonResponse.msg} and ${jsonResponse.responseCode}");
//   //     if(jsonResponse.responseCode == "0"){
//   //       Fluttertoast.showToast(msg: "${jsonResponse.msg}");
//   //     }
//   //     else{
//   //       Fluttertoast.showToast(msg: "${jsonResponse.msg}");
//   //       Navigator.push(context, MaterialPageRoute(builder: (context) => TabbarScreen()));
//   //     }
//   //
//   //   }
//   //   else {
//   //     print(response.reasonPhrase);
//   //   }
//   //
//   // }
//
//   _getPickLocation() async {
//     LocationResult result = await Navigator.of(context).push(MaterialPageRoute(
//         builder: (context) => PlacePicker(
//           "AIzaSyCqQW9tN814NYD_MdsLIb35HRY65hHomco",
//         )));
//     print("checking adderss detail ${result.country!.name.toString()} and ${result.locality.toString()} and ${result.country!.shortName.toString()} ");
//     setState(() {
//       pickLocationController.text = result.formattedAddress.toString();
//       pickLat = result.latLng!.latitude.toString();
//       pickLong = result.latLng!.longitude.toString();
//       // cityC.text = result.locality.toString();
//       // stateC.text = result.administrativeAreaLevel1!.name.toString();
//       // countryC.text = result.country!.name.toString();
//       // lat = result.latLng!.latitude;
//       // long = result.latLng!.longitude;
//       // pincodeC.text = result.postalCode.toString();
//     });
//     print("this is picked LAT LONG $pickLat @@ $pickLong");
//   }
//
//   var items = [
//     'Fresher',
//     '6 months experience',
//     '1 year experience',
//     '2 year experience',
//     '3 year experience',
//     '4 year experience',
//     '5+ year experience',
//   ];
//   String selectExperience = 'Fresher';
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColor().colorPrimary(),
//       appBar: AppBar(
//         elevation: 0,
//         centerTitle: true,
//         backgroundColor: AppColor().colorPrimary(),
//         leading: IconButton(
//           onPressed: (){
//             Navigator.pop(context);
//           },
//           icon: Icon(Icons.arrow_back_ios, color: AppColor().colorBg1(),),
//         ),
//         title: Text("Labour Service", style: TextStyle(
//             color: AppColor().colorBg1()
//         ),),
//       ),
//       body: Container(
//           padding: EdgeInsets.only(top: 30),
//           // height: MediaQuery.of(context).size.height-120,
//           width: MediaQuery.of(context).size.width,
//           decoration: BoxDecoration(
//               color: AppColor().colorBg1(),
//               borderRadius: BorderRadius.only(topRight: Radius.circular(30), topLeft: Radius.circular(30),)
//           ),
//           child: Form(
//             key: _formKey,
//             child: ListView(
//               padding: EdgeInsets.symmetric(horizontal: 15,vertical: 15),
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.only(left: 5.0),
//                   child: Text("Full Name",
//                     style: TextStyle(
//                         fontSize: 15,
//                         color: AppColor().colorSecondary()
//                     ),),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(top: 5.0, bottom: 10),
//                   child: Container(
//                     child: TextFormField( controller: nameController,
//                       keyboardType: TextInputType.name,
//                       validator: (v){
//                         if(v!.isEmpty){
//                           return "Enter Full Name";
//                         }
//                       },
//                       decoration: InputDecoration(
//                           hintText: "Full Name",
//                           border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(7),
//                               borderSide: BorderSide(color: AppColor().colorTextPrimary().withOpacity(0.5))
//                           )
//                       ),),
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(left: 5.0),
//                   child: Text("Mobile No.",
//                     style: TextStyle(
//                         fontSize: 15,
//                         color: AppColor().colorSecondary()
//                     ),),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(top: 5.0, bottom: 10),
//                   child: Container(
//                     child: TextFormField( controller: mobileController,
//                       keyboardType: TextInputType.number,
//                       validator: (v){
//                         if(v!.isEmpty){
//                           return "Enter Mobile No.";
//                         }
//                       },
//                       decoration: InputDecoration(
//                           hintText: "Mobile No.",
//                           border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(7),
//                               borderSide: BorderSide(color: AppColor().colorTextPrimary().withOpacity(0.5))
//                           )
//                       ),),
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(left: 5.0),
//                   child: Text("Email",
//                     style: TextStyle(
//                         fontSize: 15,
//                         color: AppColor().colorSecondary()
//                     ),),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(top: 5.0, bottom: 10),
//                   child: Container(
//                     child: TextFormField( controller: emailController,
//                       keyboardType: TextInputType.emailAddress,
//                       validator: (v){
//                         if(v!.isEmpty){
//                           return "Enter Email";
//                         }
//                       },
//                       decoration: InputDecoration(
//                           hintText: "Email",
//                           border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(7),
//                               borderSide: BorderSide(color: AppColor().colorTextPrimary().withOpacity(0.5))
//                           )
//                       ),),
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(left: 5.0),
//                   child: Text("Full Address",
//                     style: TextStyle(
//                         fontSize: 15,
//                         color: AppColor().colorSecondary()
//                     ),),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(top: 5.0, bottom: 10),
//                   child: TextFormField(
//                     controller: pickLocationController,
//                     validator: (v){
//                       if(v!.isEmpty){
//                         return "Enter Full Address";
//                       }
//                     },
//                     onTap: (){
//                       _getPickLocation();
//                     },
//                     decoration: InputDecoration(
//                         hintText: "Full Address",
//                         border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(7),
//                             borderSide: BorderSide(color: AppColor().colorTextPrimary().withOpacity(0.5))
//                         )
//                     ),),
//                 ),
//
//                 Padding(
//                   padding: const EdgeInsets.only(left: 5.0),
//                   child: Text("Select Category",
//                     style: TextStyle(
//                         fontSize: 15,
//                         color: AppColor().colorSecondary()
//                     ),),
//                 ),
//
//
//                 Padding(
//                   padding: const EdgeInsets.only(top: 5.0, bottom: 10),
//                   child: Container(
//                     height: 60,
//                     padding: EdgeInsets.only(left: 10),
//                     decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(7),
//                         border: Border.all(color: AppColor().colorTextPrimary().withOpacity(0.3))
//                     ),
//                     child: DropdownButton(
//
//                       value: selectedCategory,
//                       underline: Container(),
//
//                       icon: Icon(Icons.keyboard_arrow_down, color: Colors.white,),
//                       hint: Text("Select category"),
// isExpanded: true,
//
//                       items: catlist.map((items) {
//                         return DropdownMenuItem(
//                           value: items.id,
//                           child: Container(
//                               child: Text(items.cName.toString())),
//                         );
//                       }).toList(),
//
//                       onChanged: (String? newValue) {
//                         setState(() {
//                           selectedCategory = newValue!;
//
//                           print("selected category ${selectedCategory}");
//                         });
//                       },
//                     ),
//                   ),
//                 ),
//
//
//                 Padding(
//                   padding: const EdgeInsets.only(left: 5.0),
//                   child: Text("Experience",
//                     style: TextStyle(
//                         fontSize: 15,
//                         color: AppColor().colorSecondary()
//                     ),),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(top: 5.0, bottom: 10),
//                   child: Container(
//                     height: 60,
//                     width: MediaQuery.of(context).size.width,
//                     padding: EdgeInsets.symmetric(horizontal: 10),
//                     // alignment: Alignment.centerLeft,
//                     decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(7),
//                         border: Border.all(color: AppColor().colorTextPrimary().withOpacity(0.5))
//                     ),
//                     child: DropdownButtonHideUnderline(
//                       child: DropdownButton(
//                         iconEnabledColor: AppColor().colorBg1(),
//                         iconDisabledColor: AppColor().colorBg1(),
//
//                         // Initial Value
//                         value: selectExperience,
//                         isExpanded: true,
//                         // Down Arrow Icon
//                         icon: const Icon(Icons.keyboard_arrow_down),
//
//                         // Array list of items
//                         items: items.map((String items) {
//                           return DropdownMenuItem(
//                             value: items,
//                             child: Text(items),
//                           );
//                         }).toList(),
//                         // After selecting the desired option,it will
//                         // change button value to selected value
//                         onChanged: (String? newValue) {
//                           setState(() {
//                             selectExperience = newValue!;
//                           });
//                         },
//                       ),
//                     ),
//
//                     //_pickedLocation.length > 0 ? Text("${_pickedLocation}",style: TextStyle(height: 1.2),) : Text("Select address",style: TextStyle(color: AppColor().colorTextPrimary().withOpacity(0.5)),)
//                   ),
//                 ),
//
//
//
//                 Padding(
//                   padding: const EdgeInsets.only(left: 5.0),
//                   child: Text("Per Day Charge",
//                     style: TextStyle(
//                         fontSize: 15,
//                         color: AppColor().colorSecondary()
//                     ),),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(top: 5.0, bottom: 10),
//                   child: Container(
//                     child: TextFormField( controller: perKmController,
//                       keyboardType: TextInputType.number,
//                       validator: (v){
//                         if(v!.isEmpty){
//                           return "Enter Per Day charge";
//                         }
//                       },
//                       decoration: InputDecoration(
//                           hintText: "Per Day Charge",
//                           border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(7),
//                               borderSide: BorderSide(color: AppColor().colorTextPrimary().withOpacity(0.5))
//                           )
//                       ),),
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(top: 10.0, bottom: 20),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       // Column(
//                       //   children: [
//                       //     Padding(
//                       //       padding: const EdgeInsets.only(left: 5.0, bottom: 5),
//                       //       child: Text("RC Book",
//                       //         style: TextStyle(
//                       //             fontSize: 15,
//                       //             color: AppColor().colorSecondary()
//                       //         ),),
//                       //     ),
//                       //     imageRC(),
//                       //   ],
//                       // ),
//                       Column(
//                         children: [
//                           Padding(
//                             padding: const EdgeInsets.only(left: 5.0, bottom: 5),
//                             child: Text("Aadhar",
//                               style: TextStyle(
//                                   fontSize: 15,
//                                   color: AppColor().colorSecondary()
//                               ),),
//                           ),
//                           imageAadhar(),
//                         ],
//                       ),
//                       SizedBox(width: 20,),
//                       Column(
//                         children: [
//                           Padding(
//                             padding: const EdgeInsets.only(left: 5.0, bottom: 5),
//                             child: Text("Pan Card",
//                               style: TextStyle(
//                                   fontSize: 15,
//                                   color: AppColor().colorSecondary()
//                               ),),
//                           ),
//                           imagePan(),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(top: 5.0, bottom: 10),
//                   child: InkWell(
//                     onTap: (){
//
//                       if(_formKey.currentState!.validate()){
//                         submitRequest();
//                         // _showDialog();
//                         //
//                       }
//                       else{
//                         Fluttertoast.showToast(msg: "Please Enter all fields");
//                       }
//                       //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => TabbarScreen()));
//                     },
//                     child: Container(
//                       height: 50,
//                       alignment: Alignment.center,
//                       decoration: BoxDecoration(
//                           color: AppColor().colorPrimary(),
//                           borderRadius: BorderRadius.circular(7)
//                       ),
//                       child: Text("Submit",style: TextStyle(color: AppColor().colorBg1(),fontSize: 16,fontWeight: FontWeight.w600),),
//                     ),
//                   ),
//                 )
//               ],
//             ),
//           )
//       ),
//     );
//   }
// }
//
//
