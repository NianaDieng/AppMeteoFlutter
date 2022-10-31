import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

class NewVille extends StatefulWidget {
  String ville;
  NewVille(this.ville);

  @override
  State<NewVille> createState() => _NewVilleState();
}

class _NewVilleState extends State<NewVille> {
  var weatherData;

  @override
  void initState() {
    super.initState();
    getData(widget.ville);
  }

  getData(String city) {
    var url = Uri.parse(
        "https://api.openweathermap.org/data/2.5/weather?q=$city&appid=1ff64c39efa9435ba054d2e67c8171b3&units=metric");
    http.get(url).then((res) {
      setState(() {
        this.weatherData = jsonDecode(res.body);
        print(weatherData);
      });
    }).catchError((err) {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Meteo de la ville de ${widget.ville}"),
          backgroundColor: Colors.blue,
        ),
        body: (weatherData == null
            ? Center(child: CircularProgressIndicator())
            : Card(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CircleAvatar(
                      backgroundImage: AssetImage('assets/meteo.png'),
                    ),
                    Text(
                        "${new DateFormat('HH:mm').format(DateTime.fromMicrosecondsSinceEpoch(weatherData['dt'] * 1000000))}",
                        style:
                            TextStyle(fontSize: 25, color: Colors.redAccent)),
                    Text(
                      "${weatherData['main']['temp'].round()} °C",
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.blueGrey,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "${weatherData['main']['humidity']} 💦",
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.blueGrey,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              )));
  }
}
