import 'dart:io';

import 'package:bloc_app/CharactersListScreen/CharacterModels/CharacterModel.dart';
import 'package:bloc_app/Constants/ErrorMessages.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:bloc_app/Constants/APIConstants.dart';

class MarvelCharactersNetworkManager {
  MarvelCharactersNetworkManager();
  Future<CharactersResponseRootModel> getCharacters(
      String url, Map<String, dynamic> parameters) async {
    Uri uri = Uri.https(URLs.baseUrl, url, parameters);
    http.Response response;
    try {
      response = await http.get(
        uri,
      );
      print(response.body);
      CharactersResponseRootModel charactersResponseRootModel =
          CharactersResponseRootModel.fromJson(jsonDecode(response.body));
      return charactersResponseRootModel;
    } on TimeoutException catch (e) {
      print('${ErrorMessage.requestTimeout} $e');
      return CharactersResponseRootModel(message: ErrorMessage.requestTimeout);
    } on SocketException catch (e) {
      print('Socket Error: $e');
      return CharactersResponseRootModel(
          message: ErrorMessage.noInternetConnection);
    } on Error catch (e) {
      print('General Error: $e');
      CharactersResponseRootModel charactersResponseRootModel =
          CharactersResponseRootModel.fromJson(jsonDecode(response.body));
      return charactersResponseRootModel;
      
    }
  }
}
