import 'package:flutter/material.dart';
import 'theme.dart';
import 'models/player_progress.dart';
import 'data/player_repository.dart';
import 'screens/main_menu_screen.dart';

void main() {
  runApp(const CodeRoyalApp());
}

class CodeRoyalApp extends StatefulWidget {
  const CodeRoyalApp({super.key});

  @override
  State<CodeRoyalApp> createState() => _CodeRoyalAppState();
}

class _CodeRoyalAppState extends State<CodeRoyalApp> {
  final _repo = PlayerRepository();
  PlayerProgress _progress = const PlayerProgress();
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final p = await _repo.load();
    if (!mounted) return;
    setState(() {
      _progress = p;
      _loading = false;
    });
  }

  Future<void> _updateProgress(PlayerProgress p) async {
    await _repo.save(p);
    if (!mounted) return;
    setState(() => _progress = p);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Code Royal',
      debugShowCheckedModeBanner: false,
      theme: appTheme,
      home: _loading
          ? const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            )
          : MainMenuScreen(
              progress: _progress,
              onProgressUpdated: _updateProgress,
            ),
    );
  }
}