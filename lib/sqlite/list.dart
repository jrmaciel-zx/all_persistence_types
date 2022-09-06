import 'package:all_persistence_types/sqlite/add.dart';
import 'package:all_persistence_types/sqlite/daos/PersonDao.dart';
import 'package:all_persistence_types/sqlite/models/person.dart';
import 'package:flutter/material.dart';

class ListSQLiteWidget extends StatefulWidget {
  const ListSQLiteWidget({Key? key}) : super(key: key);
  final title = const Text("SQLite - Lista de Pessoas");

  @override
  ListSQLiteWidgetState createState() => ListSQLiteWidgetState();
}

class ListSQLiteWidgetState extends State<ListSQLiteWidget> {
  List<Person> personList = [];
  late PersonDAO dao;

  @override
  void initState() {
    super.initState();
    getAllPersons();
  }

  getAllPersons() async {
    List<Person> result = await PersonDAO().readAll();
    setState(() {
      personList = result;
    });
  }

  insertPerson(Person person) async {
    int id = await PersonDAO().insertPerson(person);
    if (id > 0) {
      person.id = id;
      setState(() {
        personList.add(person);
      });
    }
  }

  deletePerson(int index) async {
    Person person = personList[index];
    if (person.id != null) {
      await PersonDAO().deletePersonById(person.id!);
      setState(() {
        personList.removeAt(index);
      });
    }
  }

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
            separatorBuilder: (context, index) => const Divider(
                  height: 1,
                ),
            itemCount: personList.length));
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
              leading: Text(p.id != null ? p.id.toString() : "-1"),
              title: Text(p.firstName),
              subtitle: Text(p.lastName),
              onLongPress: () {
                deletePerson(index);
              }),
        ));
  }
}
