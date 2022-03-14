import 'package:flutter/material.dart';

class Active_Stock extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10),
      child: Column(
        children: [
          Card(
            elevation: 0,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.07,

              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Padding(
                          padding: const EdgeInsets.all(9.0),
                          child: Text(
                            "Burger",
                            style: TextStyle(
                                fontFamily: 'SFUIText-Regular',
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: Color(0xff2E3034)),
                          ),
                        ),
                      ),
                      Expanded(
                          flex: 1,
                          child: Text(
                            "14 menu",
                            style: TextStyle(
                                fontFamily: 'SFUIText-Regular',
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Color(0xffA4B0BE)),
                          )),
                      Expanded(
                          flex: 1,
                          child: Icon(Icons.keyboard_arrow_down_outlined))
                    ],
                  )
                ],
              ),
            ),
          ),

          Card(
            elevation: 0,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.07,
              margin: EdgeInsets.only(left: 10, right: 10),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Padding(
                          padding: const EdgeInsets.all(9.0),
                          child: Text(
                            "Drink",
                            style: TextStyle(
                                fontFamily: 'SFUIText-Regular',
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: Color(0xff2E3034)),
                          ),
                        ),
                      ),
                      Expanded(
                          flex: 1,
                          child: Text(
                            "14 menu",
                            style: TextStyle(
                                fontFamily: 'SFUIText-Regular',
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Color(0xffA4B0BE)),
                          )),
                      Expanded(
                          flex: 1,
                          child: Icon(Icons.keyboard_arrow_down_outlined))
                    ],
                  )
                ],
              ),
            ),
          ),

          Card(
            elevation: 0,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.07,
              margin: EdgeInsets.only(left: 10, right: 10),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Padding(
                          padding: const EdgeInsets.all(9.0),
                          child: Text(
                            "Shakes",
                            style: TextStyle(
                                fontFamily: 'SFUIText-Regular',
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: Color(0xff2E3034)),
                          ),
                        ),
                      ),
                      Expanded(
                          flex: 1,
                          child: Text(
                            "14 menu",
                            style: TextStyle(
                                fontFamily: 'SFUIText-Regular',
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Color(0xffA4B0BE)),
                          )),
                      Expanded(
                          flex: 1,
                          child: Icon(Icons.keyboard_arrow_down_outlined))
                    ],
                  )
                ],
              ),
            ),
          ),

          Card(
            elevation: 0,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.07,
              margin: EdgeInsets.only(left: 10, right: 10),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Padding(
                          padding: const EdgeInsets.all(9.0),
                          child: Text(
                            "Snacks",
                            style: TextStyle(
                                fontFamily: 'SFUIText-Regular',
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: Color(0xff2E3034)),
                          ),
                        ),
                      ),
                      Expanded(
                          flex: 1,
                          child: Text(
                            "14 menu",
                            style: TextStyle(
                                fontFamily: 'SFUIText-Regular',
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Color(0xffA4B0BE)),
                          )),
                      Expanded(
                          flex: 1,
                          child: Icon(Icons.keyboard_arrow_down_outlined))
                    ],
                  )
                ],
              ),
            ),
          ),
          Card(
            elevation: 0,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.07,
              margin: EdgeInsets.only(left: 10, right: 10),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Padding(
                          padding: const EdgeInsets.all(9.0),
                          child: Text(
                            "Pizza",
                            style: TextStyle(
                                fontFamily: 'SFUIText-Regular',
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: Color(0xff2E3034)),
                          ),
                        ),
                      ),
                      Expanded(
                          flex: 1,
                          child: Text(
                            "14 menu",
                            style: TextStyle(
                                fontFamily: 'SFUIText-Regular',
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Color(0xffA4B0BE)),
                          )),
                      Expanded(
                          flex: 1,
                          child: Icon(Icons.keyboard_arrow_down_outlined))
                    ],
                  )
                ],
              ),
            ),
          ),



        ],
      ),
    );
  }
}
