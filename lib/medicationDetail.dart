import 'package:flutter/material.dart';
import 'package:flutter_app_1/provider/MediTrack.dart';
import 'package:provider/provider.dart';

class MedicationDetail extends StatefulWidget {
  final String name;
  final String description;
  final String dose;
  final String hour;
  final String minute;
  final int index;

  const MedicationDetail({
    required this.name,
    required this.description,
    required this.dose,
    required this.hour,
    required this.minute,
    required this.index,
    Key? key,
  }) : super(key: key);

  @override
  State<MedicationDetail> createState() => MedicationDetailState();
}

class MedicationDetailState extends State<MedicationDetail> {

  // Display medication's data
  Widget displayInfo({required String title, required String data}) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: ListTile(
        title: Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(data),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Medication Details"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // Display medication name
              displayInfo(title: "Nom", data: widget.name),

              // Display medication description
              displayInfo(title: "Description", data: widget.description),

              // Display medication amount
              displayInfo(title: "Dose", data: widget.dose.toString()),

              // Display medication time
              displayInfo(title: "Doit être pris à", data: "${widget.hour}h${widget.minute}"),

              const SizedBox(height: 20),

              // Button to make medication as taken
              Consumer<MediTrack>(
                builder: (context, value, child) => Center(
                  child: ElevatedButton(
                    onPressed: () {
                      value.switchMedicTaken(widget.index);
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 32,
                        vertical: 16,
                      ),
                      textStyle: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    child: Text(value.getMedicTaken(widget.index) == false ? "J'ai pris mon médicament !" : "Je n'ai pas pris mon médicament..."),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
