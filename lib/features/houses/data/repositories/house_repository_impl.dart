import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:wizpedia/features/houses/data/models/house_model.dart';
import 'package:wizpedia/features/houses/domain/entities/house.dart';
import 'package:wizpedia/features/houses/domain/repositories/house_repository.dart';

class HouseRepositoryImpl implements HouseRepository {
  final http.Client client;

  HouseRepositoryImpl(this.client);

  @override
  Future<List<House>> getHouses() async {
    final response = await client
        .get(Uri.parse('https://wizard-world-api.herokuapp.com/Houses'));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data
          .map((json) => House(
                id: json['id'],
                name: json['name'],
                houseColours: json['houseColours'],
                founder: json['founder'],
                animal: json['animal'],
                element: json['element'],
                ghost: json['ghost'],
                commonRoom: json['commonRoom'],
                heads: (json['heads'] as List<dynamic>)
                    .map((head) =>
                        HouseHeadModel.fromJson(head as Map<String, dynamic>))
                    .toList(),
                traits: (json['traits'] as List<dynamic>)
                    .map((trait) =>
                        HouseTraitModel.fromJson(trait as Map<String, dynamic>))
                    .toList(),
              ))
          .toList();
    } else {
      throw Exception('Failed to load houses');
    }
  }
}
