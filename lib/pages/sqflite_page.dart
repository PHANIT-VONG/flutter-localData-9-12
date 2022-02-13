import 'package:flutter/material.dart';
import 'package:flutter_local_data/controllers/people_controller.dart';
import 'package:flutter_local_data/models/people_model.dart';
import 'package:flutter_local_data/pages/show_people.dart';

class SqflitePage extends StatelessWidget {
  SqflitePage({Key? key}) : super(key: key);

  final name = TextEditingController();
  final gender = TextEditingController();
  final address = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sqflite'),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: name,
                decoration: const InputDecoration(
                  hintText: 'Name',
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20.0),
              TextField(
                controller: gender,
                decoration: const InputDecoration(
                  hintText: 'Gender',
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20.0),
              TextField(
                controller: address,
                decoration: const InputDecoration(
                  hintText: 'Address',
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () async {
                  var people = PeopleModel(
                    id: 0,
                    name: name.text,
                    gender: gender.text,
                    address: address.text,
                  );
                  await PeopleController().insertPeople(people);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const ShowPeople()),
                  );
                  print('Insert Success');
                },
                child: const Text('Save'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
