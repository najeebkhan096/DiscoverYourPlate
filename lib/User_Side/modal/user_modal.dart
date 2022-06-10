class MyUser {
  final String uid;
  final String  ?imageurl;
  final String ?username;
  MyUser(this.uid,this.imageurl,this.username);

}


String user_id='';
String username='';
String worker_cnic='';
String  worker_name='';



class User_Data{
  final String ? name;
  final String ? email;
  final String ? uid;
  final bool ? admin;
  final String ? phone;
  final String ? location;
  final String ? doc_id;
  final String ? imageurl;
  final double ? BMI;
  final double ? height;
  final double ? weight;
  final double ? age;
  String ? todaysteps;

  User_Data({this.name,this.email,this.uid,this.admin,this.phone,this.location,this.doc_id,this.imageurl,this.BMI,this.height,this.weight,this.age,this.todaysteps});

}


User_Data my_user_data=User_Data(name: '',admin: false,email: '',uid: '');
User_Data ? currentuser;
