import 'package:flutter/material.dart';
import 'package:flutter_local_data/controllers/people_controller.dart';
import 'package:flutter_local_data/models/people_model.dart';

class ShowPeople extends StatefulWidget {
  const ShowPeople({Key? key}) : super(key: key);

  @override
  State<ShowPeople> createState() => _ShowPeopleState();
}

class _ShowPeopleState extends State<ShowPeople> {
  List<PeopleModel> list = [];
  bool isLoaded = false;
  _selectData() async {
    list = await PeopleController().selectPeople();
    isLoaded = true;
  }

  @override
  void initState() {
    _selectData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('People List'),
      ),
      body: isLoaded
          ? ListView.separated(
              itemBuilder: (context, index) {
                var data = list[index];
                return ListTile(
                  leading: CircleAvatar(
                    child: Text('${index + 1}'),
                  ),
                  title: Text(data.name),
                  subtitle: Text(data.address),
                );
              },
              separatorBuilder: (context, index) {
                return const Divider();
              },
              itemCount: list.length,
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
