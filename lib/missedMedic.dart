import 'package:flutter/material.dart';
import 'package:flutter_app_1/provider/MediTrack.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:provider/provider.dart';

import 'medicationDetail.dart';

class MissedMedic extends StatefulWidget {

  @override
  State<MissedMedic> createState() => MissedMedicState();
}

class MissedMedicState extends State<MissedMedic>
{
  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: AppBar(
        title: Text('Liste de médicaments manqués'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),

      body: Consumer<MediTrack>(
        builder: (context, value, child) => ListView.builder(
          itemCount: value.getUntakenMedics().length,
          itemBuilder: (context, index) {
            return Card(
              margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),

              // Tile to display principal information of medication non taken
              child: ListTile(
                contentPadding: EdgeInsets.all(16),

                // Display medication's name
                title: Text(
                  value.getUntakenMedics()[index].name,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  overflow: TextOverflow.ellipsis,
                ),

                // Display medication's description
                subtitle: Text(
                  value.getUntakenMedics()[index].description,
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
                        name: value.getUntakenMedics()[index].name,
                        description: value.getUntakenMedics()[index].description,
                        dose: value.getUntakenMedics()[index].dose,
                        hour: value.getUntakenMedics()[index].hour,
                        minute: value.getUntakenMedics()[index].minute,
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