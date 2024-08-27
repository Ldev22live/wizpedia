import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:wizpedia/features/elixirs/domain/entities/elixir.dart';
import 'package:wizpedia/features/elixirs/domain/repositories/elixir_repository.dart';
import 'package:wizpedia/features/elixirs/data/models/elixir_model.dart';

class ElixirRepositoryImpl implements ElixirRepository {
  final http.Client client;

  ElixirRepositoryImpl(this.client);

  @override
  Future<List<Elixir>> getElixirs() async {
    final response = await client
        .get(Uri.parse('https://wizard-world-api.herokuapp.com/Elixirs'));

    if (response.statusCode == 200) {
      try {
        // Print raw JSON data
        final List<dynamic> data = jsonDecode(response.body);
        print('Raw JSON data: $data'); // Debug: Check the format

        // Parse JSON data
        return data.map((json) {
          try {
            return ElixirModel.fromJson(json as Map<String, dynamic>);
          } catch (e) {
            print(
                'Error parsing JSON to ElixirModel: $e'); // Debug: Catch parsing errors
            rethrow;
          }
        }).toList();
      } catch (e) {
        print('Error decoding JSON: $e'); // Debug: Catch JSON decoding errors
        throw Exception('Failed to decode JSON ' + e.toString());
      }
    } else {
      print('Failed to load elixirs: ${response.statusCode}');
      throw Exception('Failed to load elixirs');
    }
  }
}
