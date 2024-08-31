import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


addMovie({
  required String poster,
  required String title,
  required String date,
  required int id,
  required BuildContext context,
}){
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference movies = firestore.collection('movies');

  movies.add({
    'poster_path':poster,
    'title':title,
    'date':date,
    'id':id,
  });
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(
      content: Text('Movie Added'),
    ),
  );
}
