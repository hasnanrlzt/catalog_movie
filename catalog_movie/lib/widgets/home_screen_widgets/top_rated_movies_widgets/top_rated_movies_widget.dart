import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:catalog_movie/bloc/theme_bloc/theme_controller.dart';
import 'package:catalog_movie/repositories/movie_repository.dart';
import 'top_rated_movies_list.dart';

class TopRatedMoviesWidget extends StatefulWidget {
  const TopRatedMoviesWidget(
      {Key? key, required this.themeController, required this.movieRepository})
      : super(key: key);

  final ThemeController themeController;
  final MovieRepository movieRepository;

  @override
  // ignore: library_private_types_in_public_api
  _TopRatedMoviesWidgetState createState() => _TopRatedMoviesWidgetState();
}

class _TopRatedMoviesWidgetState extends State<TopRatedMoviesWidget> {
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: widget.movieRepository,
      child: TopRatedMoviesList(
        themeController: widget.themeController,
        movieRepository: widget.movieRepository,
      ),
    );
  }
}
