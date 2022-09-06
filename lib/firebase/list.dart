import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:all_persistence_types/firebase/add.dart';
import 'package:all_persistence_types/firebase/models/Car.dart';
import 'package:flutter/rendering.dart';

class ListCarWidget extends StatefulWidget {
  const ListCarWidget({Key? key}) : super(key: key);

  final title = const Text("Car - Lista de Livros");

  @override
  ListCarWidgetState createState() => ListCarWidgetState();
}

class ListCarWidgetState extends State<ListCarWidget> {
  List<Car> cars = [];

  @override
  void initState() {
    super.initState();
  }

  insert(Car car) async {
    FirebaseFirestore.instance.collection("car").add(car)
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
                        MaterialPageRoute(builder: (context) => AddCar()))
                    .then((car) {
                  setState(() {
                    //insert();
                  });
                });
              },
              icon: Icon(Icons.add))
        ],
      ),
      body: buildList(context)
    );
  }

  Widget buildList(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection("car").snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const LinearProgressIndicator();
        } else {
          if (snapshot.data == null) {
            return Container(child: const Text("Nenhum carro encontrado"));
          } else  {
            return buildListSeparated(context, snapshot.data!.docs);
          }
        }
      }
  }

  Widget buildListSeparated(BuildContext context, List<QueryDocumentSnapshot> snapshot) {
    return ListView(
      padding: const EdgeInsets.only(top: 30),

    )
  }

  Widget buildListItem(int index) {
    Car p = cars[index];
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(5)),
          child: ListTile(
              title: Text(p.name),
              subtitle: Text(p.brand),
              onLongPress: () {
                delete(index);
              }),
        ));
  }
}
