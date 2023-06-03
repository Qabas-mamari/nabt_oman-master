import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:nabt_oman/reusableCode/Helper.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

import '../Data/nabt_model.dart';
import 'AppStyle.dart';

class AppPlantDecoration extends StatelessWidget {

  //final Map<String, dynamic> nabtList;
  final Plant plant;
  final Function(Plant, bool) onUpdatePlant;
  final Function(String key) onDelete;
  final Function(Plant) onShowMap;
  final Function(Plant,double) onUpdateRating;


  const AppPlantDecoration({Key? key, required this.plant, required this.onUpdatePlant, required this.onDelete, required this.onShowMap, required this.onUpdateRating,}) : super(key: key);
  Widget _buildRatingBar() {
    return SmoothStarRating(
      allowHalfRating: true,
      starCount: 5,
      rating: plant.plantData!.starRating,
      size: 30.0,
      isReadOnly: false,
      color: Colors.amber,
      borderColor: Colors.deepOrange,
      spacing: 0.0,
      onRated: (rating) {
        onUpdateRating(plant, rating);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 460,
        width: 0.75 * MediaQuery.of(context).size.width,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: Colors.green[900],),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Container(
                height: 200,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.yellow,
                    image: DecorationImage(image: AssetImage("assets/img/${plant.plantData!.image.toString()}"), fit: BoxFit.cover)
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20,),
              child: Container(
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.green[100],
                ),
                child:  Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  child: Column(
                    children:[
                      Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children:  [
                            Text("Name:", style: AppStyles.textStyle1,),
                            Text("Price:", style: AppStyles.textStyle1,),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children:  [
                            Text(plant.plantData!.name.toString(), style: AppStyles.textStyle2, ),
                            Text(plant.plantData!.price.toString().toString(), style: AppStyles.textStyle2,)
                          ],),
                      ],
                      ),
                      Gap(10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Flexible(child: Text(plant.plantData!.description.toString(), style: AppStyles.textStyle2,  textAlign: TextAlign.justify,), ),
                        ],
                      ),
                    ]
                  ),
                ),
                Positioned(
                    bottom: 10,
                    left: 130,
                    child: IconButton(
                      icon: const Icon(
                        Icons.edit,
                        color: Colors.blue,
                      ),
                      onPressed: (){
                        onUpdatePlant(plant, true);
                      },
                    )
                ),
                Positioned(
                  bottom: 10,
                  left: 100,
                  child: IconButton(
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                    onPressed: ()=> onDelete(plant.key!),
                  ),
                ),
                Positioned(
                  bottom: 10,
                  left: 70,
                  child: IconButton(
                    icon: const Icon(
                      Icons.map,
                      color: Colors.black,
                    ),
                    onPressed: ()=> onShowMap(plant),
                  ),
                ),
                Positioned(
                  bottom: 10,
                  left: 160,
                  child: IconButton(
                    icon: const Icon(
                      Icons.sms,
                      color: Colors.purple,
                    ),
                    onPressed: (){
                      Helper.sendSMS("0096894008038", "I would like to buy ""${plant.plantData!.name} plant.", context);
    }
                  ),
                  ),
                Positioned(
                  bottom: 10,
                  left: 200,
                  child: IconButton(
                    icon: const Icon(
                      Icons.email,
                      color: Colors.deepOrange,
                    ),
                    onPressed: () {
                      Helper.sendEmail(
                          "MobileProject940@gmail.com",
                          "Booking Request for ${plant.plantData!.name} Castle",
                          "Hello,\n\nI would like to book a visit to the "
                              "${plant.plantData!.name} castle.\n\nThank you.",
                          context);
                    },
                  ),
                ),
                Positioned(
                  bottom: -2,
                  right: 50,
                  child: _buildRatingBar(),
                ),


                
              ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
