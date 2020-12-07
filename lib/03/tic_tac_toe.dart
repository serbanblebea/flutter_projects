import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(
        title: 'Tic Tac Toe',
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool redGreen = false;
  bool isPressed = false;
  bool gameOver = false;
  // ignore: always_specify_types
  Map<int, Color> myMap = {
    0: Colors.transparent,
    1: Colors.transparent,
    2: Colors.transparent,
    3: Colors.transparent,
    4: Colors.transparent,
    5: Colors.transparent,
    6: Colors.transparent,
    7: Colors.transparent,
    8: Colors.transparent,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
        ),
        backgroundColor: Colors.redAccent,
        centerTitle: true,
      ),
      body: GridView.builder(
        // or ListView.builder
        itemCount: 9, // without this line to make it infinite
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          // for the GridView only
          crossAxisCount: 3,
        ),
        itemBuilder: (BuildContext context, int index) {
          return AnimatedContainer(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black54,
              ),
              color: myMap[index],
            ),
            child: ListTile(
              onTap: () {
                setState(() {
                  myMap[index] = redGreen ? Colors.red : Colors.green;
                  redGreen = !redGreen;
                  if ((myMap[0] == Colors.red && myMap[1] == Colors.red && myMap[2] == Colors.red) ||
                      (myMap[0] == Colors.green && myMap[1] == Colors.green && myMap[2] == Colors.green)) {
                    gameOver = true;
                    myMap[3] = Colors.transparent;
                    myMap[4] = Colors.transparent;
                    myMap[5] = Colors.transparent;
                    myMap[6] = Colors.transparent;
                    myMap[7] = Colors.transparent;
                    myMap[8] = Colors.transparent;
                  } else if ((myMap[3] == Colors.red && myMap[4] == Colors.red && myMap[5] == Colors.red) ||
                      (myMap[3] == Colors.green && myMap[4] == Colors.green && myMap[5] == Colors.green)) {
                    gameOver = true;
                    myMap[0] = Colors.transparent;
                    myMap[1] = Colors.transparent;
                    myMap[2] = Colors.transparent;
                    myMap[6] = Colors.transparent;
                    myMap[7] = Colors.transparent;
                    myMap[8] = Colors.transparent;
                  } else if ((myMap[6] == Colors.red && myMap[7] == Colors.red && myMap[8] == Colors.red) ||
                      (myMap[6] == Colors.green && myMap[7] == Colors.green && myMap[8] == Colors.green)) {
                    gameOver = true;
                    myMap[0] = Colors.transparent;
                    myMap[1] = Colors.transparent;
                    myMap[2] = Colors.transparent;
                    myMap[3] = Colors.transparent;
                    myMap[4] = Colors.transparent;
                    myMap[5] = Colors.transparent;
                  } else if ((myMap[0] == Colors.red && myMap[3] == Colors.red && myMap[6] == Colors.red) ||
                      (myMap[0] == Colors.green && myMap[3] == Colors.green && myMap[6] == Colors.green)) {
                    gameOver = true;
                    myMap[1] = Colors.transparent;
                    myMap[2] = Colors.transparent;
                    myMap[4] = Colors.transparent;
                    myMap[5] = Colors.transparent;
                    myMap[7] = Colors.transparent;
                    myMap[8] = Colors.transparent;
                  } else if ((myMap[1] == Colors.red && myMap[4] == Colors.red && myMap[7] == Colors.red) ||
                      (myMap[1] == Colors.green && myMap[4] == Colors.green && myMap[7] == Colors.green)) {
                    gameOver = true;
                    myMap[0] = Colors.transparent;
                    myMap[2] = Colors.transparent;
                    myMap[3] = Colors.transparent;
                    myMap[5] = Colors.transparent;
                    myMap[6] = Colors.transparent;
                    myMap[8] = Colors.transparent;
                  } else if ((myMap[2] == Colors.red && myMap[5] == Colors.red && myMap[8] == Colors.red) ||
                      (myMap[2] == Colors.green && myMap[5] == Colors.green && myMap[8] == Colors.green)) {
                    gameOver = true;
                    myMap[0] = Colors.transparent;
                    myMap[1] = Colors.transparent;
                    myMap[3] = Colors.transparent;
                    myMap[4] = Colors.transparent;
                    myMap[6] = Colors.transparent;
                    myMap[7] = Colors.transparent;
                  } else if ((myMap[0] == Colors.red && myMap[4] == Colors.red && myMap[8] == Colors.red) ||
                      (myMap[0] == Colors.green && myMap[4] == Colors.green && myMap[8] == Colors.green)) {
                    gameOver = true;
                    myMap[1] = Colors.transparent;
                    myMap[2] = Colors.transparent;
                    myMap[3] = Colors.transparent;
                    myMap[5] = Colors.transparent;
                    myMap[6] = Colors.transparent;
                    myMap[7] = Colors.transparent;
                  } else if ((myMap[2] == Colors.red && myMap[4] == Colors.red && myMap[6] == Colors.red) ||
                      (myMap[2] == Colors.green && myMap[4] == Colors.green && myMap[6] == Colors.green)) {
                    gameOver = true;
                    myMap[0] = Colors.transparent;
                    myMap[1] = Colors.transparent;
                    myMap[3] = Colors.transparent;
                    myMap[5] = Colors.transparent;
                    myMap[7] = Colors.transparent;
                    myMap[8] = Colors.transparent;
                  }
                });
              },
            ),
            duration: const Duration(milliseconds: 300),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.refresh),
        backgroundColor: Colors.redAccent,
        onPressed: () {
          setState(
            () {
              myMap[0] = Colors.transparent;
              myMap[1] = Colors.transparent;
              myMap[2] = Colors.transparent;
              myMap[3] = Colors.transparent;
              myMap[4] = Colors.transparent;
              myMap[5] = Colors.transparent;
              myMap[6] = Colors.transparent;
              myMap[7] = Colors.transparent;
              myMap[8] = Colors.transparent;
              gameOver = false;
            },
          );
          return;
        },
      ),
    );
  }
}
