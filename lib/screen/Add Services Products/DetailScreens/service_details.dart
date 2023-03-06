import 'package:fixerking/utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fixerking/new model/vendor_services_model.dart';


class ServiceDetails extends StatefulWidget {
  final Products? model;
  const ServiceDetails({Key? key, this.model}) : super(key: key);

  @override
  State<ServiceDetails> createState() => _ServiceDetailsState();
}

class _ServiceDetailsState extends State<ServiceDetails> {
  Widget buildGridView() {
    return Expanded(
      // height: 165,
      child: GridView.builder(
        physics: NeverScrollableScrollPhysics(),
        itemCount: widget.model!.servicesImage!.length,
        gridDelegate:
        SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (BuildContext context, int index) {
          return Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15))
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(15)),
                child: Image.network(widget.model!.servicesImage![index].toString(),
                    fit: BoxFit.cover),
              ));
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor().colorPrimary(),
      // floatingActionButton: FloatingActionButton(onPressed: (){
      // Navigator.push(context, MaterialPageRoute(builder: (context) => AddService()));
      // },
      // // Icon(Icons.add,color: AppColor.PrimaryDark,),
      // //   backgroundColor: Colors.white,
      // ),
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: AppColor().colorPrimary(),
        title: Text(
          "Service Details",
          style: TextStyle(
            color: AppColor().colorBg1(),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(top: 5),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: AppColor().colorSecondary(),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(45),
                    topRight: Radius.circular(45),
                  )),
              child: Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: AppColor().colorBg1(),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(45),
                        topRight: Radius.circular(45),
                      )),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 30,left: 15, right: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Card(
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25)),
                          child: Container(
                            // padding: const EdgeInsets.all(10),
                            // only(left: 85, right: 20),
                            height: 190,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25)),
                            child: ClipRRect(
                              borderRadius: BorderRadius.all(Radius.circular(15)),
                              child: Image.network(
                                "${widget.model!.servicesImage![0].toString()}",
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        buildGridView(),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          "${widget.model!.artistName.toString()}",
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text("₹ ${widget.model!.mrpPrice}",
                          style: TextStyle(
                              decoration: TextDecoration.lineThrough
                          ),),
                        Text("₹ ${widget.model!.specialPrice}",
                          style: TextStyle(
                              color: AppColor.PrimaryDark,
                              fontSize: 14,
                              fontWeight: FontWeight.w600
                          ),),
                        SizedBox(
                          height: 20,
                        ),
                        Text("Descriptions",
                          style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w500
                          ),),
                        SizedBox(
                          height: 8,
                        ),
                        Text("${widget.model!.description!.toString()}",
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                          ),),
                        SizedBox(
                          height: 20,
                        ),



                      ],
                    ),
                  )
              ),


            ),
          ],
        ),
      ),

    );
  }
}
