import 'package:dartz/dartz.dart';
import 'package:wizpedia/features/spells/domain/entities/spell.dart';

abstract class SpellRepository {
  Future<Either<Exception, List<Spell>>> getSpells();
}
