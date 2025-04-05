enum PlayerState {
  /// 空の状態（曲が選択されていない）
  empty,

  /// 再生中
  playing,

  /// 一時停止中
  paused,

  /// 再生完了
  completed,
}

enum RepeatMode {
  /// リピートなし
  off,

  /// 1曲リピート
  one,

  /// 全曲リピート
  all,
}
