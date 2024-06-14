import 'package:flutter/material.dart';
import 'package:flutter_app_1/provider/MediTrack.dart';
import 'package:provider/provider.dart';

class AddMedic extends StatefulWidget {
  const AddMedic({super.key});

  @override
  State<AddMedic> createState() => AddMedicState();
}

class AddMedicState extends State<AddMedic> {
  // Name of the medication
  String name = "";

  // Description of the medication
  String description = "";

  // Dose of the medication
  String dose = "";

  // Hour of the medication
  String hour = "0";

  // Minutes of the medication
  String minutes = "0";

  // Formkey for form
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // List of hours for dropdown
  List<DropdownMenuItem<String>> hoursList = [];

  // List of minutes for dropdown
  List<DropdownMenuItem<String>> minutesList = [];

  // Generate list for dropdown
  // Max is the max number
  List<DropdownMenuItem<String>> generateDropdownItems(int max) {
    return List<DropdownMenuItem<String>>.generate(
      max + 1,
      (int index) => DropdownMenuItem(
        value: index.toString(),
        child: Text(index.toString()),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    hoursList = generateDropdownItems(24);
    minutesList = generateDropdownItems(59);
  }

  // Field to input different data
  Widget passField(String text, String errorText, int limit, Function(String) onSaved) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      child: TextFormField(
        showCursor: true,
        maxLength: limit, // Set the text character's limit
        decoration: InputDecoration(
          counterStyle: TextStyle(color: Colors.white),
          fillColor: Colors.white,
          filled: true,
          hintText: text, // Display type of data
          helperStyle: TextStyle(color: Colors.white),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        validator: (String? value) {
          if (value == null || value.isEmpty) {
            return errorText; // Display error message
          }
          return null;
        },
        onSaved: (String? value) {
          if (value != null) {
            onSaved(value); // Change variable
          }
        },
      ),
    );
  }

  // Dropdown for hours and minutes
  Widget myDropDown(List<DropdownMenuItem<String>> list, String selectedValue, Function(String) onChanged) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 5),
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton(
            isExpanded: true,
            value: selectedValue,
            onChanged: (value) {
              if (value is String) {
                setState(() {
                  onChanged(value); // Change variable
                });
              }
            },
            items: list, // List of values
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Ajouter un médicament"),
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                passField( "Nom", "Veuillez entrer le nom du médicament", 30,
                  (value) {
                    setState(() {
                      name = value;
                    });
                  },
                ),
                passField( "Description", "Veuillez entrer la description du médicament", 200,
                  (value) {
                    setState(() {
                      description = value;
                    });
                  },
                ),
                passField("Dose", "Veuillez entrer la dose prescrite", 20,
                  (value) {
                    setState(() {
                      dose = value;
                    });
                  },
                ),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Text("A prendre à "),
                    ),
                    myDropDown(hoursList, hour, (value) {
                      setState(() {
                        hour = value;
                      });
                    }),
                    Center(child: Text(" h ")),
                    myDropDown(minutesList, minutes, (value) {
                      setState(() {
                        minutes = value;
                      });
                    }),
                  ],
                ),

                // Display button to confirm informations
                Padding(
                  padding: const EdgeInsets.only(top: 60),
                  child: Container(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton(
                      onPressed: () {
                        formKey.currentState!.save();
                        if (formKey.currentState!.validate()) {
                            context.read<MediTrack>().addItem(MediData(
                            name: name,
                            description: description,
                            dose: dose,
                            hour: hour,
                            minute: minutes,
                            taken: false,
                          ));
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                        textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      child: const Text('Confirmer'),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
