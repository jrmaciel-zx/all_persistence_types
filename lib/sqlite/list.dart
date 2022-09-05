import 'package:all_persistence_types/sqlite/models/person.dart';
import 'package:flutter/material.dart';

import 'daos/PersonDao.dart';

class ListSQLiteWidget extends StatefulWidget {
  const ListSQLiteWidget({Key? key}) : super(key: key);

  @override
  ListSQLiteWidgetState createState() => ListSQLiteWidgetState();
}

class ListSQLiteWidgetState extends State<ListSQLiteWidget> {
  List<Person> personList = []
  late PersonDao dao;

  @override
  

  final title = const Text("SQLite - Lista de Pessoas");  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: widget.title,
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AddPerson()))
                .then((person) { 
                  setState(() {
                    personList.add(person);
                  });
                });             
              },
              icon: const Icon(Icons.add))
          ],
        ),
        body: ListView.separated(
          itemBuilder: (context, index) => buildItemList(index),
          separatorBuilder: (context, index) => const Divider(height: 1,),
          itemCount: personList.length)
    );
  }

  Widget buildItemList(int index) {
    Person p = personList[index];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(5)),
          child: ListTile(
            leading: Text(p.id != null ? p.id.toString() : ""),
            title: Text(p.firstName),
            subtitle: Text(p.lastName),
            onLongPress: () {                    
            }),
            ))
        .toList();
  }
}
