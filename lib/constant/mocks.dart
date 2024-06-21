import 'package:climby/model/difficulty_level.dart';
import 'package:climby/model/place.dart';
import 'package:flutter/material.dart';

var levelsMock = [
  DifficultyLevel(id: 1, color: Colors.yellow.value, score: 1),
  DifficultyLevel(id: 2, color: Colors.green.value, score: 2),
  DifficultyLevel(id: 3, color: Colors.blue.value, score: 4),
];

var placeMock = Place(id: 1, name: "Place Mock", difficultyLevels: levelsMock);
