import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:lati_game_app/models/detailed_game_model.dart';
import 'package:lati_game_app/models/game_model.dart';
import 'package:lati_game_app/providers/base_provider.dart';
import 'package:lati_game_app/services/api.dart';

class GamesProviders extends BaseProvider {
  Api api = Api();
  
  List<GameModel> games = [];
  fetchGames(String platform) async {
    setBusy(true);
    games.clear();
    final response = await api
        .get("https://www.freetogame.com/api/games?platform=$platform");

    if (response.statusCode == 200) {
      var decodedData = json.decode(response.body);

      games = List<GameModel>.from(
          decodedData.map((e) => GameModel.fromJson(e)).toList());

      setBusy(false);
    }
  }

  //--------------------------Detailed Game------------------------
  DetailedGameModel? gameDetailsModel;
  fetchGameById(int id) async {
    setBusy(true);
    
    //games.clear();
    final response =
        await api.get(("https://www.freetogame.com/api/game?id=${id}"));

    if (response.statusCode == 200) {
      var decodedData = json.decode(response.body);

      gameDetailsModel = DetailedGameModel.fromJson(decodedData);
      getGamesByCategory(gameDetailsModel!.genre);

      setBusy(false);
    }
  }

  //--------------------------Similar Games------------------------
  List<GameModel> similarGames = [];
  getGamesByCategory(String category) async {
    setBusy(true);

    similarGames.clear();
    final response =
        await api.get("https://www.freetogame.com/api/games?category=$category");

    if (response.statusCode == 200) {
      var decodedData = json.decode(response.body);

      similarGames =
          List<GameModel>.from(decodedData.map((e) => GameModel.fromJson(e)))
              .toList();
      
      setBusy(false);
    }
  }
}
