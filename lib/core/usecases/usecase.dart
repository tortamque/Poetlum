// ignore_for_file: one_member_abstracts

abstract class UseCase<Type, Params>{
  Future<Type> call({Params params});
}
