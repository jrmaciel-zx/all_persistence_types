import 'package:all_persistence_types/sqlite/models/person.dart';
import 'package:flutter/material.dart';

class AddLanguage extends StatelessWidget {
  AddLanguage({Key? key}) : super(key: key);

  final Text title = const Text("Nova Linguagem");
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: title),
        body: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                        decoration: const InputDecoration(
                            hintText: "Nome", labelText: "Nome"),
                        controller: _firstNameController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Insira o primeiro nome da pessoa";
                          }
                          return null;
                        }),
                    TextFormField(
                        decoration: const InputDecoration(
                            hintText: "Sobrenome", labelText: "Sobrenome"),
                        controller: _lastNameController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Insira o sobrenome da pessoa";
                          }
                          return null;
                        }),
                    TextFormField(
                        decoration: const InputDecoration(
                            hintText: "Endereço", labelText: "Endereço"),
                        controller: _addressController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Insira o endereço";
                          }
                          return null;
                        }),
                    Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            Person person = Person(
                                firstName: _firstNameController.text,
                                lastName: _lastNameController.text,
                                address: _addressController.text);
                            Navigator.pop(context, person);
                          }
                        },
                        child: const Text("Gravar"),
                      ),
                    )
                  ]),
            )));
  }
}
