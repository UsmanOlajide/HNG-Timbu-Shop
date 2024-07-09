import 'dart:convert';

import 'package:intl/intl.dart';

class Game {
  Game({
    required this.name,
    required this.description,
    required this.id,
    required this.photoUrls,
    required this.price,
  });

  final String name;
  final String description;
  final String id;
  final List<String> photoUrls;
  final Map<String, dynamic> price;

  @override
  String toString() {
    return 'Game(name: $name, description: $description, id: $id)';
  }

  factory Game.fromMap(Map<String, dynamic> map) {
    return Game(
      name: map['name'] as String,
      description: map['description'] as String,
      id: map['id'] as String,
      photoUrls: (map['photos'] as List).map((photo) {
        return '$imageUrl/${photo['url']}';
      }).toList(),
      price: ((map['current_price'] ?? []) as List).firstOrNull ?? {},
    );
  }

  String get formattedPrice {
    var newFormattedPrice = '';
    final currencyFormat = NumberFormat.currency(
      locale: 'en_NG',
      symbol: '₦',
      decimalDigits: 2,
    );
    price.forEach(
      (key, value) {
        newFormattedPrice =
            currencyFormat.format((value as List).first as double);
      },
    );
    return newFormattedPrice;
  }

  factory Game.fromJson(String source) =>
      Game.fromMap(json.decode(source) as Map<String, dynamic>);
}

const imageUrl = 'https://api.timbu.cloud/images';
