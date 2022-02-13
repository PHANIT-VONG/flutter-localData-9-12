import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final key = 'key';
  double? value = 0.0;

  _saveData() async {
    final sp = await SharedPreferences.getInstance();
    sp.setDouble(key, 100.5);
    print('Data Saved');
  }

  _readData() async {
    final sp = await SharedPreferences.getInstance();
    setState(() {
      value = sp.getDouble(key);
    });
    print('Data Read Success');
  }

  @override
  void initState() {
    _readData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Local Data'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              value.toString(),
              style: Theme.of(context).textTheme.headline4,
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                _saveData();
                setState(() {
                  _readData();
                });
              },
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
