import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:discoveryourplate/User_Side/Screens/Home_screen.dart';
import 'package:discoveryourplate/User_Side/modal/user_modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
class Feedback_Screen extends StatelessWidget {
 static const routename="Feedback_Screen";

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        foregroundColor: Colors.black,
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text("Feedback",style: TextStyle(color: Colors.black),),
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('Restuarents').snapshots(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting)
              return SpinKitCircle(
                color: Colors.black,
              );
            if (!snapshot.hasData) return const Text('Loading...');
            print("janu"+selected_restuarent!.id.toString());
            List<QueryDocumentSnapshot> precist = snapshot.data!.docs
                .where((element) => (element.id == selected_restuarent!.id.toString()))
                .toList();
            final int messageCount = precist.length;
            final DocumentSnapshot document = precist[0];
            List<dynamic> feedback=[];
            try{
            feedback =document['feedback'];
              print("precist is "+document['feedback'].toString());
            }catch(error){

            }



            return
              precist.length==0?
              Container(
                  margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.45,top: MediaQuery.of(context).size.height*0.2),
                  child: Text("No Order",style: TextStyle(
                      fontSize: 18
                  ),))
                  :
              ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                physics: BouncingScrollPhysics(),
                itemCount: feedback.length,
                itemBuilder: (_, int index) {


                  return  Container(
                    margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.025),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                          leading:

                    (feedback[index]['userimage']==null || feedback[index]['userimage'].toString()==null)?
                          CircleAvatar(
                            radius: 20,
                            backgroundImage: NetworkImage(
                                feedback[index]['userimage'].toString()),
                          ): CircleAvatar(
                    radius: 20,
                   child: Text("No Image",style: TextStyle(fontSize: 8),),
                  ),
                          title: Text(
                            feedback[index]['email'].toString(),
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Color.fromRGBO(64, 64, 64, 1),
                                fontSize: 15,
                                fontFamily: 'Inter-Bold'),
                          ),

                        ),
                        SizedBox(height: MediaQuery.of(context).size.height*0.01),
                        Container(

                            margin: EdgeInsets.only(
                  left: MediaQuery.of(context).size.height*0.05,
                  right: MediaQuery.of(context).size.height*0.05),
                            padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.height*0.05,
                  right: MediaQuery.of(context).size.height*0.05),


                            child: Text( feedback[index]['text'].toString()))

                      ],
                    ),
                  );

                },
              );

          }),
    );

      ListView(
      children: [
        ListTile(
          leading: CircleAvatar(
            radius: 30,
            backgroundImage: NetworkImage(
                "https://tse2.mm.bing.net/th?id=OIP.SYIBNg9Pmpcp8ebumL-aagHaFj&pid=Api&P=0&w=243&h=182"),
          ),
          title: Text(
            "Savannah Nguyen",
            style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Color.fromRGBO(64, 64, 64, 1),
                fontSize: 15,
                fontFamily: 'Inter-Bold'),
          ),
          subtitle: Text(
            "October 2021",
            style: TextStyle(
                color: Color.fromRGBO(107, 107, 117, 1),
                fontWeight: FontWeight.w400,
                fontSize: 14,
                fontFamily: 'Inter-Light'),
          ),
        ),
      ],
    );
  }
}
