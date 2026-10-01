import 'package:shared_preferences/shared_preferences.dart';
import '../models/player_progress.dart';

class PlayerRepository {
  static const _kName = 'player_name';
  static const _kLevel = 'player_level';
  static const _kXp = 'player_xp';
  static const _kScore = 'player_score';
  static const _kWins = 'player_wins';

  Future<PlayerProgress> load() async {
    final prefs = await SharedPreferences.getInstance();
    return PlayerProgress(
      playerName: prefs.getString(_kName) ?? 'Player',
      level: prefs.getInt(_kLevel) ?? 0,
      xp: prefs.getInt(_kXp) ?? 0,
      totalScore: prefs.getInt(_kScore) ?? 0,
      battlesWon: prefs.getInt(_kWins) ?? 0,
    );
  }

  Future<void> save(PlayerProgress p) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_kName, p.playerName);
    await prefs.setInt(_kLevel, p.level);
    await prefs.setInt(_kXp, p.xp);
    await prefs.setInt(_kScore, p.totalScore);
    await prefs.setInt(_kWins, p.battlesWon);
  }
}