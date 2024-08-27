import 'package:dartz/dartz.dart';
import 'package:wizpedia/features/spells/domain/entities/spell.dart';
import 'package:wizpedia/features/spells/domain/repositories/spell_repository.dart';

class GetSpellsUseCase {
  final SpellRepository repository;

  GetSpellsUseCase(this.repository);

  Future<Either<Exception, List<Spell>>> call() {
    return repository.getSpells(); // Directly return the result from repository
  }
}
