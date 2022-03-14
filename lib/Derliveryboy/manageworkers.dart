import 'package:discoveryourplate/Derliveryboy/addworker.dart';
import 'package:discoveryourplate/Derliveryboy/remove_worker.dart';
import 'package:discoveryourplate/Derliveryboy/view_worker.dart';
import 'package:flutter/material.dart';


class Manage_Worker_Screen extends StatelessWidget {
  static const routename = "Manage_Worker_Screen";
  @override

  final menu = [
    'View worker',
    'Remove worker',
    'Add worker'
  ];


  Widget build(BuildContext context) {


    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0XFF1e224c),
        appBar: AppBar(
          elevation: 0.3,
          backgroundColor: Color(0XFF1e224c),
          foregroundColor: Colors.black,
          iconTheme: IconThemeData(color: Colors.white),
          title: Row(
            children: [

              Text("Manage Delivery Boy",style: TextStyle(color: Colors.white),),

            ],
          ),
          centerTitle: true,
        ),

        body: Container(
          height: MediaQuery.of(context).size.height * 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  margin: EdgeInsets.only(top: 10,bottom: 10),
                  child: Text("",style:TextStyle(fontSize: 25),)),
              Container(

                height: MediaQuery.of(context).size.height * 0.8,
                child: GridView.builder(
                  itemBuilder: (ctx, index) {
                    return InkWell(
                        onTap: () {
                      if(index==0){
                        Navigator.of(context).pushNamed(View_worker.routename);
                      }
                      else if(index==1){
                        Navigator.of(context).pushNamed(Remove_worker.routename);
                      }
                      else if(index==2){
                        Navigator.of(context).pushNamed(Add_Worker_Screen.routename);
                      }

                        },
                        child: Card(
                          elevation: 0.5,
                          child: Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [

                                index==0? Icon(Icons.search,
                                    size: 50, color: Colors.lightBlue):index==1?Icon(Icons.remove,
                                    size: 50, color: Colors.lightBlue):

                                Icon(
                                    Icons.add,
                                    size: 50, color: Colors.lightBlue),
                                SizedBox(
                                  height: 15,
                                ),
                                Container(
                                    height: 35,
                                    width: 80,
                                    child: Text(
                                      menu[index],
                                      textAlign: TextAlign.center,
                                    ))
                              ],
                            ),
                          ),
                        ));
                  },
                  itemCount: menu.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 0,
                    mainAxisSpacing: 0,
                    mainAxisExtent: 160,
                    //emoji height
                  ),
                  padding: EdgeInsets.all(5),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
