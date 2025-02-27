abstract class UseCase<T, Params> {
  Future<T> call(Params params) async {
    try {
      return await call(params);
    } catch (e) {
      throw Exception(e);
    }
  }
}
