import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wizpedia/features/houses/domain/usecase/get_houses_usecase.dart';
import 'package:wizpedia/features/houses/domain/entities/house.dart';

abstract class HousesEvent {}

class LoadHouses extends HousesEvent {}

abstract class HousesState {}

class HousesInitial extends HousesState {}

class HousesLoading extends HousesState {}

class HousesLoaded extends HousesState {
  final List<House> houses;
  HousesLoaded(this.houses);
}

class SearchHousesEvent extends HousesEvent {
  final String query;

  SearchHousesEvent(this.query);
}

class HousesError extends HousesState {
  final String message;
  HousesError(this.message);
}

class HousesBloc extends Bloc<HousesEvent, HousesState> {
  final GetHousesUseCase getHousesUseCase;

  HousesBloc(this.getHousesUseCase) : super(HousesInitial()) {
    on<LoadHouses>(_onLoadHouses);
  }

  @override
  Stream<HousesState> mapEventToState(HousesEvent event) async* {
    if (event is SearchHousesEvent) {
      yield* _mapSearchHousesToState(event.query);
    }
    // Handle other events...
  }

  Stream<HousesState> _mapSearchHousesToState(String query) async* {
    try {
      final houses = await getHousesUseCase.call();
      final filteredHouses = houses
          .where((house) =>
              house['name'].toLowerCase().contains(query.toLowerCase()))
          .toList();
      yield HousesLoaded(filteredHouses);
    } catch (_) {
      yield HousesError();
    }
  }

  Future<void> _onLoadHouses(
      LoadHouses event, Emitter<HousesState> emit) async {
    emit(HousesLoading());
    try {
      final houses = await getHousesUseCase.call();
      emit(HousesLoaded(houses));
    } catch (e) {
      emit(HousesError(e.toString()));
    }
  }
}
