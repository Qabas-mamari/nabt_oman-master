class Plant{
  String? key;
  PlantData? plantData;
  Plant(this.key, this.plantData);

}

class PlantData{
  String? image;
  String? name;
  String? description;
  double? price;
  double? latitude;
  double? longitude;
  double? starRating;
  PlantData(this.image,this.name,this.description,this.price,this.latitude,this.longitude,this.starRating);

  PlantData.fromJson(Map<dynamic,dynamic> json){
    image = json["image"];
    name = json["name"];
    description = json["description"];
    price = checkDouble(json["price"]);
    latitude=checkDouble(json["latitude"]);
    longitude=checkDouble(json["longitude"]);
    starRating=checkDouble(json["starRating"]);

  }
  Map<String , dynamic> toJson(){
    return{
      "image": image,
      "name": name,
      "description": description,
      "price": price,
      "latitude": latitude,
      "longitude": longitude,
      "starRating":starRating,
    };
  }

  double? checkDouble(price) {

    if (price is String){
      return double.parse(price);
    }
    else if(price is int){
      return double.parse(price.toString());
    }
    else if(price is double){
      return price;
    }
    else{
      return 0.0;
    }
  }
}

