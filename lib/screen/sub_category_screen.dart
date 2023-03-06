import 'dart:convert';
import 'package:fixerking/utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../api/api_path.dart';
import '../modal/ServiceSubCategoryModel.dart';

class SubCategoryScreen extends StatefulWidget {
  final name, id;
  const SubCategoryScreen({Key? key, this.name, this.id}) : super(key: key);

  @override
  State<SubCategoryScreen> createState() => _SubCategoryScreenState();
}

class _SubCategoryScreenState extends State<SubCategoryScreen> {
  ServiceSubCategoryModel? collectionModal;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getServicesSubCategory(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColor.PrimaryDark,
          elevation: 0,
          // bottom:
          title: Text(
            widget.name!.toUpperCase(),
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: collectionModal == null
            ? Center(
          child: CupertinoActivityIndicator(),
        )
            : Padding(
          padding: const EdgeInsets.only(top: 20),
          child: bestSellerItems(context),
        )
    );
  }

  Widget bestSellerItems(BuildContext context) {
    return collectionModal!.responseCode == "1"
        ? GridView.builder(
      shrinkWrap: true,
      primary: false,
      padding: EdgeInsets.all(10),
      itemCount: collectionModal!.data!.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 250 / 290,
      ),
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 30),
          child: InkWell(
            onTap: () {
              // Navigator.push(
              //   context,
              //   CupertinoPageRoute(
              //     builder: (context) => ViewCategory(
              //       id: collectionModal!.categories![index].id,
              //       name: collectionModal!.categories![index].cName!,
              //       catId: widget.id,
              //       fromSeller: false,
              //     ),
              //   ),
              // );
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Container(
                      width: 180,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            bottom: 15, left: 15, right: 5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              collectionModal!.data![index].cName!,
                              maxLines: 1,
                              style: TextStyle(
                                  color: AppColor.PrimaryDark,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            ),
                            Container(height: 10),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 100,
                    width: 140,
                    alignment: Alignment.topCenter,
                    decoration: BoxDecoration(
                      color: Colors.black45,
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        image: NetworkImage(collectionModal!.data![index].img!),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    )
        : Center(
      child: Text(
        "No Sub Category Available",
        style: TextStyle(
          color: Colors.black,
          fontStyle: FontStyle.italic,
        ),
      ),
    );
  }

  Future<ServiceSubCategoryModel?> getServicesSubCategory(catId) async {
    var uri = Uri.parse('${Apipath.BASH_URL}get_categories_list');
    var request = new http.MultipartRequest("POST", uri);
    Map<String, String> headers = {
      "Accept": "application/json",
    };

    print(uri.toString());
    request.headers.addAll(headers);
    request.fields['p_id'] = catId;
    var response = await request.send();
    print(response.statusCode);
    String responseData = await response.stream.transform(utf8.decoder).join();
    var userData = json.decode(responseData);

    if (mounted) {
      setState(() {
        collectionModal = ServiceSubCategoryModel.fromJson(userData);
      });
    }
    print(responseData);
    return null;
  }
}
