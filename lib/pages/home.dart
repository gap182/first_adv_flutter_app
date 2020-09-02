import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


import 'package:firtapp/models/band.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<Band> bands = [
    Band(id: '1', name: 'Metallica', votes: 5),
    Band(id: '2', name: 'Queen', votes: 1),
    Band(id: '3', name: 'Héroes del silencio', votes: 2),
    Band(id: '4', name: 'Bon Jovi', votes: 5),

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BandNames', style: TextStyle(color: Colors.black),),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: ListView.builder(
        itemCount: bands.length,
        itemBuilder: ( context, i) => _bandTile(bands[i]),
        ),
      floatingActionButton: FloatingActionButton(
        elevation: 1,
        child: Icon(Icons.add),
        onPressed: addNewBand),
    );
  }

  Widget _bandTile(Band band) {
    return Dismissible(
          key: Key(band.id),
          direction: DismissDirection.startToEnd,
          onDismissed: (direction){
            print('direction: $direction');
            print('id: ${band.id}');
          },
          background: Container(
            padding: EdgeInsets.only(left: 8.0),
            color: Colors.red,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text('Delete Band', style: TextStyle(color: Colors.white),),
            ),
          ),
          child: ListTile(
            leading: CircleAvatar(
              child: Text(band.name.substring(0,2)),
              backgroundColor: Colors.blue[100],
            ),
            title: Text(band.name),
            trailing: Text(band.votes.toString(), style: TextStyle(fontSize: 20),),
            onTap: (){
              print(band.name);
            },
          ),
    );
  }

  addNewBand(){

    final textController = TextEditingController();

    if ( Platform.isAndroid ){

      return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('New band name'),
        content: TextField(
          controller: textController,
        ),
        actions: <Widget>[
          MaterialButton(
            child: Text('Add'),
            textColor: Colors.blue,
            elevation: 5,
            onPressed: (){
              addBandToList(textController.text);
            } )
        ],
      )
    );

    }

    showCupertinoDialog(
      context: context, 
      builder: (_){
        return CupertinoAlertDialog(
          title: Text('New band Name'),
          content: CupertinoTextField(
            controller: textController,
          ),
          actions: <Widget>[
            CupertinoDialogAction(
              isDefaultAction: true,
              child: Text('Add'),
              onPressed: (){
                addBandToList(textController.text);
              },
              ),
            CupertinoDialogAction(
              isDefaultAction: true,
              child: Text('Dismiss'),
              onPressed: (){
                Navigator.pop(context);
              },
              )
          ],
        );
      }
      );

    
  }

  void addBandToList(String name){
    print(name);
    if (name.length > 1){
      this.bands.add(Band(id: DateTime.now().toString(), name: name, votes: 0));
      setState(() {
        
      });
    }

    Navigator.pop(context);
  }

}