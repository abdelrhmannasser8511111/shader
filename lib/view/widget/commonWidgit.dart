

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future errDialog({required BuildContext context, required String err}){

  return showDialog(context: context, builder: (ctx){
    return AlertDialog(
      title: Text("error"),
      content:Text("$err") ,
      actions: [
        ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text("OK",
                style: TextStyle(color: Colors.white)),
            style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xff22a39f))),
      ],
    );
  });
}




snackBar({required BuildContext context, required String content}){
 final snackBar = SnackBar(
    content: Text(content),
    backgroundColor: (Colors.green),
    // action: SnackBarAction(
    //   label: 'dismiss',
    //   onPressed: () {
    //   },
    // ),
  );
return  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}