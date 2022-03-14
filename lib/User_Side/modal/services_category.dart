class Service_Category{

  String ? title;
 String ? service_doc_id;
 int ? count;
 Map<String,dynamic> ? unit_type;
 String ? Service_image_url;
 String ? recomended_img_url;
 List<double> ? feedback;
 double ? feedback_value;

 Service_Category({this.title,this.unit_type,this.service_doc_id,this.count,this.Service_image_url,this.recomended_img_url,this.feedback,this.feedback_value});

}


class Unit_Type_{
Map<String,dynamic> ? unit_type;

Unit_Type_({this.unit_type});


}
//

class Unit_Type_List{
  final Map<String,dynamic> ? unit_type_list;
  Unit_Type_List({this.unit_type_list});
}

class Unit_Type_Item{
    String ? title;
   String ? subtitle;
   String ? price;
  Unit_Type_Item({this.title,this.price,this.subtitle});
}
 List<Unit_Type_Item> unit_type_item_list=[];

List<Service_Category> suggestionlist=[];