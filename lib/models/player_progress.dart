class PlayerProgress {
  final String playerName;
  final int level;
  final int xp;
  final int totalScore;
  final int battlesWon;

  static const int maxLevel = 100;
  static const int xpPerLevel = 500;

  const PlayerProgress({
    this.playerName = 'Player',
    this.level = 0,
    this.xp = 0,
    this.totalScore = 0,
    this.battlesWon = 0,
  });

  static const sample = PlayerProgress(
    playerName: 'Player',
    level: 0,
    xp: 0,
    totalScore: 0,
    battlesWon: 0,
  );

  double get levelProgress => (level / maxLevel).clamp(0.0, 1.0);
  double get xpProgress => (xp / xpPerLevel).clamp(0.0, 1.0);
  int get xpToNextLevel => xpPerLevel - xp;
  int get levelPercent => (levelProgress * 100).round();
}