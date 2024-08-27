import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:wizpedia/features/spells/data/models/spell_model.dart';
import 'package:wizpedia/features/spells/domain/entities/spell.dart';
import 'package:wizpedia/features/spells/domain/repositories/spell_repository.dart';
import 'dart:convert';

class SpellRepositoryImpl implements SpellRepository {
  final http.Client client;

  SpellRepositoryImpl(this.client);

  @override
  Future<Either<Exception, List<Spell>>> getSpells() async {
    try {
      final response = await client
          .get(Uri.parse('https://wizard-world-api.herokuapp.com/Spells'));

      if (response.statusCode == 200) {
        final List<dynamic> json = jsonDecode(response.body);
        final List<Spell> spells =
            json.map((e) => SpellModel.fromJson(e)).toList();
        return Right(spells);
      } else {
        return Left(Exception('Failed to load spells'));
      }
    } catch (e) {
      return Left(Exception('Failed to load spells: $e'));
    }
  }
}
