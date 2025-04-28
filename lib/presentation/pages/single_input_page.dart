import 'package:flutter/material.dart';

class SingleInputPage extends StatefulWidget {
  const SingleInputPage({super.key});

  @override
  State<SingleInputPage> createState() => _SingleInputPageState();
}

class _SingleInputPageState extends State<SingleInputPage> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Enter a value',
                border: OutlineInputBorder(),
                hintText: "Enter a value",
              ),
              controller: _controller,
              keyboardType: TextInputType.number,
            ),
            TextButton(
                onPressed: () {
                  var doubleValue = double.tryParse(_controller.text);
                  if (doubleValue == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Please enter a valid number"),
                      ),
                    );
                  } else {
                    Navigator.pop(context, doubleValue);
                  }
                },
                child: Text("Procede"))
          ],
        ),
      ),
    );
  }
}
