
import 'package:flutter/material.dart';

class EditProfilePage extends StatefulWidget {
  
  @override
  State<StatefulWidget> createState() => _EditProfilePage();
    
}

class _EditProfilePage extends State<EditProfilePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Profile"),
      ),
    );
  }

  
}