import 'package:core/common/state_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/tv_list/tv_list_bloc.dart';
import '../widgets/show_heading.dart';
import '../widgets/tv_list.dart';
import 'on_air_tv_page.dart';
import 'popular_tv_page.dart';
import 'top_rated_tv_page.dart';

class HomeTvPage extends StatefulWidget {
  const HomeTvPage({super.key});

  @override
  State<HomeTvPage> createState() => _HomeTvPageState();
}

class _HomeTvPageState extends State<HomeTvPage> {
  @override
  void initState() {
    super.initState();
    context.read<TvListBloc>()
      ..add(OnGetOnTheAirTvSeries())
      ..add(OnGetPopularTvSeries())
      ..add(OnGetTopRatedTvSeries());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildSubHeading(
                title: 'Popular',
                onTap: () {
                  Navigator.pushNamed(context, OnAirTvPage.ROUTE_NAME);
                },
              ),
              BlocBuilder<TvListBloc, TvListState>(
                builder: (context, state) {
                  if (state.status == RequestState.Loading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (state.status == RequestState.Error) {
                    return Center(child: Text(state.message));
                  }
                  if (state.status == RequestState.Loaded) {
                    return TvList(state.onTheAirTv);
                  }
                  return const SizedBox();
                },
              ),
              buildSubHeading(
                title: 'Popular',
                onTap: () {
                  Navigator.pushNamed(context, PopulatTvSeriesPage.ROUTE_NAME);
                },
              ),
              BlocBuilder<TvListBloc, TvListState>(
                builder: (context, state) {
                  if (state.status == RequestState.Loading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (state.status == RequestState.Error) {
                    return Center(child: Text(state.message));
                  }
                  if (state.status == RequestState.Loaded) {
                    return TvList(state.popularTv);
                  }
                  return const SizedBox();
                },
              ),
              buildSubHeading(
                title: 'Top Rated',
                onTap: () {
                  Navigator.pushNamed(context, TopRatedTvSeries.ROUTE_NAME);
                },
              ),
              BlocBuilder<TvListBloc, TvListState>(
                builder: (context, state) {
                  if (state.status == RequestState.Loading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (state.status == RequestState.Error) {
                    return Center(child: Text(state.message));
                  }
                  if (state.status == RequestState.Loaded) {
                    return TvList(state.topRatedTv);
                  }
                  return const SizedBox();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
