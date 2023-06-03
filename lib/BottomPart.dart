import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nabt_oman/Data/nabt_model.dart';

import 'IndexPage.dart';
import 'Screens/AddNewPlantDataToFirebase.dart';
import 'Screens/MyImageList.dart';

class BottomPart extends StatefulWidget {
  final Function(Plant, bool) onUpdatePlant;
  const BottomPart({Key? key, required this.onUpdatePlant}) : super(key: key);

  @override
  State<BottomPart> createState() => _BottomPartState();
}

class _BottomPartState extends State<BottomPart> {
  int _selectedIndex = 0;
  late List<Widget> _widgetOptions;

  // static final List<Widget> _widgetOptions = <Widget>[
  //   // const Text("Text"),
  //   const IndexPage(),
  //   const MyImageList(),
  // ];
  @override
  void initState(){
    super.initState();
    _widgetOptions = <Widget>[
      const IndexPage(),
      MyImageList(
        onUpdatePlant: (Plant plant, bool isUpdate){
          _updatePlant(plant, isUpdate);
        },
      ),
      AddNewPlantDataToFirebase(
        onUpdatePlant: (Plant plant, bool isUpdate) {
          _updatePlant(plant, isUpdate);
        },
      ),

    ];
  }

  void _updatePlant(Plant plant, isUpdate){
    setState(() {
      _selectedIndex = 1;
      _widgetOptions[1] = AddNewPlantDataToFirebase(
          plant: plant,
          isUpdate: isUpdate,
          onUpdatePlant: (Plant plant, bool isUpdate){}
      );
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: Center(child: _widgetOptions[_selectedIndex],),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.green.shade700,
        currentIndex: _selectedIndex,
        elevation: 10,
        onTap: _onTabFunction,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(FluentSystemIcons.ic_fluent_home_add_regular),
            activeIcon: Icon(FluentSystemIcons.ic_fluent_home_add_regular),
            label: "Home Page",
          ),

          BottomNavigationBarItem(
            icon: Icon(FluentSystemIcons.ic_fluent_store_filled),
            activeIcon: Icon(FluentSystemIcons.ic_fluent_store_filled),
            label: "NABT Plants",
          ),
          BottomNavigationBarItem(
            icon: Icon(FluentSystemIcons.ic_fluent_store_filled),
            activeIcon: Icon(FluentSystemIcons.ic_fluent_store_filled),
            label: "Add New",
          ),
        ],
        selectedLabelStyle: const TextStyle(fontSize: 23),
        selectedItemColor: Colors.white,
        unselectedLabelStyle: const TextStyle(fontSize: 19),
        unselectedItemColor: Colors.black,
      ),
    );
  }
  void _onTabFunction(int value) {
    setState(() {
      _selectedIndex = value;
      print("_selectedIndex: $_selectedIndex");
    });
  }
}