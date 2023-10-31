import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyContainer(),
    );
  }
}

class MyContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Container Example'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset('assets/your_image.png'), // Replace 'your_image.png' with your image path
                SizedBox(height: 16.0),
                Text(
                  'Your Text Here',
                  style: TextStyle(fontSize: 20.0),
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    // Button action
                  },
                  child: Text('Button Text'),
                ),
                SizedBox(height: 16.0),
                IconButton(
                  icon: Icon(Icons.star),
                  onPressed: () {
                    // Icon button action
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
