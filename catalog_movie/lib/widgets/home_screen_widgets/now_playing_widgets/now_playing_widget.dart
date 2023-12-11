import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:catalog_movie/bloc/theme_bloc/theme_controller.dart';
import 'package:catalog_movie/repositories/movie_repository.dart';

import 'now_playing_list.dart';

class NowPlayingWidget extends StatefulWidget {
  const NowPlayingWidget(
      {Key? key, required this.themeController, required this.movieRepository})
      : super(key: key);

  final ThemeController themeController;
  final MovieRepository movieRepository;

  @override
  // ignore: library_private_types_in_public_api
  _NowPlayingWidgetState createState() => _NowPlayingWidgetState();
}

class _NowPlayingWidgetState extends State<NowPlayingWidget> {
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: widget.movieRepository,
      child: NowPlayingList(
        themeController: widget.themeController,
        movieRepository: widget.movieRepository,
      ),
    );
  }
}
