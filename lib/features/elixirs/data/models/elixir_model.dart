import 'package:wizpedia/features/elixirs/domain/entities/elixir.dart';

class ElixirModel extends Elixir {
  ElixirModel({
    required super.id,
    required super.name,
    required super.effect,
    required super.sideEffects,
    super.characteristics,
    super.time,
    required super.difficulty,
    required super.ingredients,
    required super.inventors,
    super.manufacturer,
  });

  factory ElixirModel.fromJson(Map<String, dynamic> json) {
    try {
      return ElixirModel(
        id: json['id'] as String? ?? 'Unknown ID',
        name: json['name'] as String? ?? 'Unknown Name',
        effect: json['effect'] as String? ?? 'Unknown Effect',
        sideEffects: json['sideEffects'] as String?,
        characteristics: json['characteristics'] as String?,
        time: json['time'] as String?,
        difficulty: json['difficulty'] as String? ?? 'Unknown Difficulty',
        ingredients: (json['ingredients'] as List<dynamic>?)?.map((i) {
              final ingredient = i as Map<String, dynamic>;
              return Ingredient(
                id: ingredient['id'] as String? ?? 'Unknown ID',
                name: ingredient['name'] as String? ?? 'Unknown Ingredient',
              );
            }).toList() ??
            [],
        inventors: (json['inventors'] as List<dynamic>?)
                ?.map((i) =>
                    (i as Map<String, dynamic>)['firstName'] as String? ??
                    'Unknown')
                .toList() ??
            [],
        manufacturer: json['manufacturer'] as String?,
      );
    } catch (e) {
      print('Error parsing JSON to ElixirModel: $e');
      rethrow;
    }
  }
}
