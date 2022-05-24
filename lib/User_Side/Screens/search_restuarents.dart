import 'dart:convert';
import 'package:discoveryourplate/Restuarent_Side/modals/restuarent_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';


class Serach_Restuarents extends SearchDelegate<Restuarent_data>{
List<Restuarent_data> ?  suggestion2;
Serach_Restuarents({this.suggestion2});



  @override
  Widget buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return IconButton(onPressed: (){
      Navigator.of(context).pop();
    }, icon:Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults

    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Text("Search Restuarents"),
    );

  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    List<Restuarent_data> suggestionlist=suggestion2!.where((element) => element.name!.toLowerCase().startsWith(query)).toList();


    return suggestionlist.length<=0?SpinKitCircle(color: Colors.black,): ListView.builder(itemBuilder: (context,index){

      return Card(child: ListTile(
        onTap: ()async{
suggestion2=[];
          Navigator.pop(context,suggestionlist[index]);
        },
        leading: Icon(Icons.location_on),
        title: Text(suggestionlist[index].name.toString()),
        subtitle: Text(suggestionlist[index].location.toString()),
        trailing: Text(suggestionlist[index].distance.toString()+" KM"),

      ),
      );
    },
      itemCount: suggestionlist.length,
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    // TODO: implement buildActions
    return [IconButton(onPressed: (){
      query="";
    }, icon: Icon(Icons.clear))];
  }

}
