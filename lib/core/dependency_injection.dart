import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:poetlum/features/authorization/data/data_sources/remote/firebase_service.dart';
import 'package:poetlum/features/authorization/data/repository/auth_repository_impl.dart';
import 'package:poetlum/features/authorization/data/repository/firebase_repository_impl.dart';
import 'package:poetlum/features/authorization/domain/repository/auth_repository.dart';
import 'package:poetlum/features/authorization/domain/repository/firebase_repository.dart';
import 'package:poetlum/features/authorization/domain/usecases/login/login_user_usecase.dart';
import 'package:poetlum/features/authorization/domain/usecases/register/register_user_usecase.dart';
import 'package:poetlum/features/authorization/presentation/bloc/authorization/auth_cubit.dart';
import 'package:poetlum/features/authorization/presentation/bloc/validation/validation_cubit.dart';
import 'package:poetlum/features/authorization/presentation/bloc/validation/validators.dart';
import 'package:poetlum/features/poems_feed/data/data_sources/remote/poem_api_service.dart';
import 'package:poetlum/features/poems_feed/data/repository/poem_repository_impl.dart';
import 'package:poetlum/features/poems_feed/data/repository/user_repository_impl.dart';
import 'package:poetlum/features/poems_feed/domain/repository/poem_repository.dart';
import 'package:poetlum/features/poems_feed/domain/repository/user_repository.dart';
import 'package:poetlum/features/poems_feed/domain/usecases/get_poems_usecase.dart';
import 'package:poetlum/features/poems_feed/presentation/bloc/poem/remote/remote_poem_bloc.dart';
import 'package:poetlum/features/realtime_database/domain/entities/database_manager.dart';
import 'package:poetlum/features/saved_poems/data/data_sources/remote/firebase_api_service.dart';
import 'package:poetlum/features/saved_poems/data/repository/firebase_db_repository_impl.dart';
import 'package:poetlum/features/saved_poems/domain/repository/firebase_db_repository.dart';
import 'package:poetlum/features/saved_poems/domain/usecases/get_user_poems_usecase.dart';
import 'package:poetlum/features/saved_poems/presentation/bloc/firebase_database_cubit.dart';

GetIt getIt = GetIt.instance;

void initializeDependencies() {
  if(!GetIt.instance.isRegistered<DatabaseManager>()){
    getIt
      // Database 
      ..registerSingleton<DatabaseManager>(DatabaseManager())

      // Dio
      ..registerSingleton<Dio>(Dio())

      // API Service
      ..registerSingleton<PoemApiService>(PoemApiService(getIt()))
      ..registerSingleton<FirebaseService>(FirebaseServiceImpl())
      ..registerSingleton<FirebaseDatabaseService>(FirebaseDatabaseServiceImpl())

      // Repository
      ..registerSingleton<AuthenticationRepository>(AuthenticationRepositoryImpl())
      ..registerSingleton<PoemRepository>(PoemRepositoryImpl(getIt()))
      ..registerSingleton<FirebaseRepository>(FirebaseRepositoryImpl(getIt()))
      ..registerSingleton<FirebaseDatabaseRepository>(FirebaseDatabaseRepositoryImpl(getIt()))
      ..registerSingleton<UserRepository>(UserRepositoryImpl(FirebaseAuth.instance))

      // Usecase
      ..registerSingleton<GetInitialPoemsUseCase>(GetInitialPoemsUseCase(getIt()))
      ..registerSingleton<GetPoemsUseCase>(GetPoemsUseCase(getIt()))
      ..registerSingleton<RegisterUserUseCase>(RegisterUserUseCase(getIt()))
      ..registerSingleton<LoginUserUseCase>(LoginUserUseCase(getIt()))
      ..registerSingleton<GetUserPoemsUseCase>(GetUserPoemsUseCase(getIt()))

      // Validators
      ..registerLazySingleton<UsernameValidator>(() => UsernameValidator())
      ..registerLazySingleton<LocalEmailValidator>(() => LocalEmailValidator())
      ..registerLazySingleton<PasswordValidator>(() => PasswordValidator())

      // Bloc
      ..registerFactory<RemotePoemBloc>(() => RemotePoemBloc(getIt(), getIt()))
      ..registerFactory<AuthCubit>(() => AuthCubit(getIt(), getIt()))
      ..registerFactory<FirebaseDatabaseCubit>(() => FirebaseDatabaseCubit(getIt()))
      ..registerFactory<RegisterFormValidationCubit>(() => RegisterFormValidationCubit(
        usernameValidator: getIt<UsernameValidator>(),
        emailValidator: getIt<LocalEmailValidator>(),
        passwordValidator: getIt<PasswordValidator>(),
      ),)
      ..registerFactory<LoginFormValidationCubit>(() => LoginFormValidationCubit(
        emailValidator: getIt<LocalEmailValidator>(), 
        passwordValidator: getIt<PasswordValidator>(),
      ),);
  }
}
