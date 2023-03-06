import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:fixerking/RideFlow/utils/Session.dart';
import 'package:fixerking/RideFlow/utils/common.dart';
import 'package:fixerking/api/api_path.dart';
import 'package:fixerking/new%20model/SubCategoryModel.dart';
import 'package:fixerking/new%20model/categories_model.dart';
import 'package:fixerking/screen/BottomBars/bottom_bar.dart';
import 'package:fixerking/utility_widget/customLoader.dart';
import 'package:fixerking/utils/app_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:image_picker_gallery_camera/image_picker_gallery_camera.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../utils/colors.dart';
import '../../../utils/widget.dart';

import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import '../../token/token_string.dart';

class AddProducts extends StatefulWidget {
  const AddProducts({Key? key}) : super(key: key);

  @override
  State<AddProducts> createState() => _AddProductsState();
}

class _AddProductsState extends State<AddProducts> {
  var categoryValue;
  var subCategoryValue;

  TextEditingController artistNameController = TextEditingController();
  TextEditingController palmCostController = TextEditingController();
  TextEditingController elbowCostController = TextEditingController();
  TextEditingController legsController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController sellingPriceController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  PickedFile? image1;
  PickedFile? image2;
  PickedFile? image3;
  int? _value1 = 1;


  List? subCategoryModel;
  bool isLoading = false;
  bool isSuccess = false;
  String productType = "Veg";

  List<Category> catlist = [];

  _getCollection() async {
    var uri = Uri.parse('${Apipath.getCategoriesUrl}');
    var request = new http.MultipartRequest("POST", uri);
    Map<String, String> headers = {
      "Accept": "application/json",
    };

    request.headers.addAll(headers);
    request.fields['type_id'] = '${type.toString()}';
    print("${request.fields.toString()}");
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

  List<Varients> productsVariants = [];
  var varTypeValue;
  _getFoodVarients() async {
    var uri = Uri.parse('${Apipath.getFoodVariantsUrl}');
    var request = new http.MultipartRequest("GET", uri);
    Map<String, String> headers = {
      "Accept": "application/json",
    };
    var response = await request.send();
    print(response.statusCode);
    String responseData = await response.stream.transform(utf8.decoder).join();
    var userData = json.decode(responseData);

    if (mounted) {
      setState(() {
        productsVariants = ProductVarientModel.fromJson(userData).data!;
      });
    }
    print(responseData);
  }

  getSubCategory(String? id) async {
    var headers = {
      'Cookie': 'ci_session=5b275056e99daf066cd95d54b384b2ccd46f50b1'
    };
    var request = http.MultipartRequest(
        'POST',
        Uri.parse(
            '${Apipath.getCategoriesUrl}'));
    request.fields.addAll({'p_id': '$id'});
    print("res ${request.fields}");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var finalResponse = await response.stream.bytesToString();
      final jsonResponse = json.decode(finalResponse);
      print("json response here  ${jsonResponse} and ${jsonResponse}");
      setState(() {
        subCategoryModel = jsonResponse['data'];
      });
    } else {
      print(response.reasonPhrase);
    }
  }

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
  // Future getImageFromCamera(ImageSource media)async{
  //   var img = await picker.getImage(source: media);
  //   setState(() {
  //     image1 = img;
  //   });
  // }

  String? uid;
  String? type;
  void checkingLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      uid = prefs.getString(TokenString.userid);
      type = prefs.getString(TokenString.type);
    });
    _getCollection();
  }

  addProducts() async {
    var headers = {
      'Cookie': 'ci_session=bcf2871e64e7fec397eaa77e3b6fa2b916b3eade'
    };
    var request =
        http.MultipartRequest('POST', Uri.parse('${Apipath.addProductUrl}'));
    request.fields.addAll({
      'name': '${artistNameController.text}',
      'product_price': '${priceController.text}',
      'product_description': '${descriptionController.text}',
      'cat_id': '${categoryValue.toString()}',
      //'${categoryValue.toString()}',
      'sub_cat_id': '${subCategoryValue.toString()}',
      'selling_price': '${sellingPriceController.text}',
      'vid': '${uid.toString()}',
      'variant_name': '${varTypeValue.toString()}',
      'product_type': '${productType.toString()}',
      // 'other_image[]': '${uploadImages.toString()}'
    });

    for (var i = 0; i < imagePathList.length; i++) {
      imagePathList == null
          ? null
          : request.files.add(await http.MultipartFile.fromPath(
          'other_image[]', imagePathList[i].toString()));
    }
        request.files.add(await http.MultipartFile.fromPath(
            'main_image', '${imagePathList[0].toString()}'));
    request.headers.addAll(headers);
    print("checking request of api here ${request.fields} aand");

    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var finalResponse = await response.stream.bytesToString();
      final jsonResponse = json.decode(finalResponse);
      print("checking result ${jsonResponse}");
      if (jsonResponse['response_code'] == "1") {
        setState(() {
          isLoading = false;
          isSuccess = true;
        });
        Fluttertoast.showToast(msg: "${jsonResponse['message']}");
        Navigator.pop(context, true);
      } else {
        setState(() {
          isLoading = false;
          isSuccess = true;
        });
        Fluttertoast.showToast(msg: "${jsonResponse['message']}");
      }
    } else {
      setState(() {
        isLoading = false;
      });
      print(response.reasonPhrase);
    }
  }

  void requestPermission(BuildContext context, int i) async {
    if (await Permission.camera.isPermanentlyDenied ||
        await Permission.storage.isPermanentlyDenied) {
      openAppSettings();
    } else {
      Map<Permission, PermissionStatus> statuses = await [
        Permission.camera,
        Permission.storage,
      ].request();
// You can request multiple permissions at once.

      if (statuses[Permission.camera] == PermissionStatus.granted &&
          statuses[Permission.storage] == PermissionStatus.granted) {
        // getImage(ImgSource.Both, context,i);

      } else {
        if (await Permission.camera.isDenied ||
            await Permission.storage.isDenied) {
          // The user opted to never again see the permission request dialog for this
          // app. The only way to change the permission's status now is to let the
          // user manually enable it in the system settings.
          openAppSettings();
        } else {
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
  void getCropImage(BuildContext context, int i, var image) async {
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
      if (i == 1) {
        productImage = File(croppedFile!.path);
      }
    });
  }

///MULTI IMAGE PICKER
  ///
  ///
  ///
  var imagePathList;
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
          return Stack(
            children: [
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15))
                ),
                  child: Container(
                    width: MediaQuery.of(context).size.width/2,
                    height: MediaQuery.of(context).size.height/2,
                    child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                      child: Image.file(File(imagePathList[index]),
                          fit: BoxFit.cover),
                    ),
                  )),
              Positioned(
                top: 5,
                right: 10,
                child: InkWell(
                  onTap: (){
                    setState((){
                      imagePathList.remove(imagePathList[index]);
                    });

                  },
                  child: Icon(
                    Icons.remove_circle,
                  size: 30,
                  color: Colors.red.withOpacity(0.7),),
                ),
              )
            ],
          );
        },
      ),
    );
  }
  ///MULTI IMAGE PICKER
  ///
  ///
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // Future.delayed(Duration(milliseconds: 500),(){
    checkingLogin();
    _getFoodVarients();
    // });
  }

  // Widget imageRC() {
  //   return Material(
  //     elevation: 0,
  //     borderRadius: BorderRadius.circular(15),
  //     child: InkWell(
  //       onTap: () {
  //         pickImages();
  //         // openImages();
  //         // requestPermission(context, 1);
  //         // uploadRCFromCamOrGallary(context);
  //       },
  //       child: Center(
  //         child: Container(
  //           width: 120,
  //           color: AppColor().colorBg2(),
  //           child: Stack(children: [
  //             DottedBorder(
  //               borderType: BorderType.RRect,
  //               radius: Radius.circular(15),
  //               child: Container(
  //                 height: 100,
  //                 width: 100,
  //                 decoration: BoxDecoration(
  //                     // border: Border.all(color: Colors.grey),
  //                     borderRadius: BorderRadius.circular(15)),
  //                 child: ClipRRect(
  //                   borderRadius: BorderRadius.circular(15),
  //                   child: picturesList[0].path != null
  //                       ? Image.file(File(picturesList[0].path),
  //                           fit: BoxFit.cover)
  //                       : Column(
  //                           mainAxisAlignment: MainAxisAlignment.center,
  //                           children: [
  //                             Center(child: Icon(Icons.image, size: 40)),
  //                             Text("Upload Pictures")
  //                           ],
  //                         ),
  //                 ),
  //               ),
  //             ),
  //             Positioned(
  //               right: 1,
  //               bottom: 2,
  //               child: Container(
  //                 padding: EdgeInsets.all(5),
  //                 decoration: BoxDecoration(
  //                   borderRadius: BorderRadius.circular(100),
  //                   color: AppColor.PrimaryDark,
  //                 ),
  //                 child: Icon(
  //                   Icons.photo_camera_outlined,
  //                   color: Colors.white,
  //                   size: 15,
  //                 ),
  //               ),
  //             ),
  //           ]),
  //         ),
  //       ),
  //     ),
  //   );
  // }



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
              getImageFromCamera();
              Navigator.of(context, rootNavigator: true).pop("Discard");
            },
          ),
          CupertinoActionSheetAction(
            child: Text(
              "Photo & Video Library",
              style: TextStyle(color: Colors.black, fontSize: 15),
            ),
            onPressed: () {
              getImageFromGallery();
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

  File? productImage;
  Future<void> getImageFromCamera() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
    );
    if (pickedFile != null) {
      setState(() {
        productImage = File(pickedFile.path);
        // imagePath = File(pickedFile.path) ;
        // filePath = imagePath!.path.toString();
      });
    }
  }

  final ImagePicker imgpicker = ImagePicker();
  final ImagePicker _picker = ImagePicker();
  List<XFile>? imageFiles;


  Future<void> getImageFromGallery() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      setState(() {
        productImage = File(pickedFile.path);
        // imagePath = File(pickedFile.path) ;
        // filePath = imagePath!.path.toString();
      });
    }
  }

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
            onTap: () {
              Navigator.pop(context, true);
              imagePathList.clear();
            },
            child: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            )),
        backgroundColor: AppColor().colorPrimary(),
        title: Text(
          "Add Products",
          style: TextStyle(color: AppColor().colorBg1()),
        ),
      ),
      body: Container(
          padding: EdgeInsets.only(top: 5),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              color: AppColor().colorSecondary(),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(45),
                topRight: Radius.circular(45),
              )),
          child: Container(
              padding: EdgeInsets.only(top: 30),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: AppColor().colorBg2(),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(45),
                    topRight: Radius.circular(45)),
              ),
              child: SingleChildScrollView(
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
                    //       // imageRC(),
                    //
                    //
                    //       // InkWell(
                    //       //   onTap: (){
                    //       //     myAlert1();
                    //       //   },
                    //       //   child: Container(
                    //       //     width: 120,
                    //       //     height: 90,
                    //       //     child: Stack(
                    //       //       children: [
                    //       //         DottedBorder(
                    //       //             color: Colors.black,
                    //       //             strokeWidth: 1,
                    //       //             child: Container(
                    //       //               alignment: Alignment.center,
                    //       //               height: 80,
                    //       //               width: 100,
                    //       //               child:image2 != null ? Image.file(File(image2!.path),fit: BoxFit.fill,width: 100,) : Column(
                    //       //                 crossAxisAlignment: CrossAxisAlignment.center,
                    //       //                 mainAxisAlignment: MainAxisAlignment.center,
                    //       //                 children: [
                    //       //                   Icon(Icons.image),
                    //       //                   Text("Add Picture"),
                    //       //                 ],
                    //       //               ),
                    //       //             )
                    //       //         ),
                    //       //         Positioned(
                    //       //           right: 1,
                    //       //           bottom: 1,
                    //       //           child: Container(
                    //       //             padding: EdgeInsets.all(5),
                    //       //             decoration: BoxDecoration(
                    //       //               borderRadius: BorderRadius.circular(100),
                    //       //               color: AppColor.PrimaryDark,
                    //       //             ),
                    //       //             child: Icon(Icons.photo_camera_outlined,color: Colors.white,size: 15,),
                    //       //           ),
                    //       //         ),
                    //       //       ],
                    //       //     ),
                    //       //   ),
                    //       // ),
                    //
                    //     ],
                    //   ),
                    // ),
                    // buildGridView(),
                    SizedBox(
                      height: 25,
                    ),

                    /// name controller
                    Text(
                      "Product Name",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    TextFormField(
                      controller: artistNameController,
                      decoration: InputDecoration(
                          hintText: "Product Name",
                          fillColor: Colors.white,
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          )),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Text(
                      "Category",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5.0, bottom: 10),
                      child: Container(
                        height: 60,
                        padding: EdgeInsets.only(left: 10),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(7),
                            border: Border.all(
                                color: Colors.black.withOpacity(0.7))),
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
                              child: Container(
                                  child: Text(items.cName.toString())),
                            );
                          }).toList(),
                          // After selecting the desired option,it will
                          // change button value to selected value
                          onChanged: (newValue) {
                            setState(() {
                              categoryValue = newValue;
                              getSubCategory(categoryValue);
                              print("selected category ${categoryValue}");
                            });
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Text(
                      "Subcategory",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Container(
                      height: 60,
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.only(
                        left: 10,
                      ),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.black)),
                      child: subCategoryModel == null
                          ? Padding(
                              padding: const EdgeInsets.only(top: 15),
                              child: Text(
                                "Select Subcategory",
                                style: TextStyle(
                                    fontSize: 16, color: colors.subTxtClr),
                              ),
                            )
                          : DropdownButton(
                              underline: Container(),
                              value: subCategoryValue,
                              // hint:Text("Select value"),
                              isExpanded: true,
                              icon: Container(
                                  alignment: Alignment.centerRight,
                                  width:
                                      MediaQuery.of(context).size.width / 2.7,
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
                                  value: 1,
                                  groupValue: _value1,
                                  onChanged: (int? value) {
                                    setState(() {
                                      _value1 = value!;
                                      productType = "Veg";
                                      // roleUser = true;
                                      // isUpi = false;
                                    });
                                  }),
                              SizedBox(
                                width: 10.0,
                              ),
                              Container(
                                padding: EdgeInsets.all(10),
                                // height: 40,
                                decoration: BoxDecoration(
                                    color: AppColor().colorBg1(),
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                        color: AppColor().colorPrimary())),
                                child: Row(
                                  children: [
                                    Image.asset(
                                      'images/veg.png',
                                      height: 20,
                                      width: 20,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text("Veg")
                                  ],
                                ),
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Radio(
                                  value: 2,
                                  groupValue: _value1,
                                  onChanged: (int? value) {
                                    setState(() {
                                      _value1 = value!;
                                      productType = "Non-Veg";
                                      // roleUser = false;
                                      // isUpi = true;
                                    });
                                  }),
                              SizedBox(
                                width: 10.0,
                              ),
                              Container(
                                padding: EdgeInsets.all(10),
                                // height: 40,
                                decoration: BoxDecoration(
                                    color: AppColor().colorBg1(),
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                        color: AppColor().colorPrimary())),
                                child: Row(
                                  children: [
                                    Image.asset(
                                      'images/nonveg.png',
                                      height: 20,
                                      width: 20,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text("Non-Veg")
                                  ],
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5.0, bottom: 10),
                      child: Container(
                        height: 60,
                        padding: EdgeInsets.only(left: 10),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(7),
                            border: Border.all(
                                color: Colors.black.withOpacity(0.7))),
                        child: DropdownButton(
                          // Initial Value
                          value: varTypeValue,
                          underline: Container(),
                          isExpanded: true,
                          // Down Arrow Icon
                          icon: Icon(Icons.keyboard_arrow_down),
                          hint: Text("Select Product Variant"),
                          // Array list of items
                          items: productsVariants.map((items) {
                            return DropdownMenuItem(
                              value: items.name,
                              child:
                                  Container(child: Text(items.name.toString())),
                            );
                          }).toList(),
                          // After selecting the desired option,it will
                          // change button value to selected value
                          onChanged: (newValue) {
                            setState(() {
                              varTypeValue = newValue;
                              // getSubCategory(categoryValue);
                              print("selected variant ${varTypeValue}");
                            });
                          },
                        ),
                      ),
                    ),
                    // Container(
                    //   height: 60,
                    //   padding: EdgeInsets.only(left: 10),
                    //   decoration: BoxDecoration(
                    //     color: AppColor().colorBg1(),
                    //       borderRadius: BorderRadius.circular(7),
                    //       border: Border.all(
                    //           color: Colors.black.withOpacity(0.7))),
                    //   child: DropdownButton(
                    //
                    //     // Initial Value
                    //     value: varTypeValue,
                    //     underline: Container(),
                    //     isExpanded: true,
                    //     // Down Arrow Icon
                    //     icon: Icon(Icons.keyboard_arrow_down),
                    //     hint: Text("Select Variant Type"),
                    //     // Array list of items
                    //     items: variantType.map((items) {
                    //       return DropdownMenuItem(
                    //         value: items,
                    //         child: Container(
                    //             child: Text(items.toString())),
                    //       );
                    //     }).toList(),
                    //     // After selecting the desired option,it will
                    //     // change button value to selected value
                    //     onChanged: (newValue) {
                    //       setState(() {
                    //         varTypeValue = newValue!;
                    //         print(
                    //             "selected category ${varTypeValue.toString()}");
                    //       });
                    //     },
                    //   ),
                    // ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      "Price",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    TextFormField(
                      controller: priceController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          hintText: "Price",
                          fillColor: Colors.white,
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          )),
                    ),

                    SizedBox(
                      height: 12,
                    ),

                    /// selling price controller
                    Text(
                      "Special Price",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    TextFormField(
                      controller: sellingPriceController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          hintText: "Special Price",
                          fillColor: Colors.white,
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          )),
                    ),
                    SizedBox(
                      height: 12,
                    ),

                    /// description controller
                    Text(
                      "Description",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    TextFormField(
                      controller: descriptionController,
                      decoration: InputDecoration(
                          hintText: "Description",
                          fillColor: Colors.white,
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          )),
                    ),

                    uploadMultiImage(),

                    SizedBox(
                      height: 30,
                    ),
                    Center(
                        child: InkWell(
                      onTap: () async {
                        setState(() {
                          isLoading = true;
                        });
                        if (artistNameController.text.isNotEmpty &&
                            priceController.text.isNotEmpty &&
                            sellingPriceController.text.isNotEmpty &&
                            categoryValue != null &&
                            subCategoryValue != null) {
                          addProducts();
                        } else {
                          setState(() {
                            isLoading = false;
                          });
                          Fluttertoast.showToast(
                              msg: "Please fill required fields!");
                        }
                      },
                      child: Container(
                          height: 43,
                          width: MediaQuery.of(context).size.width / 1.2,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: AppColor().colorSecondary()),
                          child: Center(
                              child: isLoading
                                  ? loadingWidget()
                                  : Text("Submit",
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: AppColor.PrimaryDark)))),
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
                    //     addProducts();
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
              ))),
    );
  }
}
