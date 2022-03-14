class item_Data{
  final String ? title;
  final  String ? subtitle;
  bool ? status;
  String ? service_title;
  final double price;
  double ? total_price;
  int  quantity;
  final String ? service_doc_id;
  final int ? service_count;
  item_Data({this.title,this.subtitle,required this.price,this.status,this.total_price,required this.quantity,this.service_title,required this.service_doc_id,required this.service_count});

}