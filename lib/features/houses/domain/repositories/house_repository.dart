import 'package:wizpedia/features/houses/domain/entities/house.dart';

abstract class HouseRepository {
  Future<List<House>> getHouses();
}
