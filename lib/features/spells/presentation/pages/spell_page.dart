import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wizpedia/features/spells/domain/entities/spell.dart';
import 'package:wizpedia/features/spells/presentation/bloc/spell_bloc.dart';

class SpellsPage extends StatelessWidget {
  const SpellsPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Dispatch LoadSpells event
    context.read<SpellBloc>().add(LoadSpells());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Spells Overview'),
      ),
      body: BlocBuilder<SpellBloc, SpellState>(
        builder: (context, state) {
          if (state is SpellLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is SpellLoaded) {
            return ListView(
              padding: const EdgeInsets.all(16.0),
              children: state.spells.map((spell) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => SpellDetailPage(spell: spell),
                        ),
                      );
                    },
                    child: Text(spell.name ?? "Unknown Spell"),
                  ),
                );
              }).toList(),
            );
          } else if (state is SpellError) {
            return Center(child: Text(state.message ?? 'An error occurred'));
          }
          return const Center(child: Text('No data available'));
        },
      ),
    );
  }
}

class SpellDetailPage extends StatelessWidget {
  final Spell spell;

  const SpellDetailPage({required this.spell, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(spell.name ?? "Unknown Spell"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Incantation: ${spell.incantation ?? "N/A"}',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8.0),
            Text(
              'Effect: ${spell.effect ?? "N/A"}',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 8.0),
            Text(
              'Type: ${spell.type ?? "N/A"}',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 8.0),
            Text(
              'Light: ${spell.light ?? "N/A"}',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 8.0),
            Text(
              'Can Be Verbal: ${spell.canBeVerbal ?? false ? "Yes" : "No"}',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
      ),
    );
  }
}
