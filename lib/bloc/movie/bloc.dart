import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/bloc/movie/event.dart';
import 'package:movie/bloc/movie/states.dart';
import 'package:movie/global_keys.dart';
import 'package:movie/model/movie/index.dart';
import 'package:provider/provider.dart';

import '../../providers/common.dart';
import '../../services/api/index.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  MovieBloc() : super(MovieInitial()) {
    on<MovieGetAll>((event, emit) async {
      if (Provider.of<CommonProvider>(GlobalKeys.navigatorKey.currentContext!, listen: false).movies.isEmpty) {
        emit(MovieLoading());
        try {
          final api = ApiService();
          final res = await api.getRequest('/64bcb1db8e4aa6225ec21998', true);
          print(res.data);
          List<MovieModel> data = MovieModel.fromList(res.data['record']);
          Provider.of<CommonProvider>(GlobalKeys.navigatorKey.currentContext!, listen: false).setMovies(data);
          emit(MovieSuccess());
        } catch (ex) {
          print(ex);
          emit(MovieFailure(ex.toString()));
        }
      }
    });
    on<MovieGetInfo>((event, emit) async {
      emit(MovieLoading());
      try {
        final api = ApiService();
        final res = await api.getRequest('/64bcb94a8e4aa6225ec21b83', true);
        print(res.data);
        MovieModel data = MovieModel.fromJson(res.data['record']);
        emit(MovieSuccessDetail(data));
      } catch (ex) {
        print(ex);
        emit(MovieFailure(ex.toString()));
      }
    });
  }
}
