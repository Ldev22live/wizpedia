import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wizpedia/features/houses/presentation/bloc/houses_bloc.dart';
import 'package:wizpedia/features/houses/domain/entities/house.dart';

class HousesPage extends StatelessWidget {
  const HousesPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Dispatch LoadHouses event
    context.read<HousesBloc>().add(LoadHouses());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Houses Overview'),
      ),
      body: BlocBuilder<HousesBloc, HousesState>(
        builder: (context, state) {
          if (state is HousesLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is HousesLoaded) {
            return ListView(
              padding: const EdgeInsets.all(16.0),
              children: state.houses.map((house) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => HouseDetailPage(house: house),
                        ),
                      );
                    },
                    child: Text(house.name),
                  ),
                );
              }).toList(),
            );
          } else if (state is HousesError) {
            return Center(child: Text(state.message));
          }
          return const Center(child: Text('No data'));
        },
      ),
    );
  }
}

class HouseDetailPage extends StatelessWidget {
  final House house;

  const HouseDetailPage({Key? key, required this.house}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(house.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Founder: ${house.founder}',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8.0),
            Text(
              'Animal: ${house.animal}',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Text(
              'Element: ${house.element}',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Text(
              'Ghost: ${house.ghost}',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Text(
              'Common Room: ${house.commonRoom}',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 16.0),
            Text(
              'Traits:',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            ...house.traits.map((trait) => Text('- ${trait.name}')).toList(),
            const SizedBox(height: 16.0),
            Text(
              'Heads of House:',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            ...house.heads
                .map((head) => Text('- ${head.firstName} ${head.lastName}'))
                .toList(),
          ],
        ),
      ),
    );
  }
}
