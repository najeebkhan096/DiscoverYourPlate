import 'package:flutter/material.dart';
class Non_Active extends StatelessWidget {
  List url = [
    'https://foodnerd.s3.eu-west-1.amazonaws.com/production/blog/cover_image/5/foodnerd-pizza-restaurants-islamabad-food.jpg',

    'https://www.smartertravel.com/wp-content/uploads/2020/03/purple-carrot-hero.jpg',
    'https://foodnerd.s3.eu-west-1.amazonaws.com/production/blog/cover_image/5/foodnerd-pizza-restaurants-islamabad-food.jpg',

    'https://foodnerd.s3.eu-west-1.amazonaws.com/production/blog/cover_image/5/foodnerd-pizza-restaurants-islamabad-food.jpg',

  ];
  @override
  Widget build(BuildContext context) {
    return  Expanded(
      child: Container(
        margin: EdgeInsets.only(left: 10),
        child: Column(
crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    margin: EdgeInsets.only(left: 10),
                    child: Text(
                      "Burger",
                      style:  TextStyle(
                          fontFamily: 'SFUIText-Regular',
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Color(0xff2E3034))
                    ),),
                Container(
                  margin: EdgeInsets.only(right: 20),
                  child: Text("14 Menu"),
                )
              ],
            ),
            SizedBox(height: MediaQuery.of(context).size.height*0.02,),
            Expanded(
              child: Card(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemBuilder: (ctx, index) {
                    return Container(
                      margin: EdgeInsets.only(left: 10),
                      height: MediaQuery.of(context).size.height * 0.15,
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(6),
                            child: Container(
                              color: Colors.blue,
                              height:
                              MediaQuery.of(context).size.height * 0.08,
                              width:
                              MediaQuery.of(context).size.width * 0.15,
                              child: FittedBox(
                                  fit: BoxFit.fill,
                                  child: Image.network(url[index])),
                            ),
                          ),
                          SizedBox(
                            width:
                            MediaQuery.of(context).size.width * 0.025,
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height * 1,
                            width: MediaQuery.of(context).size.width * 0.4,
                            child: FittedBox(
                              fit: BoxFit.contain,
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  index==0?Text(
                                      " Burger",
                                      style: TextStyle(
                                          fontFamily: 'SFUIText-Regular',
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700,
                                          color: Color(0xff2E3034))
                                  ):index==1?Text(
                                      "cheese Burger",
                                      style: TextStyle(
                                          fontFamily: 'SFUIText-Regular',
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700,
                                          color: Color(0xff2E3034))
                                  ):Text(
                                      "pineapple Burger",
                                      style: TextStyle(
                                          fontFamily: 'SFUIText-Regular',
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700,
                                          color: Color(0xff2E3034))
                                  ),
                                  SizedBox(
                                    height:
                                    MediaQuery.of(context).size.height *
                                        0.01,
                                  ),
                                  Text(
                                    "Always a picnic favourite",
                                    style: TextStyle(
                                      fontFamily:
                                      'Proxima Nova Alt Regular.otf',
                                      color: Color(0xff131010),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            width:
                            MediaQuery.of(context).size.width * 0.25,
                          ),
                          Icon(Icons.more_vert,color: Color(0xffE5E5E5),)
                        ],
                      ),
                    );
                  },
                  itemCount: url.length,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
