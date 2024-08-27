class Elixir {
  final String id;
  final String name;
  final String? effect;
  final String? sideEffects;
  final String? characteristics;
  final String? time;
  final String? difficulty;
  final List<Ingredient> ingredients;
  final List<String> inventors;
  final String? manufacturer;

  Elixir({
    required this.id,
    required this.name,
    required this.effect,
    required this.sideEffects,
    this.characteristics,
    this.time,
    required this.difficulty,
    required this.ingredients,
    required this.inventors,
    this.manufacturer,
  });
}

class Ingredient {
  final String id;
  final String name;

  Ingredient({
    required this.id,
    required this.name,
  });
}
