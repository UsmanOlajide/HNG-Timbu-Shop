import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:game_haven/models/game.dart';
import 'package:http/http.dart' as http;

const baseUrl = 'https://api.timbu.cloud';

class HomeRepository {
  const HomeRepository();

  Future<List<Game>> fetchGames() async {
    final orgId = dotenv.env['ORGANIZATION_ID'];
    final appID = dotenv.env['APPID'];
    final apiKey = dotenv.env['APIKEY'];
    final url = '$baseUrl/products?organization_id=$orgId&Appid=$appID&Apikey=$apiKey&page=1&size=10';

    try {
      final parsedUrl = Uri.parse(url);
      final response = await http.get(parsedUrl);
      final data = json.decode(response.body);

      final games = (data['items'] as List).cast<Map<String, dynamic>>();
      return games.map(Game.fromMap).toList();
    } catch (e) {
      rethrow;
    }
  }
}

const homeRepo = HomeRepository();
