import 'package:flutter/material.dart';
import 'package:flutter_app_1/missedMedic.dart';

// Cette classe permettra de suivre tous les médicaments de l'utilisateur

// Classe pour suivre chaque médicament
class MediData {

  // Nom du médicament
  final String name;
  
  // Description du médicament
  final String description;
  
  // Dose du médicament
  final String dose;
  
  // Heure à laquelle prendre le médicament
  final String hour;
  
  // Minute à laquelle prendre le médicament
  final String minute;
  
  // Permet de savoir si le médicament à été pris ou non
  bool taken;

  MediData({required this.name, required this.description, required this.dose, required this.hour, required this.minute, required this.taken});
}

// Classe pour le prochain médicament qui doit être pris
class NextMedic {
  final int index;
  final MediData medic;

  NextMedic({required this.index, required this.medic});
}

class MediTrack extends ChangeNotifier {

  // Liste de tous les médicaments de l'utilisateur
  List<MediData> items = [];

  // Ajouter un médicament
  void addItem(MediData itemData) {
    items.add(itemData);
    notifyListeners();
  }

  // Enlever un médicament
  void removeItem(int index) {
    items.removeAt(index);
    notifyListeners();
  }

  // Récupérer la liste de tous les médicaments
  List<MediData> get getMedics {
    return items;
  }

  // Permet de changer le status de si le médicament à été pris ou non
  void switchMedicTaken(int index)
  {
    items[index].taken = !items[index].taken;
  }

  // Récupérer si le médicament à déjà été pris ou non
  bool getMedicTaken(int index)
  {
    return items[index].taken;
  }

  // Récupérer le prochain médicament à prendre
  NextMedic get nextMedic {

    // Vérifier si la liste de médicaments en vide ou non
    if (items.isEmpty) {
      return NextMedic(index: -1, medic: MediData(name: "", description: "", dose: "", hour: "00", minute: "00", taken: false)); // Return a default or error object
    }

    // Initialiser le temps et l'index du prochain médicament 
    DateTime now = DateTime.now();
    MediData? nextMedication;
    int nextIndex = -1;
    Duration shortestDuration = Duration(days: 1);

    // Parcourir la liste de médicaments
    for (int i = 0; i < items.length; i++) {
      // Récupérer les informations de chaque médicament
      var item = items[i];
      if (item.taken != true) {
      int itemHour = int.parse(item.hour);
      int itemMinute = int.parse(item.minute);
      DateTime itemTime = DateTime(now.year, now.month, now.day, itemHour, itemMinute);

      // Si tous les médicaments on été pris aujourd'hui alors affiche ceux du lendemain
      if (itemTime.isBefore(now)) {
        itemTime = itemTime.add(Duration(days: 1));
      }

      // Permet de récupérer le prochain médicament
      Duration diff = itemTime.difference(now);

      if (diff < shortestDuration) {
        shortestDuration = diff;
        nextMedication = item;
        nextIndex = i;
      }
      }
    }
    return NextMedic(index: nextIndex, medic: nextMedication ?? MediData(name: "", description: "", dose: "", hour: "00", minute: "00", taken: false));
  }

  // Récupérer la liste de tous les médicaments non pris
  List<MediData> getUntakenMedics() {
    return items.where((item) => !item.taken).toList();
  }
}