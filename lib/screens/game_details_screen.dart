import 'package:flutter/material.dart';
import 'package:fullscreen_image_viewer/fullscreen_image_viewer.dart';
import 'package:lati_game_app/helpers/const.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lati_game_app/providers/games_providers.dart';
import 'package:lati_game_app/widget/cards/game_card.dart';
import 'package:provider/provider.dart';

class GameDetailsScreen extends StatefulWidget {
  const GameDetailsScreen({super.key, required this.gameId});
  final int gameId;
  @override
  State<GameDetailsScreen> createState() => _GameDetailsScreenState();
}

class _GameDetailsScreenState extends State<GameDetailsScreen> {
  @override
  void initState() {
    Provider.of<GamesProviders>(context, listen: false)
        .fetchGameById(widget.gameId);
    super.initState();
  }

  bool isShowMore = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Consumer<GamesProviders>(builder: (context, gamesConsumer, _) {
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            gamesConsumer.gameDetailsModel == null
                ? "loading..."
                : gamesConsumer.gameDetailsModel!.title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        body: Center(
          child: gamesConsumer.busy &&
                  gamesConsumer.gameDetailsModel == null
              ? const CircularProgressIndicator()
              : SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: Image.network(
                                width: size.width,
                                gamesConsumer.gameDetailsModel!.thumbnail,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Positioned(
                                top: 16,
                                right: 16,
                                child: Row(
                                  children: [
                                    if (gamesConsumer.gameDetailsModel!.platform
                                        .toUpperCase()
                                        .contains("Windows".toUpperCase()))
                                      const Icon(
                                        FontAwesomeIcons.computer,
                                        color: Colors.white,
                                        size: 32,
                                      ),
                                    const SizedBox(
                                      width: 16,
                                    ),
                                    if (gamesConsumer.gameDetailsModel!.platform
                                        .toUpperCase()
                                        .contains("Web".toUpperCase()))
                                      const Icon(
                                        FontAwesomeIcons.globe,
                                        color: Colors.white,
                                        size: 32,
                                      ),
                                  ],
                                ))
                          ],
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Text(
                            gamesConsumer.gameDetailsModel!.title,
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Text(
                            gamesConsumer.gameDetailsModel!.shortDescription,
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.normal),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                gamesConsumer.gameDetailsModel!.description,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                                maxLines: isShowMore ? 50 : 3,
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isShowMore = !isShowMore;
                                  });
                                },
                                child: Text(
                                  isShowMore
                                      ? "show less..."
                                      : "...show more...",
                                  style: const TextStyle(
                                      fontSize: 16,
                                      color: blueColor,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        ),
                        GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: gamesConsumer
                              .gameDetailsModel!.screenshots.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            mainAxisSpacing: 8,
                            crossAxisSpacing: 8,
                            crossAxisCount: 2,
                          ),
                          itemBuilder: (context, index) {
                            return ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: GestureDetector(
                                onTap: () {
                                  FullscreenImageViewer.open(
                                    context: context,
                                    child: Hero(
                                      tag: 'hero$index',
                                      child: Image.network(gamesConsumer
                                          .gameDetailsModel!
                                          .screenshots[index]
                                          .image),
                                    ),
                                  );
                                },
                                child: Hero(
                                  tag: 'hero$index',
                                  child: Image.network(
                                    gamesConsumer.gameDetailsModel!
                                        .screenshots[index].image,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        if (gamesConsumer
                                .gameDetailsModel!.minimumSystemRequirements !=
                            null)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Minumum System Requirements",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 24),
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              Text(
                                "OS : ${gamesConsumer.gameDetailsModel!.minimumSystemRequirements!.os}",
                                style: const TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w600),
                              ),
                              Text(
                                "MEMORY : ${gamesConsumer.gameDetailsModel!.minimumSystemRequirements!.memory}",
                                style: const TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w600),
                              ),
                              Text(
                                "PROCESSOR : ${gamesConsumer.gameDetailsModel!.minimumSystemRequirements!.processor}",
                                style: const TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w600),
                              ),
                              Text(
                                "GRAPHICS : ${gamesConsumer.gameDetailsModel!.minimumSystemRequirements!.graphics}",
                                style: const TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w600),
                              ),
                              Text(
                                "STORAGE : ${gamesConsumer.gameDetailsModel!.minimumSystemRequirements!.storage}",
                                style: const TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        const SizedBox(
                          height: 16,
                        ),
                        const Text(
                          "Similar Games",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 24),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        SizedBox(
                          height: size.height * 0.33,
                          child: ListView.builder(
                            shrinkWrap: true,
                            physics: const AlwaysScrollableScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            itemCount: gamesConsumer.similarGames.length,
                            itemBuilder: (context, index) => SizedBox(
                              width: size.width * 0.5,
                              height: 150,
                              child: Padding(
                                padding: const EdgeInsets.only(right: 16),
                                child: SizedBox(
                                  height: 100,
                                  width: 200,
                                  child: GameCard(
                                    gameModel:
                                        gamesConsumer.similarGames[index],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                      ],
                    ),
                  ),
                ),
        ),
      );
    });
  }
}
