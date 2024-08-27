import 'package:wizpedia/features/spells/domain/entities/spell.dart';

class SpellModel extends Spell {
  const SpellModel({
    required super.id,
    required super.name,
    required super.incantation,
    required super.effect,
    required super.canBeVerbal,
    required super.type,
    required super.light,
    super.creator,
  });

  factory SpellModel.fromJson(Map<String, dynamic> json) {
    return SpellModel(
      id: json['id'] as String? ?? 'Unknown ID',
      name: json['name'] as String? ?? 'Unknown Name',
      incantation: json['incantation'] as String? ?? 'Unknown Incantation',
      effect: json['effect'] as String? ?? 'Unknown Effect',
      canBeVerbal: json['canBeVerbal'] as bool? ?? false,
      type: json['type'] as String? ?? 'Unknown Type',
      light: json['light'] as String? ?? 'Unknown Light',
      creator: json['creator'] as String?,
    );
  }
}
