import 'package:flutter/material.dart';
import 'package:movie/model/movie/index.dart';

class CommonProvider extends ChangeNotifier {
  List<MovieModel> movies = [];
  List<int> whishListIds = [];
  int currentIdx = 0;
  bool isLoggedIn = false;

  List<MovieModel> get specialData => movies.length > 3 ? movies.sublist(0, 3) : movies;

  void setMovies(List<MovieModel> data) {
    movies = data;
    notifyListeners();
  }

  List<MovieModel> get wishMovies => movies.where((element) => isWishMovies(element)).toList();

  void addWishList(int id) {
    if (whishListIds.contains(id)) {
      whishListIds.remove(id);
    } else {
      whishListIds.add(id);
    }
    notifyListeners();
  }

  bool isWishMovies(MovieModel data) {
    return whishListIds.any((element) => element == data.id);
  }

  void changeCurrentIdx(int idx) {
    currentIdx = idx;
    notifyListeners();
  }

  void onLogin() {
    isLoggedIn = true;
    notifyListeners();
  }

  void onLogout() {
    isLoggedIn = false;
    notifyListeners();
  }
}
