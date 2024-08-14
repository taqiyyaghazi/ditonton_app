import 'package:core/common/state_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/tv_list/tv_list_bloc.dart';
import '../widgets/tv_card_list.dart';

class OnAirTvPage extends StatefulWidget {
  static const ROUTE_NAME = '/on-air-tv-page';

  const OnAirTvPage({super.key});

  @override
  State<OnAirTvPage> createState() => _OnAirTvPageState();
}

class _OnAirTvPageState extends State<OnAirTvPage> {
  @override
  void initState() {
    super.initState();
    context.read<TvListBloc>().add(OnGetOnTheAirTvSeries());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Popular Tv'),
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
                  final tvData = state.onTheAirTv[index];
                  return TvCardList(tvData);
                },
                itemCount: state.onTheAirTv.length,
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}
