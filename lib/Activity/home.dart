import 'dart:convert';
import 'dart:math';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:weather_icons/weather_icons.dart';
import 'package:flutter_gradient_app_bar/flutter_gradient_app_bar.dart';
import 'package:weather_icons/weather_icons.dart';


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController searchController = new TextEditingController();
  @override
  void initState() {
    super.initState();
    print("This is a init state");
  }

  @override
  void setState(fn) {
    // TODO: implement setState
    super.setState(fn);
    print("Set state called");
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    print("Widget Destroyed");
  }

  @override
  Widget build(BuildContext context) {
    var city_name = ["Mumbai", "Delhi", "Chennai", "Dhar", "Indore", "London"];
    final _random = new Random();
    var city = city_name[_random.nextInt(city_name.length)];
    Map info = ModalRoute.of(context)?.settings.arguments as Map;
    String temp =  ((info['temp_value']).toString()).substring(0,4);
    String icon = info['icon_value'];
    String getcity = info['city_value'];
    String hum = info['hum_value'];
    String air = ((info['air_speed_value']).toString()).substring(0,4);
    String des = info['des_value'];



    return Scaffold(
      // appBar: PreferredSize(
      //   preferredSize: Size.fromHeight(0),
      //   child: AppBar(
      //     backgroundColor: Colors.blue,
      //   )
      // ),
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(0),
        child: GradientAppBar(
          gradient: LinearGradient(
              colors: [Colors.blue, Colors.blue[200] ?? Color(0xFF00FFFF)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter),
        ),
      ),
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [Colors.blue[800] ?? Color(0xFF00FFFF), Colors.blue[300] ?? Color(0xFF00FFFF)])),
          child: Column(
            children: [
              Container(
                //Search Wala Container

                padding: EdgeInsets.symmetric(horizontal: 8),
                margin: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24)),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, "/loading",arguments:{
                        "searchText" : searchController.text,
                        });

                      },
                      child: Container(
                        child: Icon(
                          Icons.search,
                          color: Colors.blueAccent,
                        ),
                        margin: EdgeInsets.fromLTRB(3, 0, 7, 0),
                      ),
                    ),
                    Expanded(
                      child: TextField(
                        controller: searchController,
                        decoration: InputDecoration(
                            border: InputBorder.none, hintText: "Search $city"),
                      ),
                    )
                  ],
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            color: Colors.white.withOpacity(0.5)),
                        margin: EdgeInsets.symmetric(horizontal: 25),
                        padding: EdgeInsets.all(26),
                        child: Wrap(
                             spacing:9.0 ,
                             runSpacing: 9.0,
                            children: [
                          Image.network("https://openweathermap.org/img/wn/$icon@2x.png"),
                          Column(
                            children: [
                              Text("$des",style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold
                              ),),
                              Text("In $getcity",style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold
                              ),)
                            ],
                          )
                        ])),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 160,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          color: Colors.white.withOpacity(0.5)),
                      margin:
                      EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                      padding: EdgeInsets.all(26),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(WeatherIcons.thermometer),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("$temp",style: TextStyle(
                                  fontSize: 60
                              ),),
                              Text("C",style: TextStyle(
                                  fontSize: 30
                              ),)
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          color: Colors.white.withOpacity(0.5)),
                      margin: EdgeInsets.fromLTRB(20, 0, 10, 0),
                      padding: EdgeInsets.all(26),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(WeatherIcons.windy)
                            ],
                          ),
                          SizedBox(height: 30,)
                          ,
                          Text("$air",
                            style: TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.bold
                          ),),
                          Text("km/hr")
                        ],
                      ),
                      height: 200,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          color: Colors.white.withOpacity(0.5)),
                      margin: EdgeInsets.fromLTRB(10, 0, 20, 0),
                      padding: EdgeInsets.all(26),
                      height: 200,
                      child:  Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(WeatherIcons.humidity)
                            ],
                          ),
                          SizedBox(height: 20,)
                          ,
                          Text("$hum",style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold
                          ),),
                          Text("Percent")
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text("Made By Dhruv"),
                    Text("Data Provided By Openweathermap.org")
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}