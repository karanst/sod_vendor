import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:fixerking/RideFlow/utils/Session.dart';
import 'package:fixerking/api/api_path.dart';
import 'package:fixerking/new%20model/SubCategoryModel.dart';
import 'package:fixerking/new%20model/categories_model.dart';
import 'package:fixerking/utility_widget/customLoader.dart';
import 'package:fixerking/utils/app_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:image_picker_gallery_camera/image_picker_gallery_camera.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../utils/colors.dart';
import '../../../utils/widget.dart';


import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import '../../../utils/colors.dart';
import '../../../utils/widget.dart';
import '../../token/token_string.dart';

class AddServices extends StatefulWidget {
  const AddServices({Key? key}) : super(key: key);

  @override
  State<AddServices> createState() => _AddServicesState();
}

class _AddServicesState extends State<AddServices> {


  String? categoryValue;
  String? subCategoryValue;

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

  bool isLoading = false;

  List<Category> catlist = [];
  String? type;
  void checkingLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      uid = prefs.getString(TokenString.userid);
      type = prefs.getString(TokenString.type);
    });
    _getCollection();
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
    var headers = {
      'Cookie': 'ci_session=5b275056e99daf066cd95d54b384b2ccd46f50b1'
    };
    var request = http.MultipartRequest('POST',
        Uri.parse('${Apipath.getCategoriesUrl}'));
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

  String? uid;

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
                    color: Colors.white.withOpacity(0.6),),
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

  addServices()async{
    var headers = {
      'Cookie': 'ci_session=bcf2871e64e7fec397eaa77e3b6fa2b916b3eade'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${Apipath.addServicesUrl}'));
    request.fields.addAll({
      'name': '${artistNameController.text}',
      'mrp_price': '${priceController.text}',
      'ser_desc': '${descriptionController.text}',
      'category_id': '${categoryValue.toString()}',
      'sub_cat_id': '${subCategoryValue.toString()}',
      'special_price': '${sellingPriceController.text}',
      'roll': '${type.toString()}',
      'v_id': '${uid.toString()}',
      // 'other_images[]': '${uploadImages.toString()}'
    });
    if(type == "7"){
      request.fields.addAll({
        'per_day_charge' : '${perDayController.text}',
      });
    }
    for (var i = 0; i < imagePathList.length; i++) {
      imagePathList == null
          ? null
          : request.files.add(await http.MultipartFile.fromPath(
          'other_images[]', imagePathList[i].toString()));
    }
    request.files.add(await http.MultipartFile.fromPath(
        'services_image', '${imagePathList[0].toString()}'));
    print("checking request of api here ${request.fields} aand ${request.files.toString()}");

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
        Navigator.pop(context, true);
      }
    }
    else {
      print(response.reasonPhrase);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkingLogin();

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
            onTap: (){
              Navigator.of(context).pop();
            },
            child: Icon(Icons.arrow_back_ios,color: Colors.white,)),
        backgroundColor: AppColor().colorPrimary(),
        title: Text("Add Service", style: TextStyle(
            color: AppColor().colorBg1()
        ),),
      ),
      body:  Container(
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
                  padding: EdgeInsets.only(left: 10,),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.black)
                  ),
                  child: subCategoryModel == null ?
                  Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: Text(
                      "Select Subcategory",
                      style: TextStyle(
                          fontSize: 16,
                          color: colors.subTxtClr
                      ),
                    ),
                  ) :  DropdownButton(
                    underline: Container(),
                    value: subCategoryValue,
                    // hint:Text("Select value"),
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
                // Container(
                //   height: 60,
                //   width: MediaQuery.of(context).size.width,
                //   padding: EdgeInsets.only(left: 10),
                //   decoration: BoxDecoration(
                //       color: Colors.white,
                //       borderRadius: BorderRadius.circular(8),
                //       border: Border.all(color: Colors.black)
                //   ),
                //   child: subCategoryModel == null ? Center(child: Center(
                //       child: Container(
                //         height: 30,
                //         width: 30,
                //         child: CircularProgressIndicator(
                //           color: colors.primary,
                //         ),
                //       )),) :  DropdownButton(
                //     underline: Container(),
                //     value: subCategoryValue,
                //     hint:Text("Select value"),
                //     isExpanded: true,
                //     icon: Container(
                //         alignment: Alignment.centerRight,
                //         width: MediaQuery.of(context).size.width/2.7,
                //         child: Icon(Icons.keyboard_arrow_down)),
                //
                //     items: subCategoryModel!.map((items) {
                //
                //       return DropdownMenuItem(
                //         value: items['id'],
                //         child: Text(items['c_name']),
                //       );
                //     }).toList(),
                //     onChanged: (newValue) {
                //       setState(() {
                //         subCategoryValue = newValue! as String?;
                //       });
                //     },
                //   ),
                // ),
                SizedBox(height: 8,),
                Text(
                  type == "5" ?
                  "Cost per Design"
                  : "Cost per hour",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500),),
                SizedBox(height: 8,),
                TextFormField(controller: priceController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      hintText:
                      type == "5" ?
                      "Cost per Design"
                          : "Cost per hour",
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      )
                  ),),
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
                TextFormField(controller: descriptionController,decoration: InputDecoration(
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
                        addServices();


                      },
                      child: Container(
                          height: 43,
                          width: MediaQuery.of(context).size.width/ 1.2,
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: AppColor().colorSecondary()),
                          child: Center(child: isLoading ?
                          loadingWidget() :
                          Text("Submit", style: TextStyle(fontSize: 18, color: AppColor.PrimaryDark)))
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
                //
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
