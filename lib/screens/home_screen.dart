import 'package:flutter/material.dart';
import 'package:game_haven/data/home_repository.dart';
import 'package:game_haven/models/game.dart';
import 'package:game_haven/screens/game_details_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Game>> _repo;

  List<Game> _trendingGames(List<Game> games) {
    final shuffledGames = games.toList()..shuffle();
    return shuffledGames;
  }

  void navigate(Game game) {
    Navigator.pushNamed(
      context,
      GameDetailsScreen.detailsScreen,
      arguments: game,
    );
  }

  @override
  void initState() {
    super.initState();
    _repo = homeRepo.fetchGames();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black12,
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'GAME HAVEN',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
                letterSpacing: 8.0,
              ),
            ),
            SizedBox(
              width: 40.0,
              child: Icon(Icons.gamepad_rounded),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: FutureBuilder(
          future: _repo,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final games = snapshot.data!;
              final randomGames = _trendingGames(games);

              return Padding(
                padding: const EdgeInsets.only(
                  top: 23.0,
                  left: 15.0,
                  right: 15.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'TRENDING THIS WEEK',
                      style: TextStyle(
                        fontSize: 22.0,
                        fontWeight: FontWeight.bold,
                        height: 0.0,
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    SizedBox(
                      height: 200.0,
                      child: PageView.builder(
                        itemCount: randomGames.length,
                        itemBuilder: (_, i) {
                          return GestureDetector(
                            onTap: () => navigate(randomGames[i]),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.0),
                                image: DecorationImage(
                                  image: NetworkImage(
                                    randomGames[i].photoUrls.last,
                                  ),
                                  fit: BoxFit.cover,
                                  filterQuality: FilterQuality.low,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 50.0),
                    const Text(
                      'TOP PICKS',
                      style: TextStyle(
                        fontSize: 22.0,
                        fontWeight: FontWeight.bold,
                        height: 0.0,
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    Expanded(
                      child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          childAspectRatio: 0.8,
                          crossAxisCount: 2,
                          mainAxisSpacing: 10.0,
                          crossAxisSpacing: 15.0,
                        ),
                        itemCount: games.length,
                        itemBuilder: (_, i) {
                          final game = games[i];
                          return GestureDetector(
                            onTap: () => navigate(game),
                            child: TopPicks(game: game),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );
            }
            if (snapshot.hasError) {
              return const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.cancel_outlined,
                      size: 100.0,
                      color: Colors.red,
                    ),
                    Text('Oops! Check your internet connection'),
                  ],
                ),
              );
            }
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          },
        ),
      ),
    );
  }
}

class TopPicks extends StatelessWidget {
  const TopPicks({super.key, required this.game});
  final Game game;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 190,
      margin: const EdgeInsets.only(bottom: 10.0),
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final maxHeight = constraints.maxHeight;
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                // color: Colors.red,
                height: maxHeight * 0.6,
                child: Image.network(
                  game.photoUrls.first,
                  fit: BoxFit.cover,
                  filterQuality: FilterQuality.low,
                ),
              ),
              SizedBox(
                // color: Colors.blue,
                height: maxHeight * 0.4,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const SizedBox(height: 5.0),
                    Text(
                      game.name,
                      style: const TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      game.formattedPrice,
                      style: const TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w400,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    // const SizedBox(height: .0),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
