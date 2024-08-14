import 'package:core/common/state_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/tv_list/tv_list_bloc.dart';
import '../widgets/tv_card_list.dart';

class TopRatedTvSeries extends StatefulWidget {
  static const ROUTE_NAME = '/top-rated-tv';

  const TopRatedTvSeries({super.key});

  @override
  State<TopRatedTvSeries> createState() => _TopRatedTvSeriesState();
}

class _TopRatedTvSeriesState extends State<TopRatedTvSeries> {
  @override
  void initState() {
    super.initState();
    context.read<TvListBloc>().add(OnGetTopRatedTvSeries());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Top Rated Tv'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<TvListBloc, TvListState>(
          builder: (context, state) {
            if (state.status == RequestState.Loading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state.status == RequestState.Error) {
              return Center(child: Text(state.message));
            }
            if (state.status == RequestState.Loaded) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tvData = state.topRatedTv[index];
                  return TvCardList(tvData);
                },
                itemCount: state.topRatedTv.length,
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}
