import 'package:wizpedia/features/houses/domain/entities/house.dart';
import 'package:wizpedia/features/houses/domain/repositories/house_repository.dart';

class GetHousesUseCase {
  final HouseRepository repository;

  GetHousesUseCase(this.repository);

  Future<List<House>> call() {
    return repository.getHouses();
  }
}
