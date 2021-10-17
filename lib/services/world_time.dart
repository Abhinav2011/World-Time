import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {
  String location; // location name for the UI
  String time = ""; //time in that location
  String flag; //URL to asset flag icon
  String url; //location URL for API endpoints
  bool isDaytime = false; //true or false if day time or not
  WorldTime({required this.location, required this.flag, required this.url});

  Future<void> getTime() async {
    try {
      Response response =
          await get(Uri.parse('http://worldtimeapi.org/api/timezone/$url'));
      Map data = jsonDecode(response.body);

      //get properties from data
      String datetime = data['datetime'];
      String offset = data['utc_offset'].substring(1, 3);

      //create a datetime object
      DateTime current = DateTime.parse(datetime);
      current = current.add(Duration(hours: int.parse(offset)));
      //print(current);

      //set the time value
      isDaytime = current.hour > 6 && current.hour < 18 ? true : false;
      time = DateFormat.jm().format(current);
    } catch (e) {
      print(e);
      time = 'could not get time data';
    }
  }
}
