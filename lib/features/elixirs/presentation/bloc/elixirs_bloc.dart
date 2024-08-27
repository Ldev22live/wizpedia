import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:wizpedia/features/elixirs/domain/entities/elixir.dart';
import 'package:wizpedia/features/elixirs/domain/usecase/get_elixirs_usecase.dart';

abstract class ElixirEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadElixirs extends ElixirEvent {}

abstract class ElixirState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ElixirInitial extends ElixirState {}

class ElixirLoading extends ElixirState {}

class ElixirLoaded extends ElixirState {
  final List<Elixir> elixirs;

  ElixirLoaded(this.elixirs);

  @override
  List<Object?> get props => [elixirs];
}

class ElixirError extends ElixirState {
  final String message;

  ElixirError(this.message);

  @override
  List<Object?> get props => [message];
}

class ElixirsBloc extends Bloc<ElixirEvent, ElixirState> {
  final GetElixirsUseCase getElixirsUseCase;

  ElixirsBloc(this.getElixirsUseCase) : super(ElixirInitial()) {
    on<LoadElixirs>((event, emit) async {
      emit(ElixirLoading());
      final Either<Exception, List<Elixir>> result = await getElixirsUseCase();

      result.fold(
        (error) => emit(ElixirError(error.toString())),
        (elixirs) => emit(ElixirLoaded(elixirs)),
      );
    });
  }
}
