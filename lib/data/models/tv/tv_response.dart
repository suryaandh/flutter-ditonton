import 'package:ditonton/data/models/tv/tv_model.dart';
import 'package:equatable/equatable.dart';

class TVResponse extends Equatable {
  final List<TvModel> tvShowList;

  TVResponse({required this.tvShowList});

  factory TVResponse.fromJson(Map<String, dynamic> json) => TVResponse(
        tvShowList: List<TvModel>.from((json['results'] as List)
            .map((x) => TvModel.fromJson(x))
            .where((element) => element.backdropPath != null)),
      );

  Map<String, dynamic> toJson() => {
        "results": List<dynamic>.from(tvShowList.map((e) => e.toJson())),
      };

  @override
  List<Object?> get props => [tvShowList];
}
