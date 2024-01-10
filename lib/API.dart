import "package:http/http.dart" as http;
import "dart:convert";
import 'package:intl/intl.dart';
import 'dart:async';

class Time{
  String url="";

  String location="";
  String time="";
  String Date="";
  bool isDaytime= false;

  Time({required this.location, required this.url});
  Future<void> getTime() async{
    try{
      http.Response response = await http.get(Uri.parse("https://worldtimeapi.org/api/timezone/$url"));
      String jsondata = response.body;
      Map<String, dynamic> data = jsonDecode(jsondata);
      String dt = data['datetime'];
      //Removing the offset to input current time
      DateTime now = DateTime.parse(dt.substring(0,25));
      isDaytime = now.hour > 6 && now.hour < 20 ? true : false;
      time = DateFormat.jm().format(now);
      Date = DateFormat('dd MMMM, yyyy').format(now);
      print(time);
    }
    catch(e){
      print("Error: $e");
      Date= "Connectivity issue";
    }
  }
}