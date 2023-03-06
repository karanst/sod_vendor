import 'dart:convert';
import 'package:fixerking/screen/sub_category_screen.dart';
import 'package:fixerking/utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../api/api_path.dart';
import '../modal/ServiceCategoryModel.dart';

class Categories extends StatefulWidget {
  const Categories({Key? key}) : super(key: key);

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  ServiceCategoryModel? collectionModal;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getServiceCategory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Categories"),
        backgroundColor: AppColor.PrimaryDark,
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: collectionModal == null
              ? Center(
            child: CupertinoActivityIndicator(),
          )
              : collectionModal!.data!.length > 0
              ? Padding(
            padding: const EdgeInsets.only(top: 20),
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              //physics: const NeverScrollableScrollPhysics(),
              itemCount: collectionModal!.data!.length,
              itemBuilder: (context, int index) {
                return widgetCatedata(
                    collectionModal!.data![index]);
              },
            ),
          )
              : Center(
            child: Text(
              "Don't have any categories now",
              style: TextStyle(
                color: Colors.white,
                fontStyle: FontStyle.italic,
              ),
            ),
          )
        ),
      ),
    );
  }

  Widget widgetCatedata(Data categories) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  SubCategoryScreen(id: categories.id!, name: categories.cName!)
            // ViewCategory(id: categories.id!, name: categories.cName!)
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15, bottom: 10),
        child: new Card(
          margin: EdgeInsets.symmetric(horizontal: 0, vertical: 5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          color: Colors.black45,
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 100,
            child: Row(
              children: <Widget>[
                Container(width: 20),
                Container(
                    height: 70,
                    width: 100 ,
                    child: Image.network(
                      categories.img!,
                      fit: BoxFit.cover,
                      // color: appColorWhite,
                    )),
                Container(width: 20),
                Container(
                  width: 160,
                  child: Text(
                    categories.cName!,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    style: TextStyle(
                        fontSize: 20.0,
                        fontFamily: 'OpenSansBold',
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
                Container(width: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<ServiceCategoryModel?> getServiceCategory() async {
    var uri = Uri.parse('${Apipath.BASH_URL}get_categories_list');
    var request = new http.MultipartRequest("POST", uri);
    Map<String, String> headers = {
      "Accept": "application/json",
    };
    request.headers.addAll(headers);
    var response = await request.send();
    print(response.statusCode);
    String responseData = await response.stream.transform(utf8.decoder).join();
    var userData = json.decode(responseData);

    if (mounted) {
      setState(() {
        collectionModal = ServiceCategoryModel.fromJson(userData);
      });
    }

    print(responseData);
    return null;
  }

}
