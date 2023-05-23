import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tv/tv.dart';
import 'package:ditonton/domain/repositories/tv_repository.dart';

class GetNowPlayingTV {
  TVRepository repository;

  GetNowPlayingTV(this.repository);

  Future<Either<Failure, List<Tv>>> execute() {
    return repository.getNowPlayingTVShows();
  }
}
