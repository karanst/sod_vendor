import 'dart:convert';
import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:fixerking/RideFlow/utils/Session.dart';
import 'package:fixerking/token/token_string.dart';
import 'package:fixerking/utility_widget/customLoader.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:image_picker_gallery_camera/image_picker_gallery_camera.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../utils/colors.dart';
import '../../../utils/widget.dart';
import '../../api/api_path.dart';
import 'package:http/http.dart'as http;

import '../../new model/categories_model.dart';
import '../../new model/vendor_services_model.dart';

class EditServices extends StatefulWidget {

  final Products? productsModel;
  EditServices({this.productsModel});


  @override
  State<EditServices> createState() => _EditServicesState();
}

class _EditServicesState extends State<EditServices> {


  TextEditingController artistNameController  = TextEditingController();
  TextEditingController palmCostController = TextEditingController();
  TextEditingController elbowCostController = TextEditingController();
  TextEditingController legsController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController sellingPriceController = TextEditingController();
  TextEditingController perDayController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  PickedFile? image1;
  PickedFile? image2;
  PickedFile? image3;
 File? productImage;
  String? categoryValue;
  String? subCategoryValue;
  List<Category> catlist = [];

  bool isLoading = false;

  final ImagePicker picker = ImagePicker();

  //we can upload image from camera or from gallery based on parameter
  // Future getImage(ImageSource media) async {
  //   var img = await picker.getImage(source: media);
  //
  //   setState(() {
  //     image1 = img;
  //
  //   });
  // }
  Future getImageFromCamera(ImageSource media)async{
    var img = await picker.getImage(source: media);
    setState(() {
      image1 = img;
    });
  }

  Future getImage1(ImageSource media) async {
    var img =  await picker.getImage(source: media);

    setState(() {
      image2 = img;

    });
  }
  Future getImageFromCamera1(ImageSource media)async{
    var img =  await picker.getImage(source: media);
    setState(() {
      image2 = img;
    });
  }

  Future getImage2(ImageSource media) async {
    var img =  await picker.getImage(source: media);

    setState(() {
      image3 = img;

    });
  }
  Future getImageFromCamera2(ImageSource media)async{
    var img =  await picker.getImage(source: media);
    setState(() {
      image3 = img;
    });
  }
  String? type;
  String? uid;
  void checkingLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      uid = prefs.getString(TokenString.userid);
      type = prefs.getString(TokenString.type);
    });
    _getCollection();
  }

  editProducts()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? uid = prefs.getString(TokenString.userid);
    var headers = {
      'Cookie': 'ci_session=bcf2871e64e7fec397eaa77e3b6fa2b916b3eade'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${Apipath.editServicesUrl}'));
    request.fields.addAll({
      'name': '${artistNameController.text}',
      'product_price': '${priceController.text}',
      'product_description': '${descriptionController.text}',
      'cat_id': '${categoryValue.toString()}',
      //'${categoryValue.toString()}',
      'sub_cat_id': '${subCategoryValue.toString()}',
      'selling_price': '${sellingPriceController.text}',
      'vid': '${uid}'
    });
    if(type == "7"){
      request.fields.addAll({
        'per_day_charge' : '${perDayController.text}',
      });
    }
    print("checking request of api here ${request.fields}");
    image1 == null ? null :  request.files.add(await http.MultipartFile.fromPath('other_image', '${image1!.path.toString()}'));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var finalResponse = await response.stream.bytesToString();
      final jsonResponse = json.decode(finalResponse);
      print("checking result ${jsonResponse}");
      if(jsonResponse['status'] == "success") {
        setState(() {
          Fluttertoast.showToast(msg: "Added successfully");
        });
        Navigator.of(context).pop();
      }
    }
    else {
      print(response.reasonPhrase);
    }
  }
  // void myAlert() {
  //   showDialog(
  //       context: context,
  //       builder: (BuildContext context) {
  //         return AlertDialog(
  //           shape:
  //           RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
  //           title: Text('Please choose media to select'),
  //           content: Container(
  //             height: MediaQuery.of(context).size.height / 6,
  //             child: Column(
  //               children: [
  //                 InkWell(
  //                   //if user click this button, user can upload image from gallery
  //                   onTap: () {
  //                     Navigator.pop(context);
  //                     getImage(ImageSource.gallery);
  //                   },
  //                   child: Container(
  //                     height: 40,
  //                     decoration: BoxDecoration(
  //                       borderRadius: BorderRadius.circular(5),
  //                       color: AppColor.PrimaryDark,
  //                     ),
  //                     child: Row(
  //                       children: [
  //                         SizedBox(width: 10,),
  //                         Icon(Icons.image,color: Colors.white,),
  //                         SizedBox(width: 10,),
  //                         Text('From Gallery',style: TextStyle(color: Colors.white),),
  //                       ],
  //                     ),
  //                   ),
  //                 ),
  //                 SizedBox(height: 10,),
  //                 InkWell(
  //                   //if user click this button, user can upload image from gallery
  //                   onTap: () {
  //                     Navigator.pop(context);
  //                     getImage(ImageSource.camera);
  //                   },
  //                   child: Container(
  //                     height: 40,
  //                     decoration: BoxDecoration(
  //                       borderRadius: BorderRadius.circular(5),
  //                       color: AppColor.PrimaryDark,
  //                     ),
  //                     child: Row(
  //                       children: [
  //                         SizedBox(width: 10,),
  //                         Icon(Icons.camera,color: Colors.white,),
  //                         SizedBox(width: 10,),
  //                         Text('From Camera',style: TextStyle(color: Colors.white),),
  //                       ],
  //                     ),
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ),
  //         );
  //       });
  // }
  // void myAlert1() {
  //   showDialog(
  //       context: context,
  //       builder: (BuildContext context) {
  //         return AlertDialog(
  //           shape:
  //           RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
  //           title: Text('Please choose media to select'),
  //           content: Container(
  //             height: MediaQuery.of(context).size.height / 6,
  //             child: Column(
  //               children: [
  //                 InkWell(
  //                   //if user click this button, user can upload image from gallery
  //                   onTap: () {
  //                     Navigator.pop(context);
  //                     getImage1(ImageSource.gallery);
  //                   },
  //                   child: Container(
  //                     height: 40,
  //                     decoration: BoxDecoration(
  //                       borderRadius: BorderRadius.circular(5),
  //                       color: AppColor.PrimaryDark,
  //                     ),
  //                     child: Row(
  //                       children: [
  //                         SizedBox(width: 10,),
  //                         Icon(Icons.image,color: Colors.white,),
  //                         SizedBox(width: 10,),
  //                         Text('From Gallery',style: TextStyle(color: Colors.white),),
  //                       ],
  //                     ),
  //                   ),
  //                 ),
  //                 SizedBox(height: 10,),
  //                 InkWell(
  //                   //if user click this button, user can upload image from gallery
  //                   onTap: () {
  //                     Navigator.pop(context);
  //                     getImage1(ImageSource.camera);
  //                   },
  //                   child: Container(
  //                     height: 40,
  //                     decoration: BoxDecoration(
  //                       borderRadius: BorderRadius.circular(5),
  //                       color: AppColor.PrimaryDark,
  //                     ),
  //                     child: Row(
  //                       children: [
  //                         SizedBox(width: 10,),
  //                         Icon(Icons.camera,color: Colors.white,),
  //                         SizedBox(width: 10,),
  //                         Text('From Camera',style: TextStyle(color: Colors.white),),
  //                       ],
  //                     ),
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ),
  //         );
  //       });
  // }
  // void myAlert2() {
  //   showDialog(
  //       context: context,
  //       builder: (BuildContext context) {
  //         return AlertDialog(
  //           shape:
  //           RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
  //           title: Text('Please choose media to select'),
  //           content: Container(
  //             height: MediaQuery.of(context).size.height / 6,
  //             child: Column(
  //               children: [
  //                 InkWell(
  //                   //if user click this button, user can upload image from gallery
  //                   onTap: () {
  //                     Navigator.pop(context);
  //                     getImage2(ImageSource.gallery);
  //                   },
  //                   child: Container(
  //                     height: 40,
  //                     decoration: BoxDecoration(
  //                       borderRadius: BorderRadius.circular(5),
  //                       color: AppColor.PrimaryDark,
  //                     ),
  //                     child: Row(
  //                       children: [
  //                         SizedBox(width: 10,),
  //                         Icon(Icons.image,color: Colors.white,),
  //                         SizedBox(width: 10,),
  //                         Text('From Gallery',style: TextStyle(color: Colors.white),),
  //                       ],
  //                     ),
  //                   ),
  //                 ),
  //                 SizedBox(height: 10,),
  //                 InkWell(
  //                   //if user click this button, user can upload image from gallery
  //                   onTap: () {
  //                     Navigator.pop(context);
  //                     getImage2(ImageSource.camera);
  //                   },
  //                   child: Container(
  //                     height: 40,
  //                     decoration: BoxDecoration(
  //                       borderRadius: BorderRadius.circular(5),
  //                       color: AppColor.PrimaryDark,
  //                     ),
  //                     child: Row(
  //                       children: [
  //                         SizedBox(width: 10,),
  //                         Icon(Icons.camera,color: Colors.white,),
  //                         SizedBox(width: 10,),
  //                         Text('From Camera',style: TextStyle(color: Colors.white),),
  //                       ],
  //                     ),
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ),
  //         );
  //       });
  // }

  void requestPermission(BuildContext context,int i) async{
    if (await Permission.camera.isPermanentlyDenied||await Permission.storage.isPermanentlyDenied) {
      openAppSettings();
    }
    else{
      Map<Permission, PermissionStatus> statuses = await [
        Permission.camera,
        Permission.storage,
      ].request();
// You can request multiple permissions at once.

      if(statuses[Permission.camera]==PermissionStatus.granted&&statuses[Permission.storage]==PermissionStatus.granted){
        // getImage(ImgSource.Both, context,i);

      }else{
        if (await Permission.camera.isDenied||await Permission.storage.isDenied) {

          // The user opted to never again see the permission request dialog for this
          // app. The only way to change the permission's status now is to let the
          // user manually enable it in the system settings.
          openAppSettings();
        }else{
          setSnackbar("Oops you just denied the permission", context);
        }
      }
    }

  }
  // Future getImage(ImgSource source, BuildContext context,int i) async {
  //   var image = await ImagePickerGC.pickImage(
  //     context: context,
  //     source: source,
  //     cameraIcon: Icon(
  //       Icons.add,
  //       color: Colors.red,
  //     ), //cameraIcon and galleryIcon can change. If no icon provided default icon will be present
  //   );
  //   getCropImage(context, i, image);
  // }
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
    );
    setState(() {
      if(i==1){
        productImage = File(croppedFile!.path);
      }
    });
  }
  String dropdownvalue = 'Palm';
  var items = [
    'Palm',
    'Elbow',
    'Leg',
  ];

  String productName = '';
  String price = '';
  String sPrice = '';
  String description = '';
  String prodImg = '';

  editServices()async{
    var headers = {
      'Cookie': 'ci_session=bcf2871e64e7fec397eaa77e3b6fa2b916b3eade'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${Apipath.editServicesUrl}'));
    request.fields.addAll({
      'name': '${artistNameController.text}',
      'mrp_price': '${priceController.text}',
      'address': '${descriptionController.text}',
      'category_id': '${categoryValue.toString()}',
      //'${categoryValue.toString()}',
      'sub_cat_id': '${subCategoryValue.toString()}',
      'special_price': '${sellingPriceController.text}',
      'v_id': '${uid}',
      // 'other_images[]': '${uploadImages.toString()}'
    });
    for (var i = 0; i < imagePathList.length; i++) {
      imagePathList == null
          ? null
          : request.files.add(await http.MultipartFile.fromPath(
          'other_images[]', imagePathList[i].toString()));
    }
    request.files.add(await http.MultipartFile.fromPath(
        'services_image', '${imagePathList[0].toString()}'));

    print("checking request of api here ${request.fields}");

    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var finalResponse = await response.stream.bytesToString();
      final jsonResponse = json.decode(finalResponse);
      print("checking result ${jsonResponse}");
      if(jsonResponse['status'] == "success") {
        setState(() {
          Fluttertoast.showToast(msg: "Edited successfully");
        });
        Navigator.pop(context, true);
      }
    }
    else {
      print(response.reasonPhrase);
    }
  }

  @override
  void initState(){
    super.initState();
    checkingLogin();
    // _getCollection();
    artistNameController.text = widget.productsModel!.artistName.toString();
    priceController.text = widget.productsModel!.mrpPrice.toString();
    sellingPriceController.text =  widget.productsModel!.specialPrice.toString();
    descriptionController.text = widget.productsModel!.description.toString();
    prodImg = widget.productsModel!.profileImage.toString();
    // categoryValue = widget.productsModel!.categoryId.toString();
    descriptionController.text = widget.productsModel!.description.toString();
    // subCategoryValue =  widget.productsModel!.subId.toString();
  }


  _getCollection() async {
    var uri = Uri.parse('${Apipath.getCategoriesUrl}');
    var request = new http.MultipartRequest("POST", uri);
    Map<String, String> headers = {
      "Accept": "application/json",
    };
    // print(baseUrl.toString());
    request.headers.addAll(headers);
    request.fields['type_id'] = "${type.toString()}";
    // request.fields['vendor_id'] = userID;
    var response = await request.send();
    print(response.statusCode);
    String responseData = await response.stream.transform(utf8.decoder).join();
    var userData = json.decode(responseData);

    if (mounted) {
      setState(() {
        // collectionModal = AllCateModel.fromJson(userData);
        catlist = CategoriesModel.fromJson(userData).data!;
        // print(
        //     "ooooo ${collectionModal!.status} and ${collectionModal!.categories!.length} and ${userID}");
      });
    }
    print(responseData);
  }

  List? subCategoryModel;

  getSubCategory(String? id)async{
    var headers = {'Cookie': 'ci_session=5b275056e99daf066cd95d54b384b2ccd46f50b1'};
    var request = http.MultipartRequest('POST', Uri.parse('${Apipath.getCategoriesUrl}'));
    request.fields.addAll({
      'p_id': '$id'
    });
    print("res ${request.fields}");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var finalResponse = await response.stream.bytesToString();
      final jsonResponse = json.decode(finalResponse);
      print("json response here  ${jsonResponse} and ${jsonResponse}");
      setState((){
        subCategoryModel = jsonResponse['data'];
      });
    }
    else {
      print(response.reasonPhrase);
    }
  }
  ///MULTI IMAGE PICKER
  ///
  ///
  var imagePathList ;
  bool isImages = false;
  Future<void> getFromGallery() async {
    var result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: true,
    );
    if (result != null) {
      setState(() {
        isImages = true;
        // servicePic = File(result.files.single.path.toString());
      });
      imagePathList = result.paths.toList();
      // imagePathList.add(result.paths.toString()).toList();
      print("SERVICE PIC === ${imagePathList.length}");
    } else {
      // User canceled the picker
    }
  }
  Widget uploadMultiImage() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(
          height: 10,
        ),
        InkWell(
            onTap: () async {
              getFromGallery();
              // await pickImages();
            },
            child: Container(
                height: 40,
                width: 150,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: AppColor().colorPrimary()),
                child: Center(
                    child: Text(
                      "Upload Pictures",
                      style: TextStyle(color: AppColor().colorBg1()),
                    )))),
        const SizedBox(
          height: 10,
        ),
        Visibility(
            visible: isImages,
            child: imagePathList != null ? buildGridView() : SizedBox.shrink()
        )

      ],
    );
  }
  Widget buildGridView() {
    return Container(
      height: 165,
      child: GridView.builder(
        itemCount: imagePathList.length,
        gridDelegate:
        SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (BuildContext context, int index) {
          return Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15))
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(15)),
                child: Image.file(File(imagePathList[index]),
                    fit: BoxFit.cover),
              ));
        },
      ),
    );
  }
  ///MULTI IMAGE PICKER
  ///
  ///

  @override
  Widget build(BuildContext context) {
    changeStatusBarColor(AppColor().colorBg2());
    return Scaffold(
      backgroundColor: AppColor().colorPrimary(),
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: InkWell(
            onTap: (){
              Navigator.of(context).pop();
            },
            child: Icon(Icons.arrow_back_ios,color: Colors.white,)),
        backgroundColor: AppColor().colorPrimary(),
        title: Text("Edit Service", style: TextStyle(
            color: AppColor().colorBg1()
        ),),
      ),
      body:   Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.only(top: 30),
          decoration: BoxDecoration(
              color: AppColor().colorBg2(),
              borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30))
          ),
          child:SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // SizedBox(height: 10,),
                // Container(
                //   height: 90,
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.center,
                //     children: [
                //       InkWell(
                //         onTap: (){
                //           requestPermission(context, 1);
                //         },
                //         child: Container(
                //           width: 120,
                //           height: 90,
                //           child: Stack(
                //             children: [
                //               DottedBorder(
                //                   color: Colors.black,
                //                   strokeWidth: 1,
                //                   child: Container(
                //                     alignment: Alignment.center,
                //                     height: 80,
                //                     width: 100,
                //                     child: prodImg != '' ? Image.network('${prodImg}',fit: BoxFit.fill,width: 100,) : image2 != null ? Image.file(File(image2!.path),fit: BoxFit.fill,width: 100,) : Column(
                //                       crossAxisAlignment: CrossAxisAlignment.center,
                //                       mainAxisAlignment: MainAxisAlignment.center,
                //                       children: [
                //                         Icon(Icons.image),
                //                         Text("Add Picture"),
                //                       ],
                //                     ),
                //                   )
                //               ),
                //               Positioned(
                //                 right: 1,
                //                 bottom: 1,
                //                 child: Container(
                //                   padding: EdgeInsets.all(5),
                //                   decoration: BoxDecoration(
                //                     borderRadius: BorderRadius.circular(100),
                //                     color: AppColor.PrimaryDark,
                //                   ),
                //                   child: Icon(Icons.photo_camera_outlined,color: Colors.white,size: 15,),
                //                 ),
                //               ),
                //             ],
                //           ),
                //         ),
                //       ),
                //
                //     ],
                //   ),
                // ),
                SizedBox(height: 25,),
                /// name controller
                Text("Service Name",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500),),
                SizedBox(height: 8,),
                TextFormField(controller: artistNameController,decoration: InputDecoration(
                    hintText: "Service Name",
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    )
                ),),
                SizedBox(height: 12,),
                Text("Category",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500),),
                SizedBox(height: 12,),
                Padding(
                  padding: const EdgeInsets.only(top: 5.0, bottom: 10),
                  child: Container(
                    height: 60,
                    padding: EdgeInsets.only(left: 10),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(7),
                        border: Border.all(color: Colors.black.withOpacity(0.7))),
                    child: DropdownButton(
                      // Initial Value
                      value: categoryValue,
                      underline: Container(),
                      isExpanded: true,
                      // Down Arrow Icon
                      icon: Icon(Icons.keyboard_arrow_down),
                      hint: Text("Select category"),
                      // Array list of items
                      items: catlist.map((items) {
                        return DropdownMenuItem(
                          value: items.id,
                          child: Container(child: Text(items.cName.toString())),
                        );
                      }).toList(),
                      // After selecting the desired option,it will
                      // change button value to selected value
                      onChanged: (newValue) {
                        setState(() {
                          categoryValue = newValue as String?;
                          getSubCategory(categoryValue);
                          print("selected category ${categoryValue}");
                        });
                      },
                    ),
                  ),
                ),
                SizedBox(height: 12,),
                Text("Subcategory",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500),),
                SizedBox(height: 12,),
                Container(
                  height: 60,
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.only(left: 10),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.black)
                  ),
                  child:
                  subCategoryModel == null ?
                  Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: Text(
                      "Select Subcategory",
                      style: TextStyle(
                          fontSize: 16,
                          color: colors.subTxtClr
                      ),
                    ),
                  )  :
                  DropdownButton(
                    underline: Container(),
                    value: subCategoryValue,
                    hint:Text("Select value"),
                    isExpanded: true,
                    icon: Container(
                        alignment: Alignment.centerRight,
                        width: MediaQuery.of(context).size.width/2.7,
                        child: Icon(Icons.keyboard_arrow_down)),

                    items: subCategoryModel!.map((items) {

                      return DropdownMenuItem(
                        value: items['id'],
                        child: Text(items['c_name']),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      setState(() {
                        subCategoryValue = newValue! as String?;
                      });
                    },
                  ),
                ),
                SizedBox(height: 8,),
                Text("Price",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500),),
                SizedBox(height: 8,),
                TextFormField(controller: priceController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      hintText: "Price",
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      )
                  ),),
                // ///  palm cost controller
                // Text("Palm Cost",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500),),
                // SizedBox(height: 8,),
                // TextFormField(controller: palmCostController,decoration: InputDecoration(
                //     hintText: "Palm Cost",
                //     fillColor: Colors.white,
                //     filled: true,
                //     border: OutlineInputBorder(
                //       borderRadius: BorderRadius.circular(8),
                //     )
                // ),),
                // SizedBox(height: 12,),
                // /// elbow cost controller
                // Text("Elbow Cost",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500),),
                // SizedBox(height: 8,),
                // TextFormField(controller: elbowCostController,decoration: InputDecoration(
                //     hintText: "Elbow Cost",
                //     fillColor: Colors.white,
                //     filled: true,
                //     border: OutlineInputBorder(
                //       borderRadius: BorderRadius.circular(8),
                //     )
                // ),),
                // SizedBox(height: 12,),
                // /// Legs controller
                // Text("Legs",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500),),
                // SizedBox(height: 8,),
                // TextFormField(controller: legsController,decoration: InputDecoration(
                //     hintText: "Legs",
                //     fillColor: Colors.white,
                //     filled: true,
                //     border: OutlineInputBorder(
                //       borderRadius: BorderRadius.circular(8),
                //     )
                // ),),

                type == "7" ?
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 12,),
                    Text("Per day charge",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500),),
                    SizedBox(height: 8,),
                    TextFormField(controller: perDayController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          hintText: "Per day charges",
                          fillColor: Colors.white,
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          )
                      ),),
                  ],
                ) : SizedBox.shrink(),
                SizedBox(height: 12,),
                /// selling price controller
                Text("Special Price",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500),),
                SizedBox(height: 8,),
                TextFormField(controller: sellingPriceController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      hintText: "Special Price",
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      )
                  ),),
                SizedBox(height: 12,),
                /// description controller
                Text("Description",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500),),
                SizedBox(height: 8,),
                TextFormField(
                  controller: descriptionController,decoration: InputDecoration(
                    hintText: "Description",
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    )
                ),),
                // SizedBox(height: 12,),
                // /// Address controller
                // Text("Address",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500),),
                // SizedBox(height: 8,),
                // TextFormField(controller: addressController,decoration: InputDecoration(
                //     hintText: "Address",
                //     fillColor: Colors.white,
                //     filled: true,
                //     border: OutlineInputBorder(
                //       borderRadius: BorderRadius.circular(8),
                //     )
                // ),),
                uploadMultiImage(),
                SizedBox(
                  height: 30,
                ),

                Center(
                    child:
                    InkWell(
                      onTap: ()async{
                        setState((){
                          isLoading = true;
                        });
                        editServices();

                      },
                      child: Container(
                          height: 43,
                          width: MediaQuery.of(context).size.width/ 1.2,
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: AppColor().colorSecondary()),
                          child: Center(
                              child: isLoading ?
                         loadingWidget()
                                  : Text("Submit", style: TextStyle(fontSize: 18, color: AppColor.PrimaryDark)))
                      ),
                    )
                  // AppBtn(
                  //   onPress: (){
                  //     setState((){
                  //       isLoading = true;
                  //     });
                  //     addProducts();
                  //   },
                  //   label: "Submit",
                  // ),
                ),
                // InkWell(
                //   onTap: (){
                //     //addService();
                //   },
                //   child: Container(
                //     height: 45,
                //     alignment: Alignment.center,
                //     decoration: BoxDecoration(
                //         borderRadius: BorderRadius.circular(8),
                //         color: AppColor.PrimaryDark
                //     ),
                //     child: Text("Submit",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500,fontSize: 15),),
                //   ),
                // ),
                SizedBox(
                  height: 30,
                ),
              ],
            ),
          )
      ),
    );
  }
}
