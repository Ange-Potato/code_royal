import 'dart:math';
import '../models/enemy.dart';

const List<Enemy> enemyBank = [
  Enemy(name: 'Bug Lord',       assetPath: 'assets/images/enemies/bug_lord.gif'),
  Enemy(name: 'Syntax Wraith',  assetPath: 'assets/images/enemies/syntax_wraith.gif'),
  Enemy(name: 'Null Pointer',   assetPath: 'assets/images/enemies/null_pointer.gif'),
  Enemy(name: 'Stack Overflow', assetPath: 'assets/images/enemies/stack_overflow.gif'),
  Enemy(name: 'Memory Leak',    assetPath: 'assets/images/enemies/memory_leak.gif'),
];

Enemy randomEnemy([Random? rng]) {
  final r = rng ?? Random();
  return enemyBank[r.nextInt(enemyBank.length)];
}