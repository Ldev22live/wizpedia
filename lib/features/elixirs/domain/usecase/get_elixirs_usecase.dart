import 'package:dartz/dartz.dart';
import 'package:wizpedia/features/elixirs/domain/entities/elixir.dart';
import 'package:wizpedia/features/elixirs/domain/repositories/elixir_repository.dart';

class GetElixirsUseCase {
  final ElixirRepository repository;

  GetElixirsUseCase(this.repository);

  Future<Either<Exception, List<Elixir>>> call() async {
    try {
      final elixirs = await repository.getElixirs();
      return Right(elixirs);
    } catch (e) {
      return Left(Exception(e.toString()));
    }
  }
}
