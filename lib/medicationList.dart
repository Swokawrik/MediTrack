import 'package:flutter/material.dart';
import 'package:flutter_app_1/provider/MediTrack.dart';
import 'package:provider/provider.dart';

import 'medicationDetail.dart';

class MedicList extends StatefulWidget {
  @override
  State<MedicList> createState() => MedicListState();
}

class MedicListState extends State<MedicList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Liste de médicaments'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Consumer<MediTrack>(
        builder: (context, value, child) => ListView.builder(
          itemCount: value.getMedics.length,
          itemBuilder: (context, index) {

            // Display all user's medications
            return Card(
              margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListTile(
                contentPadding: EdgeInsets.all(16),

                // Display medication's name
                title: Text(
                  value.getMedics[index].name,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  overflow: TextOverflow.ellipsis,
                ),

                // Display medication's description
                subtitle: Text(
                  value.getMedics[index].description,
                  overflow: TextOverflow.ellipsis,
                ),

                // Display icon to delete medication
                trailing: IconButton(
                  icon: Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
                    value.removeItem(index);
                  },
                ),

                // Change page to go to medication detail
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MedicationDetail(
                        name: value.getMedics[index].name,
                        description: value.getMedics[index].description,
                        dose: value.getMedics[index].dose,
                        hour: value.getMedics[index].hour,
                        minute: value.getMedics[index].minute,
                        index: index,
                      ),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
