import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/common/state_enum.dart';
import 'package:core/style/colors_style.dart';
import 'package:core/style/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../domain/entities/genre.dart';
import '../../domain/entities/tv_detail_entities.dart';
import '../../domain/entities/tv_entities.dart';
import '../bloc/tv_detail/tv_detail_bloc.dart';

class TvDetailPage extends StatefulWidget {
  static const ROUTE_NAME = '/detail_tv';

  final int id;
  const TvDetailPage({super.key, required this.id});

  @override
  State<TvDetailPage> createState() => _TvDetailPageState();
}

class _TvDetailPageState extends State<TvDetailPage> {
  final GlobalKey<ScaffoldMessengerState> _scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();
  final GlobalKey<ScaffoldState> _scaffoldStateKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    context.read<TvDetailBloc>()
      ..add(OnFetchTvDetail(widget.id))
      ..add(OnLoadWatchlistStatusTv(widget.id));
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      key: _scaffoldMessengerKey,
      child: Scaffold(
        key: _scaffoldStateKey,
        body: BlocConsumer<TvDetailBloc, TvDetailState>(
          builder: (context, state) {
            if (state.statusTvDetail == RequestState.Loading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state.statusTvDetail == RequestState.Error) {
              return Center(child: Text(state.message));
            }
            if (state.statusTvDetail == RequestState.Loaded) {
              return SafeArea(
                child: DetailTvContent(
                  state.tvDetailEntities!,
                  state.tvRecommendations,
                  state.isAddedtoWatchlist,
                ),
              );
            }
            return const SizedBox();
          },
          listenWhen: (previous, current) {
            return previous.watchlistMessage != current.watchlistMessage &&
                current.watchlistMessage != '';
          },
          listener: (context, state) {
            final message = state.watchlistMessage;
            if (message == TvDetailBloc.watchlistAddSuccessMessage ||
                message == TvDetailBloc.watchlistRemoveSuccessMessage) {
              _scaffoldMessengerKey.currentState!.showSnackBar(
                SnackBar(
                  content: Text(message),
                ),
              );
            } else {
              showDialog(
                context: context,
                builder: (_) {
                  return AlertDialog(
                    content: Text(message),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}

class DetailTvContent extends StatelessWidget {
  final TvDetailEntities tv;
  final List<TvEntities> recommendations;
  final bool isAddedWatchlist;

  const DetailTvContent(
    this.tv,
    this.recommendations,
    this.isAddedWatchlist, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final bloc = context.read<TvDetailBloc>();
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl: 'https://image.tmdb.org/t/p/w500${tv.posterPath}',
          width: screenWidth,
          placeholder: (context, url) => const Center(
            child: CircularProgressIndicator(),
          ),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
        Container(
          margin: const EdgeInsets.only(top: 48 + 8),
          child: DraggableScrollableSheet(
            builder: (context, scrollController) {
              return Container(
                decoration: const BoxDecoration(
                  color: kRichBlack,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                padding: const EdgeInsets.only(
                  left: 16,
                  top: 16,
                  right: 16,
                ),
                child: Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 16),
                      child: SingleChildScrollView(
                        controller: scrollController,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              tv.name ?? '',
                              style: kHeading5,
                            ),
                            ElevatedButton(
                              onPressed: () async {
                                if (!isAddedWatchlist) {
                                  bloc.add(OnAddWatchlistTv(tv));
                                } else {
                                  bloc.add(OnRemoveFromWatchlistTv(tv));
                                }
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  isAddedWatchlist
                                      ? const Icon(Icons.check)
                                      : const Icon(Icons.add),
                                  const Text('Watchlist'),
                                ],
                              ),
                            ),
                            Text(
                              _showGenres(tv.genres),
                            ),
                            Row(
                              children: [
                                RatingBarIndicator(
                                  rating: tv.voteAverage! / 2,
                                  itemCount: 5,
                                  itemBuilder: (context, index) => const Icon(
                                    Icons.star,
                                    color: kMikadoYellow,
                                  ),
                                  itemSize: 24,
                                ),
                                Text('${tv.voteAverage}')
                              ],
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Overview',
                              style: kHeading6,
                            ),
                            Text(
                              tv.overview ?? '',
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Recommendations',
                              style: kHeading6,
                            ),
                            _recommendationList(),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        color: Colors.white,
                        height: 4,
                        width: 48,
                      ),
                    ),
                  ],
                ),
              );
            },
            // initialChildSize: 0.5,
            minChildSize: 0.25,
            // maxChildSize: 1.0,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: kRichBlack,
            foregroundColor: Colors.white,
            child: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        )
      ],
    );
  }

  Widget _recommendationList() {
    return BlocBuilder<TvDetailBloc, TvDetailState>(
      builder: (context, state) {
        if (state.statusTvRecommendations == RequestState.Loading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state.statusTvRecommendations == RequestState.Error) {
          return Text(state.message);
        }
        if (state.statusTvRecommendations == RequestState.Loaded) {
          return SizedBox(
            height: 150,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final tvData = state.tvRecommendations[index];
                return Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.pushReplacementNamed(
                        context,
                        TvDetailPage.ROUTE_NAME,
                        arguments: tvData.id,
                      );
                    },
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(8),
                      ),
                      child: CachedNetworkImage(
                        imageUrl:
                            'https://image.tmdb.org/t/p/w500${tvData.posterPath}',
                        placeholder: (context, url) => const Center(
                          child: CircularProgressIndicator(),
                        ),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                    ),
                  ),
                );
              },
              itemCount: state.tvRecommendations.length,
            ),
          );
        }
        return const SizedBox();
      },
    );
  }

  String _showGenres(List<Genre> genres) {
    String result = '';
    for (var genre in genres) {
      result += '${genre.name}, ';
    }

    if (result.isEmpty) {
      return result;
    }

    return result.substring(0, result.length - 2);
  }
}
