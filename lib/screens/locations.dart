import 'package:flutter/material.dart';
import 'package:eighty7/API.dart';

class location extends StatefulWidget {
  const location({super.key});

  @override
  State<location> createState() => _locationState();
}

class _locationState extends State<location> {
  List<Time> locations =  [
    Time(location: "Delhi", url: "Asia/Kolkata"),
    Time(location: "London", url: "Europe/London"),
    Time(location: "Tokyo", url: "Asia/Tokyo"),
    Time(location: "Paris", url: "Europe/Paris"),
    Time(location: "Seoul", url: "Asia/Seoul"),
    Time(location: "Bangkok", url: "Asia/Bangkok"),
    Time(location: "Dubai", url: "Asia/Dubai"),
    Time(location: "New York", url: "America/New_York"),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFcfd8dc),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xFFcfd8dc),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.blue,
            size: 30,
          ),
        ),
        automaticallyImplyLeading: false,

      ),
      body: ListView.builder(
        itemCount: locations.length,
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, index){
          return Column(
            children: [
              Card(
                child:  ListTile(
                  onTap: () {
                    Navigator.pop(context,  {
                    'location' : locations[index].location,
                    'url': locations[index].url,
                    });
                  },
                  tileColor:  Color(0xFFcfd8dc),
                  title: Text(
                    locations[index].location,
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 28,
                    ),
                  ),
                ),
                elevation: 0,
              ),

            ],
          );
        }, //itemBuilder
      ),
    );
  }
}
