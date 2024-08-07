import 'package:flutter/material.dart';

class WaitingScreen extends StatelessWidget {
const WaitingScreen({ super.key });

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: const Center(
        child: CircularProgressIndicator(),
      ),

    );
  }
}