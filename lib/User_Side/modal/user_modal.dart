class MyUser {
  final String uid;
  MyUser(this.uid);

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

  User_Data({this.name,this.email,this.uid,this.admin,this.phone,this.location,this.doc_id,this.imageurl});

}
User_Data my_user_data=User_Data(name: '',admin: false,email: '',uid: '');
