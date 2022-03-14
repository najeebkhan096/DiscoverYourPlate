import 'package:flutter/material.dart';

class Recomended_Product_Screen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.24,

      child: ListView.builder(itemBuilder: (ctx,index){
        return Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  margin: EdgeInsets.only(left: 15, top: 10),
                  width: MediaQuery.of(context).size.width * 0.38,
                  height: MediaQuery.of(context).size.height * 0.19,
                  padding: EdgeInsets.only(bottom: 21),
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: index==0?
                          NetworkImage(
                              "https://freepngimg.com/download/burger/4-2-burger-png-file.png"):
index==1?                          NetworkImage("https://img3.mashed.com/img/gallery/you-should-never-fold-pizza-slices-heres-why/l-intro-1602105889.jpg"): NetworkImage(
                              "https://tse3.mm.bing.net/th?id=OIP.B6btRLdkSmfIdxorrZw0GQHaHa&pid=Api&P=0&w=300&h=300"),
                          fit: BoxFit.fill),
                      borderRadius: BorderRadius.circular(10))),
              Container(
                margin: EdgeInsets.only(left: 15, top: 10),
                width: MediaQuery.of(context).size.width * 0.38,
                height: MediaQuery.of(context).size.height * 0.02,
                child: Padding(
                  padding: const EdgeInsets.only(left: 3),
                  child: index==0?Text(
                    "Burger",
                    style: TextStyle(
                      fontFamily: 'Proxima Nova Condensed Bold',
                      color: Color(0xff131010),
                      fontWeight: FontWeight.bold,
                    ),
                  ):index==1?Text(
                    "Pizza",
                    style: TextStyle(
                      fontFamily: 'Proxima Nova Condensed Bold',
                      color: Color(0xff131010),
                      fontWeight: FontWeight.bold,
                    ),
                  ):Text(
                    "Shakes",
                    style: TextStyle(
                      fontFamily: 'Proxima Nova Condensed Bold',
                      color: Color(0xff131010),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },

        itemCount: 3,
        scrollDirection: Axis.horizontal,

      )

    );
  }
}
