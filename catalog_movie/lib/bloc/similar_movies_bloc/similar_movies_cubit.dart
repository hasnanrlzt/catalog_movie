import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:catalog_movie/model/movie.dart';
import 'package:catalog_movie/repositories/movie_repository.dart';
part 'similar_movies_state.dart';

class SimilarMoviesCubit extends Cubit<SimilarMoviesState> {
  SimilarMoviesCubit({required this.repository})
      : super(const SimilarMoviesState.loading());

  final MovieRepository repository;

  Future<void> fetchList(int movieId) async {
    try {
      final movieResponse = await repository.getSimilarMovies(movieId);
      emit(SimilarMoviesState.success(movieResponse.movies));
    } on Exception {
      emit(const SimilarMoviesState.failure());
    }
  }
}