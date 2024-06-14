import 'package:flutter/material.dart';
import 'package:flutter_app_1/addMedic.dart';
import 'package:flutter_app_1/provider/MediTrack.dart';
import 'package:flutter_app_1/provider/PageTracker.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:provider/provider.dart';

import 'medicationDetail.dart';

class DefaultPage extends StatefulWidget {

  @override
  State<DefaultPage> createState() => DefaultPageState();
}

class DefaultPageState extends State<DefaultPage>
{
  @override
  Widget build(BuildContext context)
  {
    // Consumer to use Provider's data
    return Consumer<MediTrack>(
        builder: (context, value, child) => Column(
          children: [
    
            // Click to access details page
            GestureDetector(
              onTap: () {
                var index = value.nextMedic.index;
                if (index != -1) {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => MedicationDetail(
                      name: value.getMedics[index].name,
                      description: value.getMedics[index].description,
                      dose: value.getMedics[index].dose,
                      hour: value.getMedics[index].hour,
                      minute: value.getMedics[index].minute,
                      index: index,
                      )));
                }
              },
    
              // Define container for next medication
              child: Container(
    
                // Add color and border radius
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Color.fromARGB(255, 3, 121, 255),
                ),
                margin: EdgeInsets.all(10),
    
                // Row to display medication name, description and hour
                child : Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(10),
                            child: Text("Prochain médicament", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(10),
                            child: Text(value.nextMedic.medic.name == "" ? "Aucun médicament pour l'instant" : value.nextMedic.medic.name, overflow: TextOverflow.ellipsis),
                          )
                        ],
                      ),
                    ),
    
                    // Display icons to delete and see details
                    Expanded(
                      flex: 1,
                      child: Text("à ${value.nextMedic.medic.hour}h${value.nextMedic.medic.minute}")
                    ),
                  ],
                ) 
              ),
            ),
            // Other provider to handle pages
            Consumer<PageTracker>(
              builder: (context, value, child) => Row(
                children: [
                  Expanded(

                    // To go to the add medication page
                    child: GestureDetector(
                      onTap: () {
                        value.changePage(id: 2);
                      },
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.15,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: Color.fromARGB(255, 3, 121, 255),
                        ),
                        margin: EdgeInsets.all(10),
                        padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.all(10),
                              child: Icon(Icons.add, size: 50)
                            ),
                            Text("Ajouter"),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,

                    // To go to the list of medicaments
                    child: GestureDetector(
                      onTap: () {
                        value.changePage(id: 1);
                      },
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.15,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: Color.fromARGB(255, 3, 121, 255),
                        ),
                        margin: EdgeInsets.all(10),
                        child: Row(
                          children: [
                            Icon(Icons.list, size: 50),
                            Text("Liste de médicaments", style: TextStyle(fontSize: 18)),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Display the number of medication not taken
            Container(
              decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: Color.fromARGB(255, 3, 121, 255),
                      ),
                      margin: EdgeInsets.all(10),
                      padding: EdgeInsets.all(10),
                      width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Médicaments en attente", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  Text(value.getUntakenMedics().length != 0 ? "${value.getUntakenMedics().length.toString()} missed medications" : "Vous avez pris tous vos médicaments ! Hooray !", overflow: TextOverflow.ellipsis),
                ],
              ),
            )
          ],
        ),
    );
  }
}