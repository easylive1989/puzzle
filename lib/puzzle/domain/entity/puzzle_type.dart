enum PuzzleType {
  number,
  image;

  static PuzzleType from(String value) {
    return PuzzleType.values.firstWhere((type) => type.toString() == value);
  }
}
