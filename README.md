# MediTrack
An application to track all of your medicaments

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## How to setup

Download the zip file from the github page

Unzip the project

Go to the project's directory

Connect your mobile phone (except if you use a built in method) and make sure that the developper mode is activated

execute "adb devices" to make sure that your phone is connected, if not allow debugging on your mobile

execute "flutter run" and wait for the application to open

## Details

In this project, 2 providers are used
- MediTrack to store all the medication and all their data
- PageTracker to change page from anywhere

Main file:

Is where the bottom navigation bar is initialised
From it we can access any page


HomePage file:

Is the home page of the application, allowing to:
- See the next medicament the user will have to consume
- Add any medicament
- See the list of all medications
- Know how much medications are left


MedicationList file:

See all medication and can click on each of them to check the details
The user can also delete any of them


AddMedication file:

Allow the user to add a medication by entering:
- the name
- the description
- the amount to be taken
- the hour and minutes of when it has to be taken


MissedMedic file:

Allow the user to see all medication that he did not take yet
Also allow him to delete it


MedicationDetail file:

Allow the user to see:
- the name of the medication
- its description
- the amount to be taken
- when it has to be taken

and allow him to make the application know that he took the medication or not