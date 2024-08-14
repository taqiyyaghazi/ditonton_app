import 'package:equatable/equatable.dart';

import 'tv_model.dart';

class TvResponseModel extends Equatable {
  final List<TvModel> tvList;

  const TvResponseModel({required this.tvList});

  factory TvResponseModel.fromJson(Map<String, dynamic> json) =>
      TvResponseModel(
        tvList: List<TvModel>.from((json['results'] as List)
            .map((x) => TvModel.fromJson(x))
            .where((element) => element.posterPath != null)),
      );

  Map<String, dynamic> toJson() => {
        'results': List<dynamic>.from(tvList.map((e) => e.toJson())),
      };

  @override
  List<Object> get props => [tvList];
}
