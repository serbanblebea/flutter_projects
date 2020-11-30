import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<FormState> _form = GlobalKey();
  final TextEditingController controller = TextEditingController();
  String message;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: const Text('Currency Converter'),
        centerTitle: true,
      ),
      body: Form(
        key: _form,
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Image.network(
                'https://lh3.googleusercontent.com/BeUE71bVNSFu-8D8XQpkGJuFMlvEcEp0z5hRd-PqDEiJd1ucpVkHF-6w5LTa0RTFZQ',
                height: 200,
                width: 200,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: TextFormField(
                controller: controller,
                keyboardType: const TextInputType.numberWithOptions(),
                decoration: const InputDecoration(
                  hintText: 'Enter the amount in EUR',
                ),
                validator: (String value) {
                  final double amount = double.tryParse(value);
                  if (amount == null) {
                    return 'Please enter a number';
                  }
                  return null;
                },
              ),
            ),
            RaisedButton(
              child: const Text('Convert'),
              onPressed: () {
                if (!_form.currentState.validate()) {
                  setState(() {
                    message = null;
                  });
                  return;
                }

                final double value = double.parse(controller.text.trim());

                setState(() {
                  message = '${(value * 4.8).toStringAsFixed(2)} RON';
                });
              },
            ),
            if (message != null)
              Text(
                message,
              )
          ],
        ),
      ),
    );
  }
}
