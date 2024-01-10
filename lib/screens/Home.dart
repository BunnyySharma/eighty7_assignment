import 'dart:async';
import 'package:eighty7/screens/locations.dart';
import 'package:flutter/material.dart';
import 'package:eighty7/API.dart';
class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Time inst;
  late StreamController<Time> _timeStreamController;
  late Stream<Time> timeStream;
  String url = 'Europe/London';
  @override
  void initState() {
    super.initState();
    inst = Time(location: "London", url: url);
    _timeStreamController = StreamController<Time>();
    timeStream = _timeStreamController.stream;

    // Periodically update the time and add it to the stream
    Timer.periodic(const Duration(seconds: 2), (timer) async {
      await inst.getTime();
      _timeStreamController.add(inst);
    });

    // Initial update and add to the stream
    inst.getTime();
    _timeStreamController.add(inst);
  }

  @override
  void dispose() {
    _timeStreamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFcfd8dc),
      body: SafeArea(
        child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: StreamBuilder<Time>(
              stream: timeStream,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting || snapshot.data == null) {
                  // Display a loading indicator while data is being loaded
                  return CircularProgressIndicator();
                }
                else if (snapshot.hasData) {
                  Time timeData = snapshot.data!;
                  return Stack(
                    children: [
                    timeData.isDaytime? Image.asset(
                        'assets/sun-50.png',
                      opacity: AlwaysStoppedAnimation(0.5),
                    ) :  Transform.scale(
                        scale: 0.7,
                        child: Image.asset(
                          'assets/moon.png',
                          opacity: AlwaysStoppedAnimation(0.5),
                        ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: Text(
                            '${timeData.Date}',
                            style: TextStyle(
                                fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        SizedBox(height: 10,),
                        Text(
                          '${timeData.time}',
                          style: TextStyle(fontSize: 70),
                        ),
                        SizedBox(height: 20,),
                        Text(
                          '${timeData.location}',
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                ]
                  );
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  return CircularProgressIndicator();
                }
              },
            ),
          ),
          TextButton(
              onPressed: () async{
                dynamic result = await Navigator.pushNamed(context, '/location');
                if(result != null){
                  Time temp = await Time(location: result['location'], url: result['url']);
                  setState(() {
                    inst = temp;
                  });
                }
              },
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.assistant_navigation,
                    size: 30,
                  ),
                  SizedBox(width: 8),
                  Text("Select Other Timezones.",
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  )
                ],
              )
          ),
        ],
          ),
      ),
    );
  }
}
