import 'package:cloud_firestore/cloud_firestore.dart';

class NoteModel {
  final String? id;
  final String headline;
  final String description;
  final String userId;
  final Timestamp createAt;

  NoteModel({
    required this.headline,
    required this.description,
    required this.createAt,
    required this.userId,
    required this.id
  });

  factory NoteModel.fromJson(Map<String, dynamic> json,String id) {
    return NoteModel(
      id: id,
      headline: json['headline'] as String,
      description: json['description'] as String,
      userId: json['userId'] ,
      createAt: json['createAt'] as Timestamp,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'headline': headline,
      'description': description,
      'createAt': createAt,
      'userId': userId,
      'id': id,
    };
  }
}