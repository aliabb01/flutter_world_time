import 'package:flutter/material.dart';
import 'package:world_time/services/world_time.dart';

class ChooseLocation extends StatefulWidget {
  const ChooseLocation({Key? key}) : super(key: key);

  @override
  State<ChooseLocation> createState() => _ChooseLocationState();
}

class _ChooseLocationState extends State<ChooseLocation> {

  List<WorldTime> locations = [
    WorldTime(url: "Asia/Baku", location: "Baku", flag: "aze.png"),
    WorldTime(url: "Europe/Istanbul", location: "Istanbul", flag: "tr.png"),
    WorldTime(url: "Europe/London", location: "London", flag: "uk.png"),
    WorldTime(url: "America/New_York", location: "New York", flag: "usa.png"),
    WorldTime(url: "Asia/Seoul", location: "Seoul", flag: "south_korea.png"),
  ];

  void updateTime(index) async {
    WorldTime instance = locations[index];
    await instance.getTime();

    // navigate to home screen. Custom toMap() function
    Navigator.pop(context, instance.toMap());
  }

  @override
  Widget build(BuildContext context) {
    print("build state function ran");
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: Text("Choose a location"),
        centerTitle: true,
        elevation: 0,
      ),
      body: ListView.builder(
        itemCount: locations.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 1.0, horizontal: 4.0),
            child: Card(
              child: ListTile(
                onTap: () {
                  updateTime(index);
                },
                title: Text(locations[index].location),
                leading: CircleAvatar(
                  backgroundImage: AssetImage("assets/${locations[index].flag}"),
                ),
              ),
            ),
          );
        },
      ),
      backgroundColor: Colors.grey[200],
    );
  }
}
