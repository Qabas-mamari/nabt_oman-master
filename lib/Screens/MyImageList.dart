import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:nabt_oman/reusableCode/AppPlantDecoration.dart';

import '../Data/DatabaseHelper.dart';
import '../Data/app_info_list.dart';
import '../Data/nabt_model.dart';
import '../main.dart';
import '../reusableCode/Helper.dart';
import 'MapScreen.dart';

class MyImageList extends StatefulWidget {
  final Function(Plant,bool) onUpdatePlant;
  const MyImageList({Key? key, required this.onUpdatePlant}) : super(key: key);


  @override
  State<MyImageList> createState() => _MyImageListState();
}

class _MyImageListState extends State<MyImageList> {
  List <Plant> plantList = [];
  void _handleDeletePlant(String key) async{
    try {
      await Helper.showNotification(
        localNotificationPlugin: flutterLocalNotificationsPlugin,
        title: 'Success',
        body: 'Plant deleted successfully!',
        id: 1,
      );
      await DatabaseHelper.deletePlant(key);
      setState(() {
        plantList.removeWhere((plant) => plant.key == key);
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
              "Castle deleted successfully", textAlign: TextAlign.center),
          backgroundColor: Colors.green,
        ),
      );
    }catch(e){
      await Helper.showNotification(
        localNotificationPlugin: flutterLocalNotificationsPlugin,
        title: 'Error',
        body: 'Error deleting a castle: ${e.toString()}',
        id: 2,
      );
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(
            "Error deleting a castle: ${e.toString()}",
            textAlign: TextAlign.center,
          ),
            backgroundColor: Colors.red,
          )
      );
    }
  }
  void _handleShowMap(Plant plant) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => MapScreen(
            plant: plant,
          )),
    );
  }
  void _handleUpdatePlantRating(Plant plant, double newRating) async {
    String key = plant.key!;
    try {
      // Find the castle with the given key
      final castleIndex = plantList.indexWhere((castle) => castle.key == key);
      if (castleIndex == -1) {
        throw Exception("Castle not found");
      }

      // Check if castleData is not null
      PlantData? nullableCastleData = plantList[castleIndex].plantData;
      if (nullableCastleData == null) {
        throw Exception("plant data not found");
      }

      // Update the castle rating
      PlantData updatedPlantData = nullableCastleData;
      updatedPlantData.starRating = newRating;

      // Update the castle data in the database
      await DatabaseHelper.updatePlantData(key, updatedPlantData);

      // Update the local castle list
      setState(() {
        plantList[castleIndex].plantData = updatedPlantData;
      });

      // Display success notification
      /*await Helper.showNotification(
        localNotificationsPlugin: flutterLocalNotificationsPlugin,
        title: 'Success',
        body: 'Castle rating updated successfully!',
        id: 3,
      );*/
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "plant rating updated successfully!",
            textAlign: TextAlign.center,
          ),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Error updating plant rating: ${e.toString()}",
            textAlign: TextAlign.center,
          ),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  void initState(){
    super.initState();
    DatabaseHelper.readFirebaseRealtimeDMain((plantList){
      setState(() {
        this.plantList = plantList;
      });
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("NABT Oman",
          style: TextStyle( fontSize: 30,
            fontWeight: FontWeight.normal,
            color: Colors.white,),),
        backgroundColor:Colors.green.shade700,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(40.0),
        child: ListView(
          children: [
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'You Can Add, Delete,',
                      style: TextStyle(fontSize: 30, color: Colors.green.shade900, fontWeight: FontWeight.bold),
                    ),

                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'or Update Your Store',
                      style: TextStyle(fontSize: 30, color: Colors.green.shade900, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const Gap(20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const <Widget>[
                    Flexible(
                      child: Text(
                        'The following plants are very rare, its require some special care or attention.',
                        style: TextStyle(fontSize: 25),
                      ),
                    )
                  ],
                ),
                const Gap(50),
                Text(
                    "Plants",
                    style: TextStyle(
                        color: Colors.green[900],
                        fontSize: 36,
                        fontWeight: FontWeight.bold)),
                SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        for(int i =0; i < plantList.length; i++)
                          AppPlantDecoration(plant:plantList[i], onUpdatePlant: widget.onUpdatePlant,
                          onDelete: _handleDeletePlant,
                          onShowMap: _handleShowMap,
                          onUpdateRating:_handleUpdatePlantRating,)

                      ],

                    )
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}