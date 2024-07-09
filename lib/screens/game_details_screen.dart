import 'package:flutter/material.dart';
import 'package:game_haven/models/game.dart';

class GameDetailsScreen extends StatelessWidget {
  const GameDetailsScreen({super.key});

  static const detailsScreen = '/game-details-screen';
  @override
  Widget build(BuildContext context) {
    final game = ModalRoute.of(context)!.settings.arguments as Game;
    
    return Scaffold(
      appBar: AppBar(
        title: Text(
          game.name,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        backgroundColor: Colors.black87,
        foregroundColor: Colors.white,
      ),
      body: LayoutBuilder(builder: (context, constraints) {
        final maxHeight = constraints.maxHeight;
        return SizedBox(
          height: maxHeight,
          child: Column(
            children: [
              Container(
                height: maxHeight * 0.4,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                      game.photoUrls.last,
                    ),
                    fit: BoxFit.cover,
                    filterQuality: FilterQuality.medium
                  ),
                ),
              ),
              Container(
                color: const Color(0xff011c47),
                height: maxHeight * 0.6,
                width: double.infinity,
                child: Container(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        game.formattedPrice,
                        style: const TextStyle(
                          fontSize: 30.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 40.0),
                      const Text(
                        'Synopsis',
                        style: TextStyle(
                          fontSize: 23.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 15.0),
                      Text(
                        game.description,
                        style: const TextStyle(
                          fontSize: 14.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
