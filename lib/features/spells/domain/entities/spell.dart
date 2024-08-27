import 'package:equatable/equatable.dart';

class Spell extends Equatable {
  final String id;
  final String name;
  final String incantation;
  final String effect;
  final bool canBeVerbal;
  final String type;
  final String light;
  final String? creator;

  const Spell({
    required this.id,
    required this.name,
    required this.incantation,
    required this.effect,
    required this.canBeVerbal,
    required this.type,
    required this.light,
    this.creator,
  });

  @override
  List<Object?> get props =>
      [id, name, incantation, effect, canBeVerbal, type, light, creator];
}
