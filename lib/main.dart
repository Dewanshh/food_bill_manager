import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Utility Tracker'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  var num = 0;
  var num2 = 0;

  void initState() {
    // TODO: implement initState
    FirebaseFirestore.instance
        .collection('breakfast')
        .doc('break')
        .snapshots()
        .listen((event) {
      setState(() {
        num = event['breakfast'];
      });
      FirebaseFirestore.instance
          .collection('dinner')
          .doc('dine')
          .snapshots()
          .listen((event) {
        setState(() {
          num2 = event['dinner'];
        });

        super.initState();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: <Widget>[
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Text("Breakfast: ",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 24)),
                ]),
                Text("Times: ${num.toString()}",
                    style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                        fontSize: 20)),
                SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(primary: Colors.black),
                      child: Icon(Icons.add),
                      onPressed: () {
                        setState(() {
                          num += 1;
                        });
                        FirebaseFirestore.instance
                            .collection('breakfast')
                            .doc('break')
                            .update({'breakfast': num});
                      },
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(primary: Colors.black),
                      child: Icon(Icons.remove),
                      onPressed: () {
                        setState(() {
                          num -= 1;
                        });
                        FirebaseFirestore.instance
                            .collection('breakfast')
                            .doc('break')
                            .update({'breakfast': num});
                      },
                    )
                  ],
                )
              ],
            ),
            SizedBox(
              height: 40,
            ),
            Column(
              children: <Widget>[
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Text("Dinner: ",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 24)),
                ]),
                Text("Times: ${num2.toString()}",
                    style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                        fontSize: 20)),
                SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(primary: Colors.black),
                      child: Icon(Icons.add),
                      onPressed: () {
                        setState(() {
                          num2 += 1;
                        });
                        FirebaseFirestore.instance
                            .collection('dinner')
                            .doc('dine')
                            .update({'dinner': num2});
                      },
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(primary: Colors.black),
                      child: Icon(Icons.remove),
                      onPressed: () {
                        setState(() {
                          num2 -= 1;
                        });
                        FirebaseFirestore.instance
                            .collection('dinner')
                            .doc('dine')
                            .update({'dinner': num2});
                      },
                    )
                  ],
                ),
                SizedBox(
                  height: 50,
                ),
                Container(
                  child: Column(
                    children: [
                      RichText(
                        text: TextSpan(
                            text: "Breakfast Total:",
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                            children: [
                              TextSpan(
                                  text: " Rs.${num * 50}",
                                  style: TextStyle(
                                      color: num * 50 > 0
                                          ? Colors.teal
                                          : Colors.red,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold))
                            ]),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      RichText(
                        text: TextSpan(
                            text: "Dinner Total:",
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                            children: [
                              TextSpan(
                                  text: " Rs.${num2 * 60}",
                                  style: TextStyle(
                                      color: num2 * 60 > 0
                                          ? Colors.teal
                                          : Colors.red,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold))
                            ]),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      RichText(
                        text: TextSpan(
                            text: "Monthly Total:",
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                            children: [
                              TextSpan(
                                  text: " Rs.${num * 50 + num2 * 60}",
                                  style: TextStyle(
                                      color: (num * 50 + num2 * 60) > 0
                                          ? Colors.teal
                                          : Colors.red,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold))
                            ]),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      ElevatedButton(
                        child: Text(
                          "Reset",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        style: ElevatedButton.styleFrom(primary: Colors.black),
                        onPressed: () async {
                          final id = await FirebaseFirestore.instance
                              .collection('history')
                              .doc()
                              .id;
                          await FirebaseFirestore.instance
                              .collection("history")
                              .doc(id)
                              .set({
                            "breakfast_no": num,
                            "dinner_no": num2,
                            "breakfast_cash": num * 50,
                            "dinner_cash": num2 * 60,
                            "total": num * 50 + num2 * 60,
                            "timestamp": DateTime.now()
                          });
                          FirebaseFirestore.instance
                              .collection('breakfast')
                              .doc('break')
                              .update({'breakfast': 0});
                          FirebaseFirestore.instance
                              .collection('dinner')
                              .doc('dine')
                              .update({'dinner': 0});
                        },
                      )
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
