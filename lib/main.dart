import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:wizpedia/features/elixirs/presentation/pages/elixir_page.dart';
import 'package:wizpedia/features/spells/presentation/pages/spell_page.dart';
import 'features/elixirs/data/repositories/elixir_repository_impl.dart';
import 'features/elixirs/domain/usecase/get_elixirs_usecase.dart';
import 'features/elixirs/presentation/bloc/elixirs_bloc.dart';
import 'features/houses/data/repositories/house_repository_impl.dart';
import 'features/houses/domain/usecase/get_houses_usecase.dart';
import 'features/houses/presentation/bloc/houses_bloc.dart';
import 'features/houses/presentation/pages/houses_page.dart';
import 'features/spells/data/repositories/spell_repository_impl.dart';
import 'features/spells/domain/usecase/get_spells_usecase.dart';
import 'features/spells/presentation/bloc/spell_bloc.dart';

void main() {
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => HousesBloc(
            GetHousesUseCase(HouseRepositoryImpl(http.Client())),
          ),
        ),
        BlocProvider(
          create: (context) => ElixirsBloc(
            GetElixirsUseCase(ElixirRepositoryImpl(http.Client())),
          ),
        ),
        BlocProvider(
          create: (context) => SpellBloc(
            GetSpellsUseCase(SpellRepositoryImpl(http.Client())),
          ),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wizard World App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Wizard World Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  final TextEditingController _searchController = TextEditingController();

  void _onSearch() {
    String query = _searchController.text;
    if (query.isNotEmpty) {
      BlocProvider.of<HousesBloc>(context).add(SearchHousesEvent(query));
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const HousesPage(),
        ),
      );
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    if (_selectedIndex == 0) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const HousesPage(),
        ),
      );
    } else if (_selectedIndex == 1) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const ElixirsPage(),
        ),
      );
    } else if (_selectedIndex == 2) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const SpellsPage(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                controller: _searchController,
                decoration: const InputDecoration(
                  hintText: 'Enter search term...',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _onSearch,
                child: const Text('Search'),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Houses',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_drink),
            label: 'Elixirs',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'Spells',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
