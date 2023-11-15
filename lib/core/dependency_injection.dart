import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:poetlum/features/authorization/data/data_sources/remote/firebase_service.dart';
import 'package:poetlum/features/authorization/data/repository/firebase_repository_impl.dart';
import 'package:poetlum/features/authorization/domain/repository/firebase_repository.dart';
import 'package:poetlum/features/authorization/domain/usecases/register_user_usecase.dart';
import 'package:poetlum/features/authorization/presentation/bloc/authorization/auth_cubit.dart';
import 'package:poetlum/features/authorization/presentation/bloc/validation/validation_cubit.dart';
import 'package:poetlum/features/authorization/presentation/bloc/validation/validators.dart';
import 'package:poetlum/features/poems_feed/data/data_sources/remote/poem_api_service.dart';
import 'package:poetlum/features/poems_feed/data/repository/poem_repository_impl.dart';
import 'package:poetlum/features/poems_feed/domain/repository/poem_repository.dart';
import 'package:poetlum/features/poems_feed/domain/usecases/get_poems_usecase.dart';
import 'package:poetlum/features/poems_feed/presentation/bloc/poem/remote/remote_poem_bloc.dart';
import 'package:poetlum/features/realtime_database/domain/entities/database_manager.dart';

GetIt getIt = GetIt.instance;

void initializeDependencies() {
  getIt
    // Database
    ..registerSingleton<DatabaseManager>(DatabaseManager())

    // Dio
    ..registerSingleton<Dio>(Dio())

    // API Service
    ..registerSingleton<PoemApiService>(PoemApiService(getIt()))
    ..registerSingleton<FirebaseService>(FirebaseServiceImpl())

    // Repository
    ..registerSingleton<PoemRepository>(PoemRepositoryImpl(getIt()))
    ..registerSingleton<FirebaseRepository>(FirebaseRepositoryImpl(getIt()))

    // Usecase
    ..registerSingleton<GetPoemsUseCase>(GetPoemsUseCase(getIt()))
    ..registerSingleton<RegisterUserUseCase>(RegisterUserUseCase(getIt()))

    // Validators
    ..registerLazySingleton<UsernameValidator>(() => UsernameValidator())
    ..registerLazySingleton<LocalEmailValidator>(() => LocalEmailValidator())
    ..registerLazySingleton<PasswordValidator>(() => PasswordValidator())

    // Bloc
    ..registerFactory<RemotePoemBloc>(() => RemotePoemBloc(getIt()))
    ..registerFactory<RegisterCubit>(() => RegisterCubit(getIt()))
    ..registerFactory<RegisterFormValidationCubit>(() => RegisterFormValidationCubit(
      usernameValidator: getIt<UsernameValidator>(),
      emailValidator: getIt<LocalEmailValidator>(),
      passwordValidator: getIt<PasswordValidator>(),
    ),);
}
