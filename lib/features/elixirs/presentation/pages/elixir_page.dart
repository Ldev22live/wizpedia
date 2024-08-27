import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wizpedia/features/elixirs/domain/entities/elixir.dart';
import 'package:wizpedia/features/elixirs/presentation/bloc/elixirs_bloc.dart';

class ElixirsPage extends StatelessWidget {
  const ElixirsPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Dispatch LoadElixirs event
    context.read<ElixirsBloc>().add(LoadElixirs());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Elixirs Overview'),
      ),
      body: BlocBuilder<ElixirsBloc, ElixirState>(
        builder: (context, state) {
          if (state is ElixirLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ElixirLoaded) {
            return ListView(
              padding: const EdgeInsets.all(16.0),
              children: state.elixirs.map((elixir) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) =>
                              ElixirDetailPage(elixir: elixir),
                        ),
                      );
                    },
                    child: Text(
                        elixir.name ?? "Unknown Elixir"), // Handle null name
                  ),
                );
              }).toList(),
            );
          } else if (state is ElixirError) {
            return Center(child: Text(state.message ?? 'An error occurred'));
          }
          return const Center(child: Text('No data available'));
        },
      ),
    );
  }
}

class ElixirDetailPage extends StatelessWidget {
  final Elixir elixir;

  const ElixirDetailPage({Key? key, required this.elixir}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(elixir.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Effect: ${elixir.effect ?? "Unknown"}',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8.0),
            Text(
              'Side Effects: ${elixir.sideEffects ?? "None"}',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            if (elixir.characteristics != null &&
                elixir.characteristics!.isNotEmpty) ...[
              const SizedBox(height: 8.0),
              Text(
                'Characteristics: ${elixir.characteristics}',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ],
            if (elixir.time != null && elixir.time!.isNotEmpty) ...[
              const SizedBox(height: 8.0),
              Text(
                'Time: ${elixir.time}',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ],
            const SizedBox(height: 8.0),
            Text(
              'Difficulty: ${elixir.difficulty ?? "Unknown"}',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 16.0),
            Text(
              'Ingredients:',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            if (elixir.ingredients.isNotEmpty) ...[
              ...elixir.ingredients
                  .map((ingredient) => Text('- ${ingredient.name}'))
                  .toList(),
            ] else ...[
              Text('No ingredients listed'),
            ],
            if (elixir.inventors.isNotEmpty) ...[
              const SizedBox(height: 16.0),
              Text(
                'Inventors:',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              ...elixir.inventors
                  .map((inventor) => Text('- $inventor'))
                  .toList(),
            ] else ...[
              Text('No inventors listed'),
            ],
            if (elixir.manufacturer != null &&
                elixir.manufacturer!.isNotEmpty) ...[
              const SizedBox(height: 16.0),
              Text(
                'Manufacturer: ${elixir.manufacturer}',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
