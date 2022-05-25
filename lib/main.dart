import 'package:camera/camera.dart';
import 'package:discoveryourplate/Chat/chatscreen.dart';
import 'package:discoveryourplate/Chat/conversation.dart';
import 'package:discoveryourplate/Derliveryboy/HomePage/worker_login.dart';
import 'package:discoveryourplate/Derliveryboy/HomePage/worker_orders_status.dart';
import 'package:discoveryourplate/Derliveryboy/addworker.dart';
import 'package:discoveryourplate/Derliveryboy/manageworkers.dart';
import 'package:discoveryourplate/Derliveryboy/remove_worker.dart';
import 'package:discoveryourplate/Derliveryboy/view_worker.dart';
import 'package:discoveryourplate/LiveDetection.dart';
import 'package:discoveryourplate/Restuarent_Side/screens/Admin_Orders_Screen.dart';
import 'package:discoveryourplate/Restuarent_Side/screens/Restuarent_Dashboard.dart';
import 'package:discoveryourplate/Restuarent_Side/screens/menu_screen.dart';
import 'package:discoveryourplate/Restuarent_Side/screens/notification_screen.dart';
import 'package:discoveryourplate/Restuarent_Side/screens/restuarent_profile.dart';
import 'package:discoveryourplate/Restuarent_Side/screens/stock_screen.dart';
import 'package:discoveryourplate/BMI/BMI.dart';
import 'package:discoveryourplate/User_Side/Screens/cart_screen.dart';
import 'package:discoveryourplate/User_Side/Screens/category_screen.dart';
import 'package:discoveryourplate/User_Side/Screens/feedback.dart';
import 'package:discoveryourplate/User_Side/Screens/image_classification.dart';
import 'package:discoveryourplate/User_Side/Screens/tourust_products.dart';
import 'package:discoveryourplate/User_Side/Screens/user_profile.dart';
import 'package:discoveryourplate/home.dart';
import 'package:discoveryourplate/hybrid_screens/auth.dart';
import 'package:discoveryourplate/hybrid_screens/wrapper.dart';
import 'package:discoveryourplate/ui/home_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:discoveryourplate/User_Side/Screens/Home_screen.dart';
import 'package:discoveryourplate/User_Side/Screens/user_order_screen.dart';
import 'package:discoveryourplate/User_Side/Screens/Edit_Profile_Screen.dart';
import 'package:discoveryourplate/hybrid_screens/Email_screen.dart';
import 'package:discoveryourplate/hybrid_screens/enter_new_password.dart';
import 'package:discoveryourplate/hybrid_screens/sign_in_screen.dart';
import 'package:discoveryourplate/hybrid_screens/sign_up_screen.dart';
import 'package:discoveryourplate/hybrid_screens/otp_screen.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:provider/provider.dart';

List<CameraDescription>? cameras=[];

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  Stripe.publishableKey = 'pk_test_51K1GtiD5z0PA4b4fVeiLsLZeybhP8WNeFOf4If4PMWgTDVhAlHR3C1h2i9IeVRl0yWjUDmrccpgR3Is3qjKYNcG700YBFcIehs';

  await Stripe.instance.applySettings();
  cameras=await availableCameras();
  runApp(MyApp());


}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  Future<Future<bool?>> _showErrorDialog(BuildContext context) async=> showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Alert'),
        content: Text("Do yoy want to Exit?"),
        actions: <Widget>[
          ElevatedButton(
              onPressed: ()=>Navigator.pop(context,false), child: Text("No")),
          ElevatedButton(
              onPressed: ()=>Navigator.pop(context,true), child: Text("Yes")),

        ],
      ));

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          Provider<AuthService>(create: (_)=>AuthService()),
        ],

      child: MaterialApp(
        home: WillPopScope(

            onWillPop: ()async{
              bool  data=(await _showErrorDialog(context)) as bool;
              return data;

              },
            child: HomePage(cameras!)),

        routes: {
          'Chat_Screen':(context)=>Chat_Screen(),
          'Conversation':(context)=>Conversation(),
          'CalculateBMI':(context)=>CalculateBMI(),
          'Tourist_Products_Screen':(context)=>Tourist_Products_Screen(),
          'ImageClassification':(context)=>ImageClassification(),
          'Feedback_Screen':(context)=>Feedback_Screen(),
          'Worker_Log_in_Screen':(context)=>Worker_Log_in_Screen(),
          'Worker_Order_Status_Screen':(context)=>Worker_Order_Status_Screen(),
            'Manage_Worker_Screen':(context)=>Manage_Worker_Screen(),
            'Remove_worker':(context)=>Remove_worker(),
          'View_worker':(context)=>View_worker(),
          'Add_Worker_Screen':(context)=>Add_Worker_Screen(),
          'Edit_profile_Screen':(context)=>Edit_profile_Screen(),
          'Sign_In_Screen':(context)=>Sign_In_Screen(),
          'Sign_up_Screen':(context)=>Sign_up_Screen(),
          'otp_screen':(context)=>OTP_Screen(),
          'Edit_profile_Screen':(context)=>Edit_profile_Screen(),
          'enter_email_screen':(context)=>Email_Screen(),
          'enter_password_screen':(context)=>Enter_new_password(),
          'home_screen':(context)=>Home_Screen(),
          'User_Order_Screen':(context)=>User_Order_Screen(),
          'Stock_Screen':(context)=>Stock_Screen(),
          'Restuarent_Dashboard':(context)=>Restuarent_Dashboard(),
          'Restuarent_Profile_screen':(context)=>Restuarent_Profile_screen(),
          'Notification_Screen':(context)=>Notification_Screen(),
          'Admin_Order_Screen':(context)=>Admin_Order_Screen(),
          'Menu_Screen':(context)=>Menu_Screen(),
          'Wrapper':(context)=>Wrapper(),
          'Category_Screen':(context)=>Category_Screen(),
          'Cart_Screen':(context)=>Cart_Screen(),

          'User_Profile_Screen':(context)=>User_Profile_Screen()

        },
      ),
    );
  }
}