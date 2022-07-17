import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {

  String location; // location name for the UI
  String time=""; // time in that location
  String flag; // url to an asset flag icon
  String url; // location url for api endpoint
  bool? isDaytime; // true or false if daytime or not

  WorldTime({ required this.location, required this.flag, required this.url });

  Future<void> getTime() async {

    try {
      // make the request
      Response response = await get(Uri.parse("http://worldtimeapi.org/api/timezone/$url"));
      Map data = jsonDecode(response.body);

      // print(data);

      // get properties from data
      String dateTime = data["datetime"];
      String offset = data["utc_offset"].substring(1, 3);

      // print(dateTime);
      // print(offset);

      // create DateTime object
      DateTime now = DateTime.parse(dateTime);
      now = now.add(Duration(hours: int.parse(offset)));

      // set the time property
      isDaytime = now.hour > 6 && now.hour < 20 ? true : false;
      time = DateFormat.jm().format(now);
    }
    catch (e) {
      print("Caught error: $e");
      time="Could not get time data";
    }


  }

  // Method to turn WorldTime instance to Map
  Map<String, dynamic> toMap() {
    return {
      'location': location,
      'time': time,
      'flag': flag,
      'isDaytime': isDaytime
    };
  }

}