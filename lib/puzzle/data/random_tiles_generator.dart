
import 'package:puzzle/puzzle/domain/tiles_generator.dart';

class RandomTilesGenerator implements TilesGenerator {
  @override
  List<int> generate(int length) {
    var list =  List.generate(length, (index) => index);
    return list..shuffle();
  }
}