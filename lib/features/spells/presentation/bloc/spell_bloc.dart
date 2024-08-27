import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart'; // For Either
import 'package:equatable/equatable.dart';
import 'package:wizpedia/features/spells/domain/entities/spell.dart';
import 'package:wizpedia/features/spells/domain/usecase/get_spells_usecase.dart';

abstract class SpellEvent extends Equatable {
  const SpellEvent();

  @override
  List<Object> get props => [];
}

class LoadSpells extends SpellEvent {}

abstract class SpellState extends Equatable {
  const SpellState();

  @override
  List<Object> get props => [];
}

class SpellInitial extends SpellState {}

class SpellLoading extends SpellState {}

class SpellLoaded extends SpellState {
  final List<Spell> spells;

  const SpellLoaded(this.spells);

  @override
  List<Object> get props => [spells];
}

class SpellError extends SpellState {
  final String message;

  const SpellError(this.message);

  @override
  List<Object> get props => [message];
}

class SpellBloc extends Bloc<SpellEvent, SpellState> {
  final GetSpellsUseCase getSpellsUseCase;

  SpellBloc(this.getSpellsUseCase) : super(SpellInitial()) {
    on<LoadSpells>(_onLoadSpells);
  }

  Future<void> _onLoadSpells(LoadSpells event, Emitter<SpellState> emit) async {
    emit(SpellLoading());
    final result = await getSpellsUseCase();
    result.fold(
      (exception) => emit(SpellError(exception.toString())),
      (spells) => emit(SpellLoaded(spells)),
    );
  }
}
