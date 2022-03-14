import 'package:discoveryourplate/Restuarent_Side/widgets/Restuarent_bottom_navigation.dart';
import 'package:flutter/material.dart';


class Notification_Screen extends StatefulWidget {
  static const route="Notification_Screen";

  @override
  State<Notification_Screen> createState() => _Notification_ScreenState();
}

class _Notification_ScreenState extends State<Notification_Screen> {

  @override
  void initState() {
    // TODO: implement initState
    restuarent_current_index=2;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,


        title: Text(
          "Notifications",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('images/undraw_Notify_re_65on 1.png'),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
            ),
            Container(

              height: MediaQuery.of(context).size.height * 0.05,
              width: MediaQuery.of(context).size.width * 0.6,
              child: Text(
                "It seems like you don’t have any notifications yet. Check back later.",
                style: TextStyle(
                    color: Color(0xff242A37),
                    fontFamily: 'SFUIText-Regular',
                    fontWeight: FontWeight.w400,
                    fontSize: 15),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Restuarent_Bottom_Navigation_Bar(),
    );
  }
}
