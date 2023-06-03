import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class IndexPage extends StatefulWidget {
  const IndexPage({Key? key}) : super(key: key);

  @override
  State<IndexPage> createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  @override
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/img/index.jpg', // replace with your image asset path
              width: 400,
              height: 400,
            ),
            SizedBox(height: 20),
            const Text(
              'Welcome to Your NABT Store',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
