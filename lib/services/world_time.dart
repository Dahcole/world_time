import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime{
  String location; // Location name for the UI
  String time; // The time in that location
  String flag; // URL to an asset flag icon
  String url; // Location URL for api endpoint
  bool isDaytime; // True or false if daytime or not


  WorldTime({ this.location, this.flag, this.url });

  Future <void> getTime() async {

    try {
      //make the request
      Response response = await get("http://worldtimeapi.org/api/timezone/$url");
      Map data = jsonDecode(response.body);
      //print(data);

      // get properties from data
      String datetime = data["datetime"];
      String offset =data["utc_offset"].substring(1,3);
      // print(datetime);
      // print(offset);

      // create DateTime object
      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours: int.parse(offset)));

      // Set the time property
      isDaytime =  now.hour > 6 && now.hour < 19 ? true : false;
      time = DateFormat.jm().format(now);
    }
    catch (e) {
      print("Caught error: $e");
      time = "Could not get time data";
    }
  }
}