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

  static const sample = PlayerProgress();

  double get levelProgress => (level / maxLevel).clamp(0.0, 1.0);
  double get xpProgress => (xp / xpPerLevel).clamp(0.0, 1.0);
  int get xpToNextLevel => xpPerLevel - xp;
  int get levelPercent => (levelProgress * 100).round();

  PlayerProgress copyWith({
    String? playerName,
    int? level,
    int? xp,
    int? totalScore,
    int? battlesWon,
  }) {
    return PlayerProgress(
      playerName: playerName ?? this.playerName,
      level: level ?? this.level,
      xp: xp ?? this.xp,
      totalScore: totalScore ?? this.totalScore,
      battlesWon: battlesWon ?? this.battlesWon,
    );
  }

  PlayerProgress gainBattleRewards({
    required int xpGained,
    required int scoreGained,
    required bool won,
  }) {
    var newXp = xp + xpGained;
    var newLevel = level;
    while (newXp >= xpPerLevel && newLevel < maxLevel) {
      newXp -= xpPerLevel;
      newLevel += 1;
    }
    return copyWith(
      level: newLevel,
      xp: newXp,
      totalScore: totalScore + scoreGained,
      battlesWon: won ? battlesWon + 1 : battlesWon,
    );
  }
}