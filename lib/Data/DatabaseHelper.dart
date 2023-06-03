import 'package:firebase_database/firebase_database.dart';

import 'nabt_model.dart';



class DatabaseHelper{


  //Creat Function
  static void createDataFirebaseRealtimeWithUniqueID(
      String mainNodeName, List<Map<String, dynamic>> nabtList) {
    DatabaseReference databaseReference = FirebaseDatabase.instance.ref(mainNodeName);
    if (nabtList.isNotEmpty) {
      nabtList.forEach((element) {
        databaseReference.push().set(element)
            .then((value) => print("nabtList data successfully saved!"))
            .catchError((error) => print("Failed to write message: $error"));
      });
    } else {
      print("nabtList is empty!");
    }
  }


  static Future<void> savedDataItem(PlantData plantData){
    DatabaseReference df = FirebaseDatabase.instance.ref();
    return df.child("Nabt").push().set(plantData.toJson())
        .then((value) => print("Nabt data saved successfully"))
        .catchError((error)=> print("Failed to save Nabt data : $error"));
  }

  static Future<void> updatePlantData(String key, PlantData plantData) async {
    DatabaseReference df = FirebaseDatabase.instance.ref();
    await df.child("Nabt").child(key).update(plantData.toJson());
  }

  static Future<void> deletePlant(String key) async{
    DatabaseReference df = FirebaseDatabase.instance.ref();
    await df.child("Nabt").child(key).remove();
  }


  //read Function

  static void readFirebaseRealtimeDMain( Function(List<Plant>) plantListCallback){
    DatabaseReference databaseReference = FirebaseDatabase.instance.ref();
    databaseReference.child("Nabt").onValue.listen((castleDataJson) {
      if(castleDataJson.snapshot.exists){
        PlantData castleData;
        Plant castle;
        List<Plant> plantleList =[];
        castleDataJson.snapshot.children.forEach((element) {
          castleData = PlantData.fromJson(element.value as Map);
          castle = Plant(element.key,castleData );
          plantleList.add(castle);
        });
        plantListCallback(plantleList);

      }
      else{
        print("The data snapshot doesnt exsist!");
      }

    });


  }
}