import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:fixerking/RideFlow/utils/Session.dart';
import 'package:fixerking/RideFlow/utils/location_details.dart';
import 'package:fixerking/api/api_path.dart';
import 'package:fixerking/new%20model/registration_model.dart';
import 'package:fixerking/screen/auth_view/login.dart';
import 'package:fixerking/utility_widget/customLoader.dart';
import 'package:fixerking/utils/app_button.dart';
import 'package:fixerking/utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_place_picker_mb/google_maps_place_picker.dart';
// import 'package:google_maps_place_picker_mb/google_maps_place_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:image_picker_gallery_camera/image_picker_gallery_camera.dart';
import 'package:location/location.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';


import '../../new model/cities_model.dart';
import '../../new model/event_category_model.dart';

class VendorRegisteration extends StatefulWidget {
  final String role;
  final double? lat, long;
  const VendorRegisteration({Key? key, required this.role, this.lat, this.long}) : super(key: key);

  @override
  State<VendorRegisteration> createState() => _VendorRegisterationState();
}

class _VendorRegisterationState extends State<VendorRegisteration> {

  String? bankValue;
  String? categoryValue;
  String? catValue;
  var accTypeValue;
  File? rcImage;
  File? aadharImage;
  File? panImage;
  File? drivingImage;

  String? type;
  String? appBarTitle;
  String? restroType;

  int _value = 1;
  int? _value1 = 1;
  int? _value2 = 1;
  int? _value3 = 1;

  String? gender;
  bool isUpi = false;
  bool roleUser = true;
  List _selectedItems = [];
  List selectedCategoryItems = [];
  String? selectCatItems;
  bool isLoading = false;
  bool pass = true;
  bool cPass = true;

  getLocation() {
    print("current location initiated ----->>>");
    GetLocation location = new GetLocation((result) {
      // if (mounted) {
        setState(() {
         String address = result.first.addressLine;
          pickLat = result.first.coordinates.latitude;
          pickLong = result.first.coordinates.longitude;
          addressController.text = address;
        });
        print("this is address ${result.first.addressLine}");
      // }
    });
    location.getLoc();
    print("this is current location --->>> ${addressController.text.toString()}");
  }

  _getAddressFromLatLng() async {
    getUserCurrentLocation().then((_) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      try {
        List<Placemark> p = await placemarkFromCoordinates(
            currentLocation!.latitude, currentLocation!.longitude);

        Placemark place = p[0];

        setState(() {
          addressController.text =
          "${place.street}, ${place.subLocality}, ${place.locality}, ${place.country}";
        });
        print("this is address ${addressController.text.toString()}");
      } catch (e) {
        print(e);
      }
    });
  }

  void _showMultiSelect() async {
    final List? results = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState)
        {
          return
            MultiSelect(type: type.toString(),);
        }
        );
      },
    );

    // Update UI
    if (results != null) {
      setState(() {
        _selectedItems = results;
      });
      selectedCategoryItems = results.map((item) => item.id).toList();
      selectCatItems = selectedCategoryItems.join(',');
      print("this is result == ${_selectedItems.toString()} aaaaand ${selectedCategoryItems.toString()} &&&&&& ${selectCatItems.toString()}");
    }
  }

  TextEditingController nameController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController fssaiController = TextEditingController();
  TextEditingController vehicleController = TextEditingController();
  TextEditingController companyController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPassController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController gstController = TextEditingController();
  TextEditingController storeNameController = TextEditingController();
  TextEditingController upiController = TextEditingController();
  TextEditingController accountHolderController = TextEditingController();
  TextEditingController accountNoController = TextEditingController();
  TextEditingController ifscController = TextEditingController();
  TextEditingController confmAccountNumController = TextEditingController();
  TextEditingController bankNameController = TextEditingController();
  TextEditingController referallController = TextEditingController();
  TextEditingController storeDescriptionController = TextEditingController();

  void containerForSheet<T>({BuildContext? context, Widget? child}) {
    showCupertinoModalPopup<T>(
      context: context!,
      builder: (BuildContext context) => child!,
    ).then<void>((T? value) {});
  }

  uploadRCFromCamOrGallary(BuildContext context) {
    containerForSheet<String>(
      context: context,
      child: CupertinoActionSheet(
        actions: <Widget>[
          CupertinoActionSheetAction(
            child: Text(
              "Camera",
              style: TextStyle(color: Colors.black, fontSize: 15),
            ),
            onPressed: () {
              getRCFromCamera();
              Navigator.of(context, rootNavigator: true).pop("Discard");
            },
          ),
          CupertinoActionSheetAction(
            child: Text(
              "Photo & Video Library",
              style: TextStyle(color: Colors.black, fontSize: 15),
            ),
            onPressed: () {
              getRCFromGallery();
              Navigator.of(context, rootNavigator: true).pop("Discard");
            },
          ),
        ],
        cancelButton: CupertinoActionSheetAction(
          child: Text(
            "Cancel",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          isDefaultAction: true,
          onPressed: () {
            // Navigator.pop(context, 'Cancel');
            Navigator.of(context, rootNavigator: true).pop("Discard");
          },
        ),
      ),
    );
  }

  Future<void> getRCFromCamera() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
    );
    if (pickedFile != null) {
      setState(() {
        rcImage = File(pickedFile.path);
        // imagePath = File(pickedFile.path) ;
        // filePath = imagePath!.path.toString();
      });
    }
  }

  Future<void> getRCFromGallery() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      setState(() {
        rcImage = File(pickedFile.path);
        // imagePath = File(pickedFile.path) ;
        // filePath = imagePath!.path.toString();
      });
    }
  }

  uploadAadharFromCamOrGallary(BuildContext context) {
    containerForSheet<String>(
      context: context,
      child: CupertinoActionSheet(
        actions: <Widget>[
          CupertinoActionSheetAction(
            child: Text(
              "Camera",
              style: TextStyle(color: Colors.black, fontSize: 15),
            ),
            onPressed: () {
              getAadharFromCamera();
              Navigator.of(context, rootNavigator: true).pop("Discard");
            },
          ),
          CupertinoActionSheetAction(
            child: Text(
              "Photo & Video Library",
              style: TextStyle(color: Colors.black, fontSize: 15),
            ),
            onPressed: () {
              getAadharFromGallery();
              Navigator.of(context, rootNavigator: true).pop("Discard");
            },
          ),
        ],
        cancelButton: CupertinoActionSheetAction(
          child: Text(
            "Cancel",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          isDefaultAction: true,
          onPressed: () {
            // Navigator.pop(context, 'Cancel');
            Navigator.of(context, rootNavigator: true).pop("Discard");
          },
        ),
      ),
    );
  }

  Future<void> getAadharFromCamera() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
    );
    if (pickedFile != null) {
      setState(() {
        aadharImage = File(pickedFile.path);
        // imagePath = File(pickedFile.path) ;
        // filePath = imagePath!.path.toString();
      });
      print("this is image path from camera ${aadharImage.toString()}");

    }

  }

  Future<void> getAadharFromGallery() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      setState(() {
        aadharImage = File(pickedFile.path);
        // imagePath = File(pickedFile.path) ;
        // filePath = imagePath!.path.toString();
      });
    }
  }

  uploadPanFromCamOrGallary(BuildContext context) {
    containerForSheet<String>(
      context: context,
      child: CupertinoActionSheet(
        actions: <Widget>[
          CupertinoActionSheetAction(
            child: Text(
              "Camera",
              style: TextStyle(color: Colors.black, fontSize: 15),
            ),
            onPressed: () {
              getPanFromCamera();
              Navigator.of(context, rootNavigator: true).pop("Discard");
            },
          ),
          CupertinoActionSheetAction(
            child: Text(
              "Photo & Video Library",
              style: TextStyle(color: Colors.black, fontSize: 15),
            ),
            onPressed: () {
              getPanFromGallery();
              Navigator.of(context, rootNavigator: true).pop("Discard");
            },
          ),
        ],
        cancelButton: CupertinoActionSheetAction(
          child: Text(
            "Cancel",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          isDefaultAction: true,
          onPressed: () {
            // Navigator.pop(context, 'Cancel');
            Navigator.of(context, rootNavigator: true).pop("Discard");
          },
        ),
      ),
    );
  }

  Future<void> getPanFromCamera() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
    );
    if (pickedFile != null) {
      setState(() {
        panImage = File(pickedFile.path);
        // imagePath = File(pickedFile.path) ;
        // filePath = imagePath!.path.toString();
      });
    }
  }

  Future<void> getPanFromGallery() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      setState(() {
        panImage = File(pickedFile.path);
        // imagePath = File(pickedFile.path) ;
        // filePath = imagePath!.path.toString();
      });
    }
  }

  uploaddrivingFromCamOrGallary(BuildContext context) {
    containerForSheet<String>(
      context: context,
      child: CupertinoActionSheet(
        actions: <Widget>[
          CupertinoActionSheetAction(
            child: Text(
              "Camera",
              style: TextStyle(color: Colors.black, fontSize: 15),
            ),
            onPressed: () {
              getdrivingFromCamera();
              Navigator.of(context, rootNavigator: true).pop("Discard");
            },
          ),
          CupertinoActionSheetAction(
            child: Text(
              "Photo & Video Library",
              style: TextStyle(color: Colors.black, fontSize: 15),
            ),
            onPressed: () {
              getdrivingFromGallery();
              Navigator.of(context, rootNavigator: true).pop("Discard");
            },
          ),
        ],
        cancelButton: CupertinoActionSheetAction(
          child: Text(
            "Cancel",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          isDefaultAction: true,
          onPressed: () {
            // Navigator.pop(context, 'Cancel');
            Navigator.of(context, rootNavigator: true).pop("Discard");
          },
        ),
      ),
    );
  }

  Future<void> getdrivingFromCamera() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
    );
    if (pickedFile != null) {
      setState(() {
        drivingImage = File(pickedFile.path);
        // imagePath = File(pickedFile.path) ;
        // filePath = imagePath!.path.toString();
      });
    }
  }

  Future<void> getdrivingFromGallery() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      setState(() {
        drivingImage = File(pickedFile.path);
        // imagePath = File(pickedFile.path) ;
        // filePath = imagePath!.path.toString();
      });
    }
  }

  Widget imageRC() {
    return Material(
      elevation: 2,
      borderRadius: BorderRadius.circular(15),
      child: InkWell(
        onTap: () {
          requestPermission(context, 3);
          // uploadRCFromCamOrGallary(context);
        },
        child: Center(
          child: Container(
            height: 100,
            width: MediaQuery.of(context).size.width - 60,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(15)),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: rcImage != null
                  ? Image.file(rcImage!, fit: BoxFit.cover)
                  : Column(
                children: [
                  Center(
                      child: Icon(Icons.upload_file_outlined, size: 60)),
                  Text("Registration Card")
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget imageAadhar() {
    return Material(
      elevation: 2,
      borderRadius: BorderRadius.circular(15),
      child: InkWell(
        onTap: () {
          getImage(ImgSource.Both, context,1);
          // requestPermission(context, 1);
          //uploadAadharFromCamOrGallary(context);
        },
        child: Center(
          child: Container(
            height: 100,
            width: MediaQuery.of(context).size.width - 60,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(15)),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: aadharImage != null
                  ? Image.file(aadharImage!, fit: BoxFit.cover)
                  : Column(
                children: [
                  Center(
                      child: Icon(Icons.upload_file_outlined, size: 60)),
                  Text("Aadhar card")
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget imagePan() {
    return Material(
      elevation: 2,
      borderRadius: BorderRadius.circular(15),
      child: InkWell(
        onTap: () {
          requestPermission(context, 2);
          // uploadPanFromCamOrGallary(context);
        },
        child: Center(
          child: Container(
            height: 100,
            width: MediaQuery.of(context).size.width - 60,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(15),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: panImage != null
                  ? Image.file(panImage!, fit: BoxFit.cover)
                  : Column(
                children: [
                  Center(
                      child: Icon(Icons.upload_file_outlined, size: 60)),
                  Text("Pan Card")
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget imagedriving() {
    return Material(
      elevation: 2,
      borderRadius: BorderRadius.circular(15),
      child: InkWell(
        onTap: () {
          requestPermission(context, 4);
          // uploaddrivingFromCamOrGallary(context);
        },
        child: Center(
          child: Container(
            height: 100,
            width: MediaQuery.of(context).size.width - 60,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(15),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: drivingImage != null
                  ? Image.file(drivingImage!, fit: BoxFit.cover)
                  : Column(
                children: const [
                  Center(
                      child: Icon(Icons.upload_file_outlined, size: 60)),
                  Text("Driving License"),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  submitRequest() async {
    // showDialog(context: context, builder: (context){
    //   return CustomLoader(text: "Verifying user, please wait...",);
    // });
    print("checking date submit request");
    var headers = {'Cookie': 'ci_session=cf2fmpq7vue0kthvj5s046uv4m2j5r11'};

    var request = http.MultipartRequest(
        'POST', Uri.parse('${Apipath.vendorRegistrationUrl}'));
    request.fields.addAll({
      'type': "$type",
      'name': '${nameController.text.toString()}',
      'mobile': '${mobileController.text.toString()}',
      'email': '${emailController.text.toString()}',
      'lat': '${pickLat.toString()}',
      'lang': '${pickLong.toString()}',
      'address': '${addressController.text.toString()}',
      'password': '${passwordController.text.toString()}',
    'friend_code': '${referallController.text.toString()}',
      'bank_upi': isUpi
          ? '{"account_holder_name" : "${accountHolderController.text.toString()}","account_number" : "${accountNoController.text.toString()}","bank_name" : "${bankNameController.text.toString()}","account_type": "${accTypeValue.toString()}","ifsc_code" : "${ifscController.text.toString()}"}'
          : '{"UPI" : "${upiController.text.toString()}"}'
    });

    ///orderfood
    if (type == "1") {
      request.fields.addAll({
        'store_name': '${storeNameController.text.toString()}',
        'fssai': '${fssaiController.text.toString()}',
        'gst_no': '${gstController.text.toString()}',
        'store_description': '${storeDescriptionController.text.toString()}',
        'restro_type': '${restroType.toString()}'
      });
    }
    String delType = '';
    if(deliveryTypeValue == "Delivery Only"){
      setState((){
        delType = 'delivery_only';
      });
    }else if(deliveryTypeValue == "Ride Only"){
      setState((){
        delType = 'ride_only';
      });
    }else{
      setState((){
        delType = 'both';
      });
    }

    ///2wheeler
    if (type == "2" || type == "3" || type == "4") {
      request.fields.addAll({
        'vehicle_no': '${vehicleController.text.toString()}',
        'city_id': '${categoryValue.toString()}',
        'delivery_type' : '${delType.toString()}'
      });
      if (rcImage != null) {
        request.files.add(await http.MultipartFile.fromPath(
            'registarion_card', rcImage!.path));
      }
      if (drivingImage != null) {
        request.files.add(await http.MultipartFile.fromPath(
            'driving_license', drivingImage!.path));
      }
    }

    ///Event
    if (type == "5") {
      request.fields.addAll({
        'city_id': '${categoryValue.toString()}',
        'company_name': roleUser ? '${companyController.text.toString()}' :'freelancer',
        'categories_id': '${selectCatItems.toString()}',
        'gst_no' :  '${gstController.text.toString()}',
        'role_user': roleUser ? 'company' : 'freelancer' ,
        'gender': '$gender'


      });
    }

    if (type == "6") {
      request.fields.addAll({
        'city_id': '${categoryValue.toString()}',
        'company_name': roleUser ? '${companyController.text.toString()}' :'freelancer',
        'categories_id': '${selectCatItems.toString()}',
        'gst_no' :  '${gstController.text.toString()}',
        'role_user': roleUser ? 'company' : 'freelancer' ,
      });
    }
    ///handyman
    if (type == "7") {
      request.fields.addAll({
        'city_id': '${categoryValue.toString()}',
        'company_name': roleUser ? '${companyController.text.toString()}' :'freelancer',
        'categories_id': '${selectCatItems.toString()}',
        'gst_no' : '${gstController.text.toString()}',
        'role_user': roleUser ? 'company' : 'freelancer' ,
      });
    }

    if (aadharImage != null) {
      request.files.add(
          await http.MultipartFile.fromPath('adhar_card', aadharImage!.path));
    }
    if (panImage != null) {
      request.files
          .add(await http.MultipartFile.fromPath('pancard', panImage!.path));
    }

    print("ok++++++++======>>>>${request.fields} ${request.files}");
    request.headers.addAll(headers);

    var response = await request.send();

    String str = await response.stream.bytesToString();

    print("this is response =========>>>> ${response.statusCode}");

    if (response.statusCode == 200) {
      print("this is respoinse @@ ${response.statusCode}");
      // _showMyDialog();
      // final jsonResponse = ServiceRequestModel.fromJson(json.decode(finalResult));
      // print("checking json response ${jsonResponse.msg} and ${jsonResponse.responseCode}");
      // if(finalResult.responseCode == "0"){
      // }
      // else{

      var result = json.decode(str);
      final jsonResponse = RegistrationModel.fromJson(result);
      if(jsonResponse.responseCode == "1") {
        setState((){
          isLoading = false;
        });
        Fluttertoast.showToast(msg: "${jsonResponse.message}");
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => Login()
              //BottomBar()
            ));
      }else{
        setState((){
          isLoading = false;
        });
        Fluttertoast.showToast(msg: "${jsonResponse.message}");
      }
      // }

    } else {
      Fluttertoast.showToast(msg: "Error during communication : server error");
      print(response.reasonPhrase);
    }
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text(
                  'User details sent successfully',
                  style: TextStyle(fontSize: 16),
                ),
                Text(
                  'Waiting for admin approval',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                // Navigator.push(
                //     context, MaterialPageRoute(builder: (context) => Login()));
              },
            ),
          ],
        );
      },
    );
  }
  void requestPermission(BuildContext context,int i) async{
    var status = await Permission.storage.request();
    if(status.isGranted){
      getImage(ImgSource.Both, context,i);
    } else if(status.isPermanentlyDenied){
      openAppSettings();
    }
//     if (await Permission.camera.isRestricted || await Permission.storage.isRestricted) {
//       openAppSettings();
//     }
//     else{
//       Map<Permission, PermissionStatus> statuses = await [
//         Permission.camera,
//         Permission.storage,
//       ].request();
// // You can request multiple permissions at once.
//
//       if(statuses[Permission.camera]==PermissionStatus.granted&&statuses[Permission.storage]==PermissionStatus.granted){
//         getImage(ImgSource.Both, context,i);
//
//       }else{
//         if (await Permission.camera.isDenied||await Permission.storage.isDenied) {
//           openAppSettings();
//         }else{
//           setSnackbar("Oops you just denied the permission", context);
//         }
//       }
//     }

  }
  // File? _image,_finalImage,panImage,vehicleImage,adharImage,insuranceImage,bankImage;

  Future getImage(ImgSource source, BuildContext context,int i) async {
    var image = await ImagePickerGC.pickImage(
      context: context,
      source: source,
      cameraIcon: Icon(
        Icons.add,
        color: Colors.red,
      ), //cameraIcon and galleryIcon can change. If no icon provided default icon will be present
    );
    getCropImage(context, i, image);
  }
  void getCropImage(BuildContext context,int i,var image) async {
    CroppedFile? croppedFile = await ImageCropper.platform.cropImage(
        sourcePath: image.path,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio16x9
        ],
        // androidUiSettings: AndroidUiSettings(
        //     toolbarTitle: 'Cropper',
        //     toolbarColor: Colors.lightBlueAccent,
        //     toolbarWidgetColor: Colors.white,
        //     initAspectRatio: CropAspectRatioPreset.original,
        //     lockAspectRatio: false),
        // iosUiSettings: IOSUiSettings(
        //   minimumAspectRatio: 1.0,
        // )
    );
    setState(() {
      if(i==1){
        aadharImage = File(croppedFile!.path);
      }else  if(i==2){
        panImage = File(croppedFile!.path);
      }else  if(i==4){
        drivingImage = File(croppedFile!.path);
      }else if(i==3){
        rcImage = File(croppedFile!.path);
      }
      // else if(i==6){
      //   insuranceImage = File(croppedFile!.path);
      // }
      // else if(i==7){
      //   bankImage = File(croppedFile!.path);
      // }
      // else{
      //   _finalImage = File(croppedFile!.path);
      // }
    });
  }

  manageRole() {
    if (widget.role == "Restaurants / Hotels / Cafes") {
      setState(() {
        type = "1";
        appBarTitle = "Food Service";
      });
    } else if (widget.role == "Bike") {
      setState(() {
        type = "2";
        appBarTitle = "Ride Service";
      });
    } else if (widget.role == "3 wheeler") {
      setState(() {
        type = "3";
        appBarTitle = "Delivery Service";
      });
    } else if (widget.role == "4 wheeler") {
      setState(() {
        type = "4";
        appBarTitle = "Delivery Service";
      });
    } else if (widget.role == "Mehendi Artist") {
      setState(() {
        type = "5";
        appBarTitle = "Mehendi Artist";
      });
    } else if (widget.role == "Event Planner") {
      setState(() {
        type = "6";
        appBarTitle = "Event";
      });
    } else if (widget.role == "Handy Man Services") {
      setState(() {
        type = "7";
        appBarTitle = "Handy Man";
      });
    }
  }

  List<CityData> cityList = [];
  List<Categories> eventCat = [];

  List accountType = [
    'Savings',
    'Current'
  ];
  double? pickLat;
  double? pickLong;
  // _getPickLocation() async {
  //   LocationResult result = await Navigator.of(context).push(MaterialPageRoute(
  //       builder: (context) => PlacePicker(
  //         "AIzaSyCqQW9tN814NYD_MdsLIb35HRY65hHomco",
  //       )));
  //   print(
  //       "checking adderss detail ${result.country!.name.toString()} and ${result.locality.toString()} and ${result.country!.shortName.toString()} ");
  //   setState(() {
  //     addressController.text = result.formattedAddress.toString();
  //     pickLat = result.latLng!.latitude.toString();
  //     pickLong = result.latLng!.longitude.toString();
  //     // cityC.text = result.locality.toString();
  //     // stateC.text = result.administrativeAreaLevel1!.name.toString();
  //     // countryC.text = result.country!.name.toString();
  //     // lat = result.latLng!.latitude;
  //     // long = result.latLng!.longitude;
  //     // pincodeC.text = result.postalCode.toString();
  //   });
  //   print("this is picked LAT LONG $pickLat @@ $pickLong");
  // }

  _getCities() async {
    var uri = Uri.parse('${Apipath.getCitiesUrl}');
    var request = new http.MultipartRequest("GET", uri);
    Map<String, String> headers = {
      "Accept": "application/json",
    };
    // print(baseUrl.toString());

    request.headers.addAll(headers);
    // request.fields['type_id'] = "1";
    // request.fields['vendor_id'] = userID;
    var response = await request.send();
    print(response.statusCode);
    String responseData = await response.stream.transform(utf8.decoder).join();
    var userData = json.decode(responseData);

    if (mounted) {
      setState(() {
        // collectionModal = AllCateModel.fromJson(userData);
        cityList = CitiesModel.fromJson(userData).data!;
        // print(
        //     "ooooo ${collectionModal!.status} and ${collectionModal!.categories!.length} and ${userID}");
      });
    }
    print(responseData);
  }

  _getEventCategory() async {
    var uri = Uri.parse('${Apipath.getEventCatUrl}');
    var request = new http.MultipartRequest("POST", uri);
    Map<String, String> headers = {
      "Accept": "application/json",
    };
    // print(baseUrl.toString());

    request.headers.addAll(headers);
    request.fields['type_id'] = "${type.toString()}";
    var response = await request.send();
    print(response.statusCode);
    String responseData = await response.stream.transform(utf8.decoder).join();
    var userData = json.decode(responseData);

    if (mounted) {
      setState(() {
        // collectionModal = AllCateModel.fromJson(userData);
        eventCat = EventCategoryModel.fromJson(userData).data!;
        // print(
        //     "ooooo ${collectionModal!.status} and ${collectionModal!.categories!.length} and ${userID}");
      });
    }
    print(responseData);
  }
  String? token;

  getToken() async {
    token = await FirebaseMessaging.instance.getToken();
  }
  LocationPermission? permission;
  Position? currentLocation;

  Future getUserCurrentLocation() async {
    permission = await Geolocator.requestPermission();
    await Geolocator.getCurrentPosition()
        .then((position) {
      if (mounted)
        setState(() {
          currentLocation = position;
          pickLat = currentLocation!.latitude;
          pickLong = currentLocation!.longitude;
        });
    });
    print("LOCATION===" + currentLocation.toString());
  }

  @override
  void initState() {
    super.initState();
    getToken();
    manageRole();
    _getCities();
    _getEventCategory();
    getLocation();
    _getAddressFromLatLng();
     // getLocation();
    getUserCurrentLocation();
  }


  final _formKey = GlobalKey<FormState>();

  String dropdownvalue = 'Haldi Event';
  String selectedLocation = 'Jaipur';
  String deliveryTypeValue = 'Delivery Only';

  var items = [
    'Birthday Party',
    'Photography',
    'Anniversary',
    'Kitty Party',
    'Haldi Event',
    'Mahila Sangeet',
    'Meeting',
    'Events',
    'Parties'
  ];
  var deliveryType = [
    'Ride Only',
    'Delivery Only',
    'Both'
  ];

  commonFields() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 30,
        ),
        type == "5" || type == "6" || type == "7"
            ? Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Radio(
                    value: 1,
                    fillColor: MaterialStateColor.resolveWith((states) => AppColor().colorBg1()),
                    groupValue: _value1,
                    onChanged: (int? value) {
                      setState(() {
                        _value1 = value!;
                        roleUser = true;
                        // isUpi = false;
                      });
                    }),
                Text(
                  "Company",
                  style: TextStyle(color: AppColor().colorBg1()),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Radio(
                    fillColor: MaterialStateColor.resolveWith((states) => AppColor().colorBg1()),
                    value: 2,
                    groupValue: _value1,
                    onChanged: (int? value) {
                      setState(() {
                        _value1 = value!;
                        roleUser = false;
                        // isUpi = true;
                      });
                    }),

                Text(
                  "Freelancer",
                  style: TextStyle(color: AppColor().colorBg1()),
                ),
              ],
            ),
          ],
        )
            : SizedBox.shrink(),
        type == "2" ?
        Padding(
          padding: const EdgeInsets.only(left: 15.0, right: 15),
          child: Container(
              padding: EdgeInsets.only(right: 12,left: 12,),
              // height: 50,
              width: MediaQuery.of(context).size.width,
              decoration:
              BoxDecoration(
                color: AppColor().colorBg1(),
                borderRadius: BorderRadius.circular(10),
                border: Border.all( color: AppColor().colorSecondary(),),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  dropdownColor:   AppColor().colorBg1(),
                  value: deliveryTypeValue,
                  icon:  Icon(Icons.keyboard_arrow_down_rounded,  color: AppColor().colorPrimary(),),
                  elevation: 16,
                  style:  TextStyle(color: AppColor().colorPrimary(),fontWeight: FontWeight.bold),
                  underline: Container(
                    // height: 2,
                    color:  AppColor().colorBg1(),
                  ),
                  onChanged: (String? value) {
                    // This is called when the user selects an item.
                    setState(() {
                      deliveryTypeValue = value!;
                    });
                  },
                  items: deliveryType
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
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
        )
        : SizedBox.shrink(),
        Padding(
          padding: EdgeInsets.only(left: 10,top: 20, bottom: 0),
          child: Text('Name', style: TextStyle(
            color: Colors.white
          ),),
        ),

        SizedBox(
          height: 10,
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: AppColor().colorSecondary())
          ),
          // height: 50,
          child: TextFormField(
              controller: nameController,
              validator: (msg) {
                if (msg!.isEmpty) {
                  return "Please Enter name";
                }
              },
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(left: 10),
                  border: InputBorder.none
                  // OutlineInputBorder(
                  //   borderSide: BorderSide(
                  //     color: Colors.white
                  //   ),
                  //     borderRadius: BorderRadius.circular(15))
    )),
        ),
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: 10,
          ),
          child: Text('Mobile No.',
          style: TextStyle(
            color: Colors.white
          ),),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: AppColor().colorSecondary())
          ),
          // height: 50,
          child: TextFormField(
              controller: mobileController,
              maxLength: 12,
              keyboardType: TextInputType.phone,
              validator: (msg) {
                if (msg!.isEmpty && msg.length != 10) {
                  return "Please Enter Valid Mobile number";
                }
              },
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(left: 10),
                  counterText: "",
                  border: InputBorder.none
                  // OutlineInputBorder(
                  //     borderRadius: BorderRadius.circular(15))
              )),
        ),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Text('Email Id', style: TextStyle(
            color: Colors.white
          ),),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: AppColor().colorSecondary())
          ),
          // height: 50,
          child: TextFormField(
              controller: emailController,
              validator: (msg) {
                if (msg!.isEmpty) {
                  return "Please Enter Email Id";
                }
              },
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(left: 10 ),
                  border: InputBorder.none
                  // OutlineInputBorder(
                  //     borderRadius: BorderRadius.circular(15))
              )),
        ),
        const SizedBox(
          height: 10,
        ),
        type == "5" ?
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Radio(
                    value: 1,
                    fillColor: MaterialStateColor.resolveWith((states) => AppColor().colorBg1()),
                    groupValue: _value3,
                    onChanged: (int? value) {
                      setState(() {
                        _value3 = value!;
                        gender = 'male';
                        // isUpi = false;
                      });
                    }),
                Text(
                  "Male",
                  style: TextStyle(color: AppColor().colorBg1()),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Radio(
                    value: 2,
                    fillColor: MaterialStateColor.resolveWith((states) => AppColor().colorBg1()),
                    groupValue: _value3,
                    onChanged: (int? value) {
                      setState(() {
                        _value3 = value!;
                        gender = 'female';
                      });
                    }),
                Text(
                  "Female",
                  style: TextStyle(color: AppColor().colorBg1()),
                ),
              ],
            ),
          ],
        )
            : SizedBox.shrink(),
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Text('Password',
          style: TextStyle(
            color: AppColor().colorBg1()
          ),),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: AppColor().colorSecondary())
          ),
          // height: 50,
          child: TextFormField(
            obscureText: pass,
              controller: passwordController,
              validator: (msg) {
                if (msg!.isEmpty) {
                  return "Please Enter Password ";
                }
              },
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(left: 10, top: 10 ),
                  suffixIcon: IconButton(
                      onPressed: (){
                        setState((){
                          pass = !pass;
                        });
                      },
                      icon: pass ? Icon(Icons.visibility,
                        color: AppColor.PrimaryDark,)
                          : Icon(Icons.visibility_off,)),
                  border: InputBorder.none
              )),
        ),
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Text('Confirm password',
          style: TextStyle(
            color: AppColor().colorBg1()
          ),),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: AppColor().colorSecondary())
          ),
          // height: 50,
          child: TextFormField(
            obscureText: cPass,
              controller: confirmPassController,
              validator: (msg) {
                if (msg!.isEmpty) {
                  return "Please Enter Confirm Password ";
                }
              },
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(left: 10, top: 10),
                suffixIcon: IconButton(
                  onPressed: (){
                    setState((){
                      cPass = !cPass;
                    });
                  },
                    icon: cPass ? Icon(Icons.visibility,
                    color: AppColor.PrimaryDark,)
                : Icon(Icons.visibility_off,)),
                  border: InputBorder.none
              )),
        ),
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Text('Address',
          style: TextStyle(
            color: AppColor().colorBg1()
          ),),
        ),
        SizedBox(
          height: 10,
        ),
        InkWell(
          onTap: () {
            // _getPickLocation();
          },
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: AppColor().colorSecondary())
            ),
            // height: 60,
            child: TextFormField(
                maxLines: 1,
                controller: addressController,
                validator: (msg) {
                  if (msg!.isEmpty) {
                    return "Please Enter Address ";
                  }
                },
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PlacePicker(
                        apiKey: Platform.isAndroid
                            ? "AIzaSyB0uPBgryG9RisP8_0v50Meds1ZePMwsoY"
                            : "AIzaSyB0uPBgryG9RisP8_0v50Meds1ZePMwsoY",
                        onPlacePicked: (result) {
                          print(result.formattedAddress);
                          setState(() {
                            addressController.text =
                                result.formattedAddress.toString();
                            pickLat =
                                result.geometry!.location.lat;
                            pickLong =
                                result.geometry!.location.lng;
                          });
                          Navigator.of(context).pop();
                        },
                        initialPosition: LatLng(
                            //22.719568,75.857727
                          double.parse(widget.lat.toString()), double.parse(widget.long.toString())
                        ),
                        useCurrentLocation: true,
                      ),
                    ),
                  );
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => PlacePicker(
                  //       apiKey: Platform.isAndroid
                  //           ? "AIzaSyBxsWdUSLMXzjxD6X-IOKjZMp3aMoxJfKc"
                  //           : "AIzaSyBxsWdUSLMXzjxD6X-IOKjZMp3aMoxJfKc",
                  //       onPlacePicked: (result) {
                  //         print(result.formattedAddress);
                  //         setState(() {
                  //           addressController.text =
                  //               result.formattedAddress.toString();
                  //           pickLat =
                  //               result.geometry!.location.lat;
                  //           pickLong =
                  //               result.geometry!.location.lng;
                  //         });
                  //         Navigator.of(context).pop();
                  //       },
                  //       initialPosition: LatLng(22.719568,75.857727
                  //           // double.parse(widget.lat.toString()), double.parse(widget.long.toString())
                  //   ),
                  //       useCurrentLocation: true,
                  //     ),
                  //   ),
                  // );
                  // _getPickLocation();
                },
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(left: 10),
                    border: InputBorder.none
                )
              // decoration: InputDecoration(
              //   border: OutlineInputBorder(),
              // ),
            ),
          ),
        ),
        SizedBox(height: 10),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Radio(
                    value: 1,
                    fillColor: MaterialStateColor.resolveWith((states) => AppColor().colorBg1()),
                    groupValue: _value,
                    onChanged: (int? value) {
                      setState(() {
                        _value = value!;
                        isUpi = false;
                      });
                    }),
                Text(
                  "Bank Upi",
                  style: TextStyle(color: AppColor().colorBg1()),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Radio(
                    value: 2,
                    fillColor: MaterialStateColor.resolveWith((states) => AppColor().colorBg1()),
                    groupValue: _value,
                    onChanged: (int? value) {
                      setState(() {
                        _value = value!;
                        isUpi = true;
                      });
                    }),
                Text(
                  "Bank Account",
                  style: TextStyle(color: AppColor().colorBg1()),
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
              child: Text('UPI Id', style: TextStyle(
                color: AppColor().colorBg1()
              ),),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: AppColor().colorSecondary())
              ),
              // height: 50,
              child: TextFormField(
                  controller: upiController,
                  validator: (msg) {
                    if (msg!.isEmpty) {
                      return "Please Enter UPI Id ";
                    }
                  },
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(left: 10),
                      border: InputBorder.none
                  )
                // decoration: InputDecoration(
                //   border: OutlineInputBorder(),
                // ),
              ),
            ),
          ],
        )
            : SizedBox.shrink(),
        isUpi == true
            ? Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text('Account Holder Name',style: TextStyle(
                  color: AppColor().colorBg1()
              ),),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: AppColor().colorSecondary())
              ),
              // height: 50,
              child: TextFormField(
                  controller: accountHolderController,
                  // validator: (msg) {
                  //   if (msg!.isEmpty) {
                  //     return "Please Enter Account Holder Name ";
                  //   }
                  // },
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(left: 10 ),
                      border: InputBorder.none
                      // OutlineInputBorder(
                      //     borderRadius: BorderRadius.circular(15))
                  )
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
              child: Text('Account Number',
                style: TextStyle(
                    color: AppColor().colorBg1()
                ),),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: AppColor().colorSecondary())
              ),
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
                      contentPadding: EdgeInsets.only(left: 10 ),
                    counterText: "",
                      border: InputBorder.none
                  )
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
              child: Text('Confirm Account Number',style: TextStyle(
                  color: AppColor().colorBg1()
              ),),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: AppColor().colorSecondary())
              ),
              // height: 50,
              child: TextFormField(
                  controller: confmAccountNumController,
                  keyboardType: TextInputType.number,
                  // validator: (msg) {
                  // if(msg != confmAccountNumController.text){
                  //   return "Account number and confirm account number must be same";
                  // }
                  // },
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(left: 10 ),
                      counterText: "",
                      border: InputBorder.none
                  )
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
              child: Text('Bank Name',style: TextStyle(
                  color: AppColor().colorBg1()
              ),),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: AppColor().colorSecondary())
              ),
              // height: 50,
              child: TextFormField(
                  controller: bankNameController,
                  // validator: (msg) {
                  //   if (msg!.isEmpty) {
                  //     return "Please Enter Bank Name ";
                  //   }
                  // },
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(left: 10),
                      border: InputBorder.none
                  )
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
              child: Text('IFSC Code',style: TextStyle(
                  color: AppColor().colorBg1()
              ),),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              // height: 50,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: AppColor().colorSecondary())
              ),
              child: TextFormField(
                  controller: ifscController,
                  // validator: (msg) {
                  //   if (msg!.isEmpty) {
                  //     return "Please Enter IFSC Code";
                  //   }
                  // },
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(left: 10 ),
                      border: InputBorder.none
                  )
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
              child: Text('Account Type',style: TextStyle(
                  color: AppColor().colorBg1()
              ),),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5.0, bottom: 10),
              child: Container(
                height: 60,
                padding: EdgeInsets.only(left: 10),
                decoration: BoxDecoration(
                  color: AppColor().colorBg1(),
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                        color: AppColor().colorSecondary())),
                child: DropdownButton(
                  // Initial Value
                  value: accTypeValue,
                  underline: Container(),
                  isExpanded: true,
                  // Down Arrow Icon
                  icon: Icon(Icons.keyboard_arrow_down, color: AppColor().colorPrimary(),),
                  hint: Text("Select Account Type", style: TextStyle(
                    color: AppColor().colorPrimary()
                  ),),
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
          ],
        )
            : SizedBox.shrink(),
        SizedBox(
          height: 10,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor().colorPrimary(),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColor.PrimaryDark,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
        title: Text("${appBarTitle.toString()}"),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Container(
            padding: EdgeInsets.only(top: 5),
            width: MediaQuery.of(context).size.width,
            decoration:  BoxDecoration(
                color: AppColor().colorSecondary(),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(45),
                  topRight: Radius.circular(45),
                )),
            child: Container(
              // height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration:  BoxDecoration(
                  color: AppColor().colorPrimary(),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(45),
                    topRight: Radius.circular(45),
                  )),
              child: Padding(
                padding: const EdgeInsets.only(left: 30.0, right: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    commonFields(),
                    type == "2" || type == "3" || type == "4"
                        ? SizedBox.shrink()
                        : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text('GST No.',
                          style: TextStyle(
                            color: AppColor().colorBg1()
                          ),),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(color: AppColor().colorSecondary())
                          ),
                          // height: 50,
                          child: TextFormField(
                              controller: gstController,
                              // validator: (msg) {
                              //   if (msg!.isEmpty) {
                              //     return "Please Enter GST";
                              //   }
                              // },
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(left: 10),
                                  border: InputBorder.none)
                            // decoration: InputDecoration(
                            //   border: OutlineInputBorder(),
                            // ),
                          ),
                        ),
                        SizedBox(height: 10),
                      ],
                    ),
                    type == '1'?
                    Padding(
                      padding: const EdgeInsets.only(top: 15.0, bottom: 15),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Radio(
                                  fillColor: MaterialStateColor.resolveWith((states) => AppColor().colorBg1()),
                                  value: 1,
                                  groupValue: _value2,
                                  onChanged: (int? value) {
                                    setState(() {
                                      _value2 = value!;
                                      restroType = "Veg";
                                      // roleUser = true;
                                      // isUpi = false;
                                    });
                                  }),
                              Text("Veg", style: TextStyle(
                                color: AppColor().colorBg1()
                              ),),
                              // Container(
                              //   padding: EdgeInsets.all(10),
                              //   // height: 40,
                              //   decoration: BoxDecoration(
                              //       color: AppColor().colorBg1(),
                              //       borderRadius: BorderRadius.circular(10),
                              //       border: Border.all(
                              //           color: AppColor().colorPrimary())),
                              //   child: Row(
                              //     children: [
                              //       Image.asset(
                              //         'images/veg.png',
                              //         height: 20,
                              //         width: 20,
                              //       ),
                              //       SizedBox(
                              //         width: 5,
                              //       ),
                              //       Text("Veg")
                              //     ],
                              //   ),
                              // )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Radio(
                                  value: 2,
                                  fillColor: MaterialStateColor.resolveWith((states) => AppColor().colorBg1()),
                                  groupValue: _value2,
                                  onChanged: (int? value) {
                                    setState(() {
                                      _value2 = value!;
                                      restroType = "Non-Veg";
                                      // roleUser = false;
                                      // isUpi = true;
                                    });
                                  }),
                              Text("Non-Veg",
                                   style: TextStyle(
                                  color: AppColor().colorBg1()
                    ),)
                              // Container(
                              //   padding: EdgeInsets.all(10),
                              //   // height: 40,
                              //   decoration: BoxDecoration(
                              //       color: AppColor().colorBg1(),
                              //       borderRadius: BorderRadius.circular(10),
                              //       border: Border.all(
                              //           color: AppColor().colorPrimary())),
                              //   child: Row(
                              //     children: [
                              //       Image.asset(
                              //         'images/nonveg.png',
                              //         height: 20,
                              //         width: 20,
                              //       ),
                              //       SizedBox(
                              //         width: 5,
                              //       ),
                              //       Text("Non-Veg")
                              //     ],
                              //   ),
                              // )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Radio(
                                  fillColor: MaterialStateColor.resolveWith((states) => AppColor().colorBg1()),
                                  value: 3,
                                  groupValue: _value2,
                                  onChanged: (int? value) {
                                    setState(() {
                                      _value2 = value!;
                                      restroType = "both";
                                      // roleUser = true;
                                      // isUpi = false;
                                    });
                                  }),
                              Text("Both",style: TextStyle(
                                  color: AppColor().colorBg1() ),)

                              // Container(
                              //   padding: EdgeInsets.all(10),
                              //   // height: 40,
                              //   decoration: BoxDecoration(
                              //       color: AppColor().colorBg1(),
                              //       borderRadius: BorderRadius.circular(10),
                              //       border: Border.all(
                              //           color: AppColor().colorPrimary())),
                              //   child: Row(
                              //     children: [
                              //       // Image.asset(
                              //       //   'images/veg.png',
                              //       //   height: 20,
                              //       //   width: 20,
                              //       // ),
                              //       SizedBox(
                              //         width: 5,
                              //       ),
                              //       Text("Both")
                              //     ],
                              //   ),
                              // )
                            ],
                          ),
                        ],
                      ),
                    )
                    : SizedBox.shrink(),
                    roleUser ?
                    type == "1" || type == "2" || type == "3" || type == "4"
                        ? SizedBox.shrink()
                        : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Text('Company Name',
                          style: TextStyle(
                            color: AppColor().colorBg1()
                          ),),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(color: AppColor().colorSecondary())
                          ),
                          // height: 50,
                          child: TextFormField(
                              controller: companyController,
                              validator: (msg) {
                                if (msg!.isEmpty) {
                                  return "Please Enter Company Name ";
                                }
                              },
                              decoration: InputDecoration(
                                  border: InputBorder.none)
                            // decoration: InputDecoration(
                            //   border: OutlineInputBorder(),
                            // ),
                          ),
                        ),
                      ],
                    )
                    :SizedBox.shrink(),
                    SizedBox(height: 10),
                    type == "2" || type == "3" || type == "4"
                        ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text('Vehicle No.',
                          style: TextStyle(
                            color: AppColor().colorBg1()
                          ),),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(color: AppColor().colorSecondary())
                          ),
                          height: 50,
                          child: TextFormField(
                              controller: vehicleController,
                              validator: (msg) {
                                if (msg!.isEmpty) {
                                  return "Please Enter Vehicle No.";
                                }
                              },
                              decoration: InputDecoration(
                                  border: InputBorder.none
                                  // OutlineInputBorder(
                                  //     borderRadius:
                                  //     BorderRadius.circular(15))
                              )
                            // decoration: InputDecoration(
                            //   border: OutlineInputBorder(),
                            // ),
                          ),
                        ),
                        const SizedBox(height: 10),
                      ],
                    )
                        : SizedBox.shrink(),

                    Padding(
                      padding: const EdgeInsets.only(top: 0.0, bottom: 20),
                      child: Column(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                               Padding(
                                padding: EdgeInsets.only(
                                    left: 5.0, top: 5, bottom: 10),
                                child: Text(
                                  "Aadhaar Card",
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: AppColor().colorBg1()
                                  ),
                                ),
                              ),
                              imageAadhar(),
                            ],
                          ),

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                               Padding(
                                padding:
                                EdgeInsets.only(left: 5, top: 10, bottom: 10),
                                child: Text(
                                  "Pan Card",
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: AppColor().colorBg1()
                                  ),
                                ),
                              ),
                              imagePan(),
                            ],
                          ),
                          type == "2" || type == "3" || type == "4"
                              ? Column(
                            children: [
                              Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                   Padding(
                                    padding: EdgeInsets.only(
                                        left: 5.0, top: 10, bottom: 10),
                                    child: Text(
                                      "Registration Card",
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: AppColor().colorBg1()
                                      ),
                                    ),
                                  ),
                                  imageRC(),
                                ],
                              ),
                              Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                   Padding(
                                    padding: EdgeInsets.only(
                                        left: 5.0, top: 10, bottom: 10),
                                    child: Text(
                                      "Driving License",
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: AppColor().colorBg1()
                                      ),
                                    ),
                                  ),
                                  imagedriving(),
                                ],
                              ),
                            ],
                          )
                              : SizedBox.shrink()
                        ],
                      ),
                    ),
                    type == "1"
                        ? SizedBox.shrink()
                        : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text("Location",
                          style: TextStyle(
                            color: AppColor().colorBg1()
                          ),),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Padding(
                          padding:
                          const EdgeInsets.only(top: 5.0, bottom: 10),
                          child: Container(
                            height: 60,
                            padding: EdgeInsets.only(left: 10),
                            decoration: BoxDecoration(
                              color: AppColor().colorBg1(),
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(
                                    color: AppColor().colorSecondary())),
                            child: DropdownButton(
                              // Initial Value
                              value: categoryValue,
                              underline: Container(),
                              isExpanded: true,
                              // Down Arrow Icon
                              icon: Icon(Icons.keyboard_arrow_down, color: AppColor().colorPrimary(),),
                              hint: Text("Select City", style: TextStyle(
                                color: AppColor.PrimaryDark
                              ),),
                              // Array list of items
                              items: cityList.map((items) {
                                return DropdownMenuItem(
                                  value: items.id,
                                  child: Container(
                                      child: Text(items.name.toString())),
                                );
                              }).toList(),
                              // After selecting the desired option,it will
                              // change button value to selected value
                              onChanged: (String? newValue) {
                                setState(() {
                                  categoryValue = newValue!;

                                  print(
                                      "selected category ${categoryValue}");
                                });
                              },
                            ),
                          ),
                        ),

                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                    type == "5" || type == "6" || type == "7" ?
                    Padding(
                      padding: const EdgeInsets.only(left: 10, bottom: 10),
                      child: Text("Category",
                      style: TextStyle(
                        color: AppColor().colorBg1()
                      ),),
                    )
                    : SizedBox.shrink(),
                    type == "5" || type == "6" || type == "7"
                    ? InkWell(
                      onTap: (){
                        _showMultiSelect();
                      },
                      child: Container(
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.only(left: 10),
                          decoration: BoxDecoration(
                            color: AppColor().colorBg1(),
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(
                                  color: Colors.black.withOpacity(0.7))),
                          child: _selectedItems.isEmpty ?
                          Padding(
                            padding: const EdgeInsets.only(left: 10, top: 20, bottom: 20),
                            child: Text(
                              'Select Categories',
                              style: TextStyle(
                                fontSize: 16,
                                color: colors.primary,
                                fontWeight: FontWeight.normal,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          )
                              :
                          Wrap(
                            children: _selectedItems
                                .map((item){
                              return Padding(
                                padding: const EdgeInsets.only(left: 8.0, right: 8),
                                child: Chip(
                                  backgroundColor: AppColor().colorPrimary(),
                                  label:
                                  Text(
                                      "${item.cName}",
                                    style: TextStyle(
                                      color: AppColor().colorBg1()
                                    ),
                                    //item.name
                                  ),
                                ),
                              );
                            })
                                .toList(),
                          )
                        // FutureBuilder(
                        //     future: getCities(),
                        //     builder: (BuildContext context,
                        //         AsyncSnapshot snapshot) {
                        //       if (snapshot.hasData) {
                        //         return DropdownButtonHideUnderline(
                        //           child: DropdownButton2(
                        //             isExpanded: true,
                        //             hint: Row(
                        //               children: [
                        //                 Image.asset(
                        //                   city,
                        //                   width: 6.04.w,
                        //                   height: 5.04.w,
                        //                   fit: BoxFit.fill,
                        //                   color: AppColor.PrimaryDark,
                        //                 ),
                        //                 SizedBox(
                        //                   width: 4,
                        //                 ),
                        //                 Expanded(
                        //                   child: Text(
                        //                     'Select Multiple Cities',
                        //                     style: TextStyle(
                        //                       fontSize: 14,
                        //                       fontWeight: FontWeight.normal,
                        //                     ),
                        //                     overflow: TextOverflow.ellipsis,
                        //                   ),
                        //                 ),
                        //               ],
                        //             ),
                        //             items: cityList.map((item) {
                        //               return DropdownMenuItem<String>(
                        //                 value: item.id,
                        //                 enabled: false,
                        //                 child: StatefulBuilder(
                        //                   builder: (context, menuSetState) {
                        //                     final _isSelected =
                        //                         selectedCities
                        //                             .contains(item);
                        //                     print("SLECTED CITY");
                        //                     return InkWell(
                        //                       onTap: () {
                        //                         _isSelected
                        //                             ? selectedCities
                        //                                 .remove(item.id)
                        //                             : selectedCities
                        //                                 .add(item.id!);
                        //                         setState(() {});
                        //                         menuSetState(() {});
                        //                       },
                        //                       child: Container(
                        //                         height: double.infinity,
                        //                         padding: const EdgeInsets
                        //                                 .symmetric(
                        //                             horizontal: 16.0),
                        //                         child: Row(
                        //                           children: [
                        //                             _isSelected
                        //                                 ? const Icon(Icons
                        //                                     .check_box_outlined)
                        //                                 : const Icon(Icons
                        //                                     .check_box_outline_blank),
                        //                             const SizedBox(
                        //                                 width: 16),
                        //                             Text(
                        //                               item.name!,
                        //                               style:
                        //                                   const TextStyle(
                        //                                 fontSize: 14,
                        //                               ),
                        //                             ),
                        //                           ],
                        //                         ),
                        //                       ),
                        //                     );
                        //                   },
                        //                 ),
                        //               );
                        //             }).toList(),
                        //             //Use last selected item as the current value so if we've limited menu height, it scroll to last item.
                        //             value: selectedCities.isEmpty
                        //                 ? null
                        //                 : selectedCities.last,
                        //             onChanged: (value) {},
                        //             buttonHeight: 50,
                        //             buttonWidth: 160,
                        //             buttonPadding: const EdgeInsets.only(
                        //                 left: 14, right: 14),
                        //             buttonDecoration: BoxDecoration(
                        //               borderRadius:
                        //                   BorderRadius.circular(14),
                        //               color: Color(0xffF9F9F9),
                        //             ),
                        //             buttonElevation: 0,
                        //             itemHeight: 40,
                        //             itemPadding: const EdgeInsets.only(
                        //                 left: 14, right: 14),
                        //             dropdownMaxHeight: 300,
                        //             dropdownPadding: null,
                        //             dropdownDecoration: BoxDecoration(
                        //               borderRadius:
                        //                   BorderRadius.circular(14),
                        //             ),
                        //             dropdownElevation: 8,
                        //             scrollbarRadius:
                        //                 const Radius.circular(40),
                        //             scrollbarThickness: 6,
                        //             scrollbarAlwaysShow: true,
                        //             selectedItemBuilder: (context) {
                        //               return cityList.map(
                        //                 (item) {
                        //                   return Container(
                        //                     // alignment: AlignmentDirectional.center,
                        //                     padding:
                        //                         const EdgeInsets.symmetric(
                        //                             horizontal: 16.0),
                        //                     child: Text(
                        //                       selectedCities.join(','),
                        //                       style: const TextStyle(
                        //                         fontSize: 14,
                        //                         overflow:
                        //                             TextOverflow.ellipsis,
                        //                       ),
                        //                       maxLines: 1,
                        //                     ),
                        //                   );
                        //                 },
                        //               ).toList();
                        //             },
                        //           ),
                        //         );
                        //       } else if (snapshot.hasError) {
                        //         return Icon(Icons.error_outline);
                        //       } else {
                        //         return Center(
                        //             child: CircularProgressIndicator());
                        //       }
                        //     })
                      ),
                    )
                    : SizedBox.shrink(),
                    type == "1"
                        ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text(
                            "Store Details",
                            style: TextStyle(
                              color: AppColor().colorBg1(),
                                fontWeight: FontWeight.w600, fontSize: 18),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text("Store Name",
                          style: TextStyle(
                            color: AppColor().colorBg1()
                          ),),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(color: AppColor().colorSecondary())
                          ),
                          // height: 50,
                          child: TextFormField(
                              controller: storeNameController,
                              validator: (msg) {
                                if (msg!.isEmpty) {
                                  return "Please Enter Store Name";
                                }
                              },
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(left: 10),
                                  border: InputBorder.none)
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
                          child: Text("Store Description", style: TextStyle(
                            color: AppColor().colorBg1()
                          ),),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(color: AppColor().colorSecondary())
                          ),
                          // height: 50,
                          child: TextFormField(
                              controller: storeDescriptionController,
                              validator: (msg) {
                                if (msg!.isEmpty) {
                                  return "Please Enter Store Description";
                                }
                              },
                              decoration: InputDecoration(
                                  border: InputBorder.none
                              )
                            // decoration: InputDecoration(
                            //   border: OutlineInputBorder(),
                            // ),
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text("FSSAI",
                          style: TextStyle(
                            color: AppColor().colorBg1()
                          ),),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(color: AppColor().colorSecondary())
                          ),
                          // height: 50,
                          child: TextFormField(
                              controller: fssaiController,
                              validator: (msg) {
                                if (msg!.isEmpty) {
                                  return "Please Enter FSSAI No. ";
                                }
                              },
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(left: 10),
                                  border: InputBorder.none)
                            // decoration: InputDecoration(
                            //   border: OutlineInputBorder(),
                            // ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    )
                        : SizedBox.shrink(),
                    Padding(
                      padding: const EdgeInsets.only(top:10,left: 10),
                      child: Text("Referral Code (Optional)",style: TextStyle(
                        color: AppColor().colorBg1()
                      ),),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Container(
                      height: 50,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: AppColor().colorSecondary())
                      ),
                      child: TextFormField(
                          controller: referallController,
                          // validator: (msg) {
                          //   if (msg!.isEmpty) {
                          //     return "Please Enter FSSAI No. ";
                          //   }
                          // },
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(left: 10),
                              border: InputBorder.none)
                        // decoration: InputDecoration(
                        //   border: OutlineInputBorder(),
                        // ),
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                    //     Container(
                    //       width: 50,
                    //       child: RadioListTile(
                    //         title: Text("Bank UPI"),
                    //         value: "bank upi",
                    //         groupValue: bankValue,
                    //         onChanged: (value){
                    //           setState(() {
                    //             bankValue = value.toString();
                    //           });
                    //         },
                    //       ),
                    //     ),
                    //     Container(
                    //       width: 50,
                    //       child: RadioListTile(
                    //         title: Text("Bank Account"),
                    //         value: "bank account",
                    //         groupValue: bankValue,
                    //         onChanged: (value){
                    //           setState(() {
                    //             bankValue = value.toString();
                    //           });
                    //         },
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    SizedBox(
                      height: 15,
                    ),
                    InkWell(
                      onTap: (){
                        setState((){
                          isLoading = true;
                        });

                        if(passwordController.text == confirmPassController.text){

                        // if(type =="1"){
                          // if (gstController.text.isNotEmpty &&
                          //     fssaiController.text.isNotEmpty &&
                          //     storeDescriptionController.text.isNotEmpty
                          //  && storeNameController.text.isNotEmpty) {
                          if (isUpi == false) {
                              if (_formKey.currentState!.validate()) {
                                submitRequest();
                              } else {
                                setState((){
                                  isLoading = false;
                                });
                                Fluttertoast.showToast(
                                    msg: "All fields are required!!");
                              }
                            }
                            else {
                              if (accountNoController.text.isNotEmpty &&
                                  accountHolderController.text.isNotEmpty &&
                                  bankNameController.text.isNotEmpty &&
                                  ifscController.text.isNotEmpty) {
                                if(accountNoController.text == confmAccountNumController.text){
                                  submitRequest();
                                }else{
                                  setState((){
                                    isLoading = false;
                                  });
                                  Fluttertoast.showToast(msg: "Account number and Confirm Account Number must be same!");
                                }

                              }
                              else {
                                setState((){
                                  isLoading = false;
                                });
                                Fluttertoast.showToast(
                                    msg: "All fields are required!!");
                              }
                            }
                            }else{
                          Fluttertoast.showToast(msg: "Password and confirm password fields must be same!");
                        }
                          // } else {
                          //   setState((){
                          //     isLoading = false;
                          //   });
                          //   Fluttertoast.showToast(
                          //       msg: "Store Details, GST No. & FSSAI No. required!");
                          // }
                        // }
                        //   else{
                        //     if (isUpi == false) {
                        //       if (_formKey.currentState!.validate()) {
                        //         submitRequest();
                        //       } else {
                        //         setState((){
                        //           isLoading = false;
                        //         });
                        //         Fluttertoast.showToast(
                        //             msg: "All fields are required!!");
                        //       }
                        //     }
                        //     else {
                        //       if (accountNoController.text.isNotEmpty &&
                        //           accountHolderController.text.isNotEmpty &&
                        //           bankNameController.text.isNotEmpty &&
                        //           ifscController.text.isNotEmpty) {
                        //         submitRequest();
                        //       }
                        //       else {
                        //         setState((){
                        //           isLoading = false;
                        //         });
                        //         Fluttertoast.showToast(
                        //             msg: "All fields are required!!");
                        //       }
                        //     }
                        //   }
                      },
                      child: Container(
                          height: 43,
                          width:  MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: AppColor().colorSecondary()),
                          child: isLoading ?
                              loadingWidget() :
                          Center(child: Text("Submit", style: TextStyle(fontSize: 18, color: AppColor.PrimaryDark)))
                      ),
                    ),
                    // AppBtn(
                    //   onPress: (){
                    //     if(isUpi == false) {
                    //       if (_formKey.currentState!.validate()) {
                    //         submitRequest();
                    //       } else {
                    //         Fluttertoast.showToast(
                    //             msg: "All fields are required!!");
                    //       }
                    //     }else{
                    //       if(accountNoController.text.isNotEmpty && accountHolderController.text.isNotEmpty &&
                    //           bankNameController.text.isNotEmpty && ifscController.text.isNotEmpty){
                    //         submitRequest();
                    //       }
                    //       else {
                    //         Fluttertoast.showToast(
                    //             msg: "All fields are required!!");
                    //       }
                    //     }
                    //   },
                    //   label: "Submit",
                    // ),
                    // InkWell(
                    //   onTap: () {
                    //     if(isUpi == false) {
                    //       if (_formKey.currentState!.validate()) {
                    //         submitRequest();
                    //       } else {
                    //         Fluttertoast.showToast(
                    //             msg: "All fields are required!!");
                    //       }
                    //     }else{
                    //       if(accountNoController.text.isNotEmpty && accountHolderController.text.isNotEmpty &&
                    //           bankNameController.text.isNotEmpty && ifscController.text.isNotEmpty){
                    //         submitRequest();
                    //       }
                    //       else {
                    //         Fluttertoast.showToast(
                    //             msg: "All fields are required!!");
                    //       }
                    //     }
                    //
                    //     // Navigator.push(context, MaterialPageRoute(builder: (context)=> BottomBar(
                    //     //   type: type,
                    //     // )));
                    //   },
                    //   child: Align(
                    //     alignment: Alignment.center,
                    //     child: Container(
                    //       height: 44,
                    //       width: 300,
                    //       decoration: BoxDecoration(
                    //         borderRadius: BorderRadius.circular(30.0),
                    //         color: AppColor().colorPrimary(),
                    //       ),
                    //       child: Center(
                    //         child: Text(
                    //           "Submit",
                    //           style: TextStyle(
                    //               color: Colors.white,
                    //               fontWeight: FontWeight.bold,
                    //               fontSize: 18),
                    //         ),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    SizedBox(
                      height: 15,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}


class MultiSelect extends StatefulWidget {
  String type;
  MultiSelect({Key? key, required this.type}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MultiSelectState();

}


class _MultiSelectState extends State<MultiSelect> {
  List _selectedItems = [];
  // this variable holds the selected items

  // List<CityData> cityList = [];
  List<Categories> eventCat = [];

// This function is triggered when a checkbox is checked or unchecked
  void _itemChange(Categories itemValue, bool isSelected) {
    setState(() {
      if (isSelected) {
        _selectedItems.add(itemValue);
      } else {
        _selectedItems.remove(itemValue);
      }
    });
    print("this is selected values ${_selectedItems.toString()}");
  }
  // void _itemChange(itemValue, bool isSelected) {
  //   setState(() {
  //     if (isSelected) {
  //       _selectedItems.add(itemValue);
  //     }
  //     else {
  //       _selectedItems.remove(itemValue);
  //     }
  //   });
  // }

  // this function is called when the Cancel button is pressed
  void _cancel() {
    Navigator.pop(context);
  }

// this function is called when the Submit button is tapped
  void _submit() {
    List selectedItem = _selectedItems.map((item) => item.id).toList();
    // var map = {
    //   "itemIds" : selectedItem,
    //   "selectedItems" : _selectedItems
    // };
    // print("checking selected value ${_selectedItems} && ${selectedItem} && ${map}");
    Navigator.pop(context);
  }
  _getEventCategory() async {
    var uri = Uri.parse('${Apipath.getEventCatUrl}');
    var request = new http.MultipartRequest("POST", uri);
    Map<String, String> headers = {
      "Accept": "application/json",
    };
    // print(baseUrl.toString());

    request.headers.addAll(headers);
    request.fields['type_id'] = "${widget.type.toString()}";
    var response = await request.send();
    print(response.statusCode);
    String responseData = await response.stream.transform(utf8.decoder).join();
    var userData = json.decode(responseData);

    if (mounted) {
      setState(() {
        // collectionModal = AllCateModel.fromJson(userData);
        eventCat = EventCategoryModel.fromJson(userData).data!;
        // print(
        //     "ooooo ${collectionModal!.status} and ${collectionModal!.categories!.length} and ${userID}");
      });
    }
    print(responseData);
  }
  bool isChecked = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getEventCategory();
  }

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
        builder: (context, setState)
    {
      return
        AlertDialog(
          title: const Text('Select Multiple Categories'),
          content: SingleChildScrollView(
            child: ListBody(
              children: eventCat
                  .map((item) =>
              // InkWell(
              //   onTap: (){
              //     setState(() {
              //       if (isChecked) {
              //         setState(() {
              //           _selectedItems.add(item);
              //         });
              //         print("length of item list ${_selectedItems.length}");
              //         for (var i = 0; i < _selectedItems.length; i++) {
              //           print("ok now final  ${_selectedItems[i]
              //               .id} and  ${_selectedItems[i].cName}");
              //         }
              //       }
              //       else {
              //         setState(() {
              //           _selectedItems.remove(item);
              //         });
              //         print("ok now data ${_selectedItems}");
              //       }
              //     });
              //
              //   },
              //   child: Row(
              //     children: [
              //       Container(
              //         height: 40,
              //         width: 40,
              //         decoration: BoxDecoration(
              //           color: AppColor().colorBg1(),
              //           border: Border.all(
              //             color: isChecked ? AppColor().colorPrimary() : AppColor().colorTextSecondary()
              //           ),
              //           borderRadius: BorderRadius.circular(5)
              //         ),
              //         child: Icon(
              //           Icons.check,
              //         ),
              //       ),
              //       Text(item.cName!)
              //     ],
              //   ),
              // )
                  CheckboxListTile(
                    activeColor: AppColor().colorPrimary(),
                    value: _selectedItems.contains(item),
                    title: Text(item.cName!),
                    controlAffinity: ListTileControlAffinity.leading,
                    onChanged: (isChecked) => _itemChange(item, isChecked!),
                    // onChanged: (isChecked) {
                    //   setState(() {
                    //     if (!isChecked! && _selectedItems.contains(item.id)) {
                    //       setState(() {
                    //         _selectedItems.remove(item);
                    //       });
                    //       print("ok now data ${_selectedItems}");
                    //     }
                    //     else {
                    //       setState(() {
                    //         _selectedItems.add(item);
                    //       });
                    //       print("length of item list ${_selectedItems.length}");
                    //       for (var i = 0; i < _selectedItems.length; i++) {
                    //         print("ok now final  ${_selectedItems[i]
                    //             .id} and  ${_selectedItems[i].cName}");
                    //       }
                    //     }
                    //   });
                    // },
                  )
              ).toList(),
            ),
          ),
          // FutureBuilder(
          //   future: getCities(),
          //   builder: (context, snapshot){
          //     if(snapshot.hasData) {
          //      return SingleChildScrollView(
          //         child: ListBody(
          //           children: cityList
          //               .map((item) =>
          //               CheckboxListTile(
          //                 value: _selectedItems.contains(item),
          //                 title: Text(item.name!),
          //                 controlAffinity: ListTileControlAffinity.leading,
          //                 onChanged: (isChecked) => _itemChange(item, isChecked!),
          //               ))
          //               .toList(),
          //         ),
          //       );
          //     }
          //     return Container(
          //       height: 30,
          //         width: 30,
          //         child: CircularProgressIndicator(
          //           color: AppColor().colorPrimary(),
          //         ));
          //   }
          // ),
          actions: [
            TextButton(
              child: Text('Cancel',
                style: TextStyle(color: AppColor().colorPrimary()),),
              onPressed: _cancel,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  primary: AppColor().colorPrimary()
              ),
              child: Text('Submit'),
              onPressed: () {
                // _submit();
                Navigator.pop(context, _selectedItems);
              }
              //     (){
              //   for(var i = 0 ; i< _selectedItems.length; i++){
              //     print(_selectedItems[i].id);
              //   }
              // }
              ,
            ),
          ],
        );
    }
    );
  }
}

