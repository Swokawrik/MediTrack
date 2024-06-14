import 'package:flutter/material.dart';
import 'package:flutter_app_1/missedMedic.dart';

// Cette classe permet de changer la page depuis un bouton exclus de la barre de navigation

class PageTracker extends ChangeNotifier {

  // L'Id de la page
  int pageId;

  PageTracker({
    this.pageId = 0,
  });

  // Changer la page grâce à son id
  void changePage({required int id}) async
  {
    pageId = id;
    notifyListeners();
  }

  // Récupérer l'id de la page actuelle
  int get getPage {
    return pageId;
  }
}