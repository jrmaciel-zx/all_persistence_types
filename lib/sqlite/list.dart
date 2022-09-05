import 'package:all_persistence_types/sqlite/models/person.dart';
import 'package:flutter/material.dart';

class ListSQLiteWidget extends StatelessWidget {
  ListSQLiteWidget({Key? key}) : super(key: key);

  final title = const Text("SQLite - Lista de Pessoas");
  final List<Person> personList = [
    Person(firstName: "José", lastName: "Maciel", address: "Rua Dianópolis")
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: title),
        body: ListView(children: buildItemList()));
  }

  List<Widget> buildItemList() {
    return personList
        .map((p) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(5)),
              child: ListTile(
                  leading: Text(p.id != null ? p.id.toString() : ""),
                  title: Text(p.firstName),
                  subtitle: Text(p.lastName)),
            )))
        .toList();
  }
}
