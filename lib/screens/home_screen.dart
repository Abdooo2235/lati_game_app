import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lati_game_app/clickables.dart/drawer_title.dart';
import 'package:lati_game_app/helpers/const.dart';
import 'package:lati_game_app/providers/dark_mode_provider.dart';
import 'package:lati_game_app/providers/games_providers.dart';
import 'package:lati_game_app/widget/cards/game_card.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int nowIndex = 0;

  @override
  void initState() {
    Provider.of<GamesProviders>(context, listen: false).fetchGames("all");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GamesProviders>(builder: (context, gamesConsumer, _) {
      return Consumer<DarkModeProvider>(
        builder: (context, darkModeConsumer, _) {
          return Scaffold(
            appBar: AppBar(),
            drawer: Drawer(
              child: Column(
                children: [
                  DrawerTile(
                    icon: darkModeConsumer.isDark
                        ? Icons.dark_mode
                        : Icons.light_mode,
                    text: darkModeConsumer.isDark ? "Dark Mode" : "Light Mode",
                    onTab: () {
                      Provider.of<DarkModeProvider>(context, listen: false)
                          .switchMode();
                    },
                  ),
                ],
              ),
            ),
            body: Center(
              child: GridView.builder(
                itemCount:
                    gamesConsumer.busy ? 6 : gamesConsumer.games.length,
                padding: const EdgeInsets.all(16),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 0.7,
                  crossAxisCount: 2,
                ),
                itemBuilder: (context, index) {
                  return AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    child: gamesConsumer.busy
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Shimmer.fromColors(
                              baseColor: Colors.black12,
                              highlightColor: Colors.white38,
                              child: Container(
                                color: Colors.white,
                                height: double.infinity,
                                width: double.infinity,
                              ),
                            ),
                          )
                        : GameCard(gameModel: gamesConsumer.games[index]),
                  );
                },
              ),
            ),
            bottomNavigationBar: BottomNavigationBar(
              backgroundColor:
                  darkModeConsumer.isDark ? Colors.black : Colors.white,
              selectedItemColor: blueColor,
              selectedLabelStyle:
                  GoogleFonts.roboto(fontWeight: FontWeight.bold),
              unselectedLabelStyle: GoogleFonts.roboto(
                  fontWeight: FontWeight.normal, fontSize: 12),
              onTap: (currentIndex) {
                setState(() {
                  nowIndex = currentIndex;
                });

                gamesConsumer.fetchGames(currentIndex == 0
                    ? "all"
                    : currentIndex == 1
                        ? "pc"
                        : "browser");
              },
              currentIndex: nowIndex,
              items: const [
                BottomNavigationBarItem(
                    label: "All", icon: Icon(FontAwesomeIcons.gamepad)),
                BottomNavigationBarItem(
                    label: "PC", icon: Icon(FontAwesomeIcons.computer)),
                BottomNavigationBarItem(
                    label: "WEB", icon: Icon(FontAwesomeIcons.globe)),
              ],
            ),
          );
        },
      );
    });
  }
}
