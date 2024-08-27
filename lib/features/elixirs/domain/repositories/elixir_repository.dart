import 'package:wizpedia/features/elixirs/domain/entities/elixir.dart';

abstract class ElixirRepository {
  Future<List<Elixir>> getElixirs();
}
