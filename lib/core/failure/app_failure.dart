abstract class AppFailure {}

class NetworkFailure extends AppFailure {}

class ServerFailure extends AppFailure {}

class EmptyCacheFailure extends AppFailure {}

class WrongDataFailure extends AppFailure {}

class EmptyDataFailure extends AppFailure {}

class HandelErrorMsg {
  static String mapErrorMsg(AppFailure failure) {
    switch (failure.runtimeType) {
      case NetworkFailure:
        return 'network error';

      case ServerFailure:
        return 'server data error';

      case EmptyDataFailure:
        return 'No Data Fount';

      case WrongDataFailure:
        return 'Dose not exsist ';
      default:
        return 'No Data Fount';
    }
  }
}
