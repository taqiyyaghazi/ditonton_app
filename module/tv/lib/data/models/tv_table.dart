import 'package:equatable/equatable.dart';

import '../../domain/entities/tv_detail_entities.dart';
import '../../domain/entities/tv_entities.dart';

class TvTable extends Equatable {
  final int id;
  final String? name;
  final String? posterPath;
  final String? overview;

  const TvTable({
    required this.id,
    required this.overview,
    required this.posterPath,
    required this.name,
  });

  factory TvTable.fromEntity(TvDetailEntities tv) => TvTable(
        id: tv.id,
        overview: tv.overview,
        posterPath: tv.posterPath,
        name: tv.name,
      );

  factory TvTable.fromMap(Map<String, dynamic> map) => TvTable(
        id: map['id'],
        overview: map['overview'],
        posterPath: map['posterPath'],
        name: map['name'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'posterPath': posterPath,
        'overview': overview,
      };

  TvEntities toEntity() => TvEntities.watchlist(
        id: id,
        overview: overview,
        posterPath: posterPath,
        name: name,
      );

  @override
  List<Object?> get props => [id, overview, name, posterPath];
}
