import 'package:flutter/material.dart';
import 'package:meteo2/models/weather_model.dart';
import 'package:meteo2/services/weather_api_client.dart';
import 'package:meteo2/views/current_weather.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MeteoApp',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MeteoApp();
  }
}

class MeteoApp extends StatefulWidget {
  const MeteoApp({Key? key}) : super(key: key);

  @override
  State<MeteoApp> createState() => _MeteoAppState();
}

class _MeteoAppState extends State<MeteoApp> {
  WeatherApiClient client = WeatherApiClient();
  Weather? data;

  Future<void> getData() async {
    data = await client.getCurrentWeather("Georgia");
  }

  late TextEditingController controller;
  String ville = '';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = TextEditingController();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          elevation: 0.0,
          title: const Text(
            "App meteo",
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
        ),
        body: FutureBuilder(
            future: getData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        color: Colors.red,
                        width: 200,
                        height: 200,
                        child: Column(
                          children: [
                            currentWeather(Icons.wb_sunny, "${data!.temp}°C",
                                "${data!.cityName}"),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 200.0,
                      ),
                      Container(
                          padding: EdgeInsets.all(32),
                          child: ElevatedButton(
                            child:
                                Text('Cliquez ici pour rechercher une ville'),
                            onPressed: () async {
                              final ville = await OpenDialog();
                              if (ville == null || ville.isEmpty) return;
                              setState(() => this.ville = ville);
                            },
                          ))
                    ],
                  ),
                );
              }
              return Container();
            }));
  }

  Future<String?> OpenDialog() => showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
            title: Text('Ville'),
            content: TextField(
              autofocus: true,
              decoration: InputDecoration(hintText: 'Entrez une ville'),
            ),
            actions: [
              TextButton(
                child: Text('SUBMIT'),
                onPressed: submit,
              ),
            ],
          ));
  void submit() {
    Navigator.of(context).pop(controller.text);
  }
}
