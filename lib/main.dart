import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(
    const MaterialApp(
      home: MyScreen(),
    ),
  );
}

class MyScreen extends StatefulWidget {
  const MyScreen({super.key});

  @override
  State<MyScreen> createState() => _MyScreenState();
}

class _MyScreenState extends State<MyScreen> {
  String? name = 'No value Saved';
  TextEditingController nameController = TextEditingController();

  @override
  void initState() {
    getValue();
    super.initState();
  }

  Future<void> getValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    name = prefs.getString('myName');
    prefs.getBool('isUserLogin');
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Top 10 Flutter Widgets'),
        ),
        body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 20,
                left: 18,
                right: 18,
              ),
              child: TextFormField(
                controller: nameController,
                decoration: const InputDecoration(
                  hintText: 'Please Enter your Name',
                  labelText: "Name ",
                  prefixIcon: Icon(Icons.person),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black38),
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            //TODO: Save Button
            TextButton(
              onPressed: () async {
                print(nameController.text);
                SharedPreferences prefs = await SharedPreferences.getInstance();
                await prefs.setString('myName', nameController.text);
                await prefs.setBool('isUserLogin', true);
                print('successfully stored');
              },
              child: Container(
                height: 50,
                width: 300,
                margin: EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Colors.orange,
                  // border: Border.all(color: Colors.white, width: 3),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: const Center(
                  child: Text(
                    'Save',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
            // TextButton(
            //   onPressed: () async {
            //     SharedPreferences prefs = await SharedPreferences.getInstance();
            //     String? name = await prefs.getString('myName');
            //     print('Stored value: $name');
            //   },
            //   child: Container(
            //     height: 50,
            //     width: 300,
            //     margin: EdgeInsets.all(18),
            //     decoration: BoxDecoration(
            //       color: Colors.orange,
            //       // border: Border.all(color: Colors.white, width: 3),
            //       borderRadius: BorderRadius.circular(30),
            //     ),
            //     child: const Center(
            //       child: Text(
            //         'Get Stored value',
            //         style: TextStyle(color: Colors.white),
            //       ),
            //     ),
            //   ),
            // ),
            // TODO: Show Stored Value
            Center(
              child: Text(
                name ?? 'value is null',
                style: const TextStyle(fontSize: 24),
              ),
            ),
          ],
        ));
  }
}
