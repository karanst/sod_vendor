import 'dart:convert';

import 'package:fixerking/api/api_path.dart';
import 'package:fixerking/modal/purchase_plan_history_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../token/app_token_data.dart';
import '../token/token_string.dart';
import '../utils/colors.dart';

class PlanHistory extends StatefulWidget {
  const PlanHistory({Key? key}) : super(key: key);

  @override
  State<PlanHistory> createState() => _PlanHistoryState();
}

class _PlanHistoryState extends State<PlanHistory> {
  var planStatus;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColor.PrimaryDark,
        title: Text("Purchase Plan History"),
      ),
      body: FutureBuilder(
          future: getMyPlan(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              PurchasePlanHistoryModel his = snapshot.data;
              return his.responseCode == "1"
                  ? ListView.builder(
                itemCount: his.data!.length,
                itemBuilder: (BuildContext context, int index) {

                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)
                      ),
                      child: Column(
                        children: [
                          ListTile(
                            title: Text("${his.data![index].title}"),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 5.0,),
                                Text("Description: ${his.data![index].description}"),
                                SizedBox(height: 5.0,),
                                Text("Expiry Date: ${his.data![index].lastDate}"),
                                SizedBox(height: 5.0,),
                                Text("₹ ${his.data![index].price}"),
                              ],
                            ),
                            trailing: Text("${his.data![index].tStatus}", style: TextStyle(color: Colors.green),),
                          ),
                          Wrap(children: [
                            Chip(
                                backgroundColor: AppColor().colorPrimary(),
                                label: Text("Purchase Date: ${his.data![index].startDate}" , style: TextStyle(color: Colors.white),)),
                          ],)
                        ],
                      ),
                    ),
                  );
                },
              )
                  : Center(child: Text("No Any Purchase Plan"),);
            } else if (snapshot.hasError) {
              return Icon(Icons.error_outline);
            } else {
              return Center(child: Image.asset("images/icons/loader.gif"))
              ;
            }
          }),
    );
  }

  Future getMyPlan() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var userId = await MyToken.getUserID();
    var request = http.MultipartRequest('POST', Uri.parse('${Apipath.BASH_URL}my_plans'));
    request.fields.addAll({
      'user_id': '$userId'
    });

    print(request);
    print(request.fields);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      final str = await response.stream.bytesToString();
      return PurchasePlanHistoryModel.fromJson(json.decode(str));
    }
    else {
      return null;
    }
  }

}
