import 'package:flutter/material.dart';

class Enemy {
  final String name;
  final String assetPath;
  final int maxHp;

  const Enemy({
    required this.name,
    required this.assetPath,
    this.maxHp = 100,
  });
}