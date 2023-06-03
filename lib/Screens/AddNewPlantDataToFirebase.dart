
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nabt_oman/Data/nabt_model.dart';

import '../Data/DatabaseHelper.dart';
import '../main.dart';
import '../reusableCode/Helper.dart';

class AddNewPlantDataToFirebase extends StatelessWidget{
  final Plant? plant;
  final bool isUpdate;
  final void Function(Plant plant,  bool isUpdate) onUpdatePlant;
  final nameController = TextEditingController();
  final imagePathController = TextEditingController();
  final descriptionController= TextEditingController();
  final priceController = TextEditingController();
  final latitudeController=TextEditingController();
  final longitudeController= TextEditingController();

  final GlobalKey<ScaffoldMessengerState> _scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();
  AddNewPlantDataToFirebase({super.key,
    this.plant,
    this.isUpdate= false,
    required this.onUpdatePlant
  });

  @override
  Widget build(BuildContext context) {
    if(isUpdate && plant != null){
      nameController.text = plant!.plantData!.name?? "";
      imagePathController.text = plant!.plantData!.image?? "";
      descriptionController.text = plant!.plantData!.description?? "";
      priceController.text = plant!.plantData!.price.toString()?? "";
      latitudeController.text=plant!.plantData!.latitude?.toString()??"";
      longitudeController.text=plant!.plantData!.longitude?.toString()??"";



    }
    return MaterialApp(
      title: "",
      home: ScaffoldMessenger(
        key: _scaffoldMessengerKey,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Flutter Firebase demo',),
            backgroundColor: Colors.green,
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  TextField(
                    controller: nameController,
                    decoration: const InputDecoration( labelText: "Name"),
                  ),
                  TextField(
                    controller: imagePathController,
                    decoration: const InputDecoration( labelText: "Image"),
                  ),
                  TextField(
                    controller: descriptionController,
                    decoration: const InputDecoration( labelText: "Description"),
                  ),
                  TextField(
                    controller: priceController,
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    decoration: const InputDecoration( labelText: "Price"),
                  ),
                  TextField(
                    controller: latitudeController,
                    keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                    decoration: const InputDecoration(labelText: 'Latitude'),
                  ),
                  TextField(
                    controller: longitudeController,
                    keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                    decoration: const InputDecoration(labelText: 'Longitude'),
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                      // Other properties, such as textStyle, elevation, shape, etc.
                    ),
                    child: const Text("save"),
                    onPressed: () {
                      PlantData plantData = PlantData(
                        imagePathController.text,
                        nameController.text,
                        descriptionController.text,
                        double.parse(priceController.text),
                        double.parse(latitudeController.text),
                        double.parse(longitudeController.text),
                        0.0,

                      );
                      if(isUpdate && plant != null){
                        DatabaseHelper.updatePlantData(plant!.key!, plantData)
                            .then((value) async => {
                          // Display success notification
                          await Helper.showNotification(
                            localNotificationPlugin: flutterLocalNotificationsPlugin,
                            title: 'Success',
                            body: 'Data update succssefully',
                            id: 1,
                          ),
                          _scaffoldMessengerKey.currentState?.showSnackBar(const SnackBar(content: Text(
                            "Data update succssefully",
                            textAlign: TextAlign.center,
                          ),
                            backgroundColor: Colors.green,),)
                        }).catchError((error) async {
                          // Display failure notification
                          await Helper.showNotification(
                            localNotificationPlugin: flutterLocalNotificationsPlugin,
                            title: 'Error',
                            body: 'failed to update date: ${error.toString()}',
                            id: 2,
                          );
                          _scaffoldMessengerKey.currentState?.showSnackBar(const SnackBar(content: Text(
                            "failed to update date: &error",
                            textAlign: TextAlign.center,
                          ),
                            backgroundColor: Colors.red,),);
                        });}
                      else{

                        DatabaseHelper.savedDataItem(plantData).then((_) async {
                          // Display success notification
                          await Helper.showNotification(
                            localNotificationPlugin: flutterLocalNotificationsPlugin,
                            title: 'Success',
                            body: 'Data saved successfully',
                            id: 1,
                          );
                          _scaffoldMessengerKey.currentState?.showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Data saved successfully',
                                textAlign: TextAlign.center,
                              ),
                              backgroundColor: Colors.green,
                            ),
                          );
                        }).catchError((error) async {
                          // Display failure notification
                          await Helper.showNotification(
                            localNotificationPlugin: flutterLocalNotificationsPlugin,
                            title: 'Error',
                            body: 'Failed to save data:${error.toString()}',
                            id: 2,
                          );
                          _scaffoldMessengerKey.currentState?.showSnackBar(
                            SnackBar(content: Text("Failed to save data: $error",
                              textAlign: TextAlign.center,
                            ),
                              backgroundColor: Colors.red,
                            ),
                          );
                        });}

                    },

                  ),
                ],
              ),
            ),
          ),
        ),
      ) ,
      debugShowCheckedModeBanner: false,

    );
  }



}