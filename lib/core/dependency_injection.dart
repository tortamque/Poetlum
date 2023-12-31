import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:poetlum/core/shared/data/repository/user_repository_impl.dart';
import 'package:poetlum/core/shared/domain/repository/user_repository.dart';
import 'package:poetlum/core/shared/presentation/bloc/credentials/credentials_bloc.dart';
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
import 'package:poetlum/features/poems_feed/domain/repository/poem_repository.dart';
import 'package:poetlum/features/poems_feed/domain/usecases/get_poems_usecase.dart';
import 'package:poetlum/features/poems_feed/presentation/bloc/poem/remote/remote_poem_bloc.dart';
import 'package:poetlum/features/saved_poems/data/data_sources/remote/firebase_api_service.dart';
import 'package:poetlum/features/saved_poems/data/repository/firebase_db_repository_impl.dart';
import 'package:poetlum/features/saved_poems/domain/repository/firebase_db_repository.dart';
import 'package:poetlum/features/saved_poems/domain/usecases/create_new_collection/create_new_collection_usecase.dart';
import 'package:poetlum/features/saved_poems/domain/usecases/delete_collection/delete_collection_usecase.dart';
import 'package:poetlum/features/saved_poems/domain/usecases/delete_poem/delete_poem_usecase.dart';
import 'package:poetlum/features/saved_poems/domain/usecases/delete_poem_from_collection/delete_poem_from_collection_usecase.dart';
import 'package:poetlum/features/saved_poems/domain/usecases/get_poems_in_collection/get_poems_in_collection_usecase.dart';
import 'package:poetlum/features/saved_poems/domain/usecases/get_user_collections/get_user_collections_usecase.dart';
import 'package:poetlum/features/saved_poems/domain/usecases/get_user_poems/get_user_poems_usecase.dart';
import 'package:poetlum/features/saved_poems/domain/usecases/is_collection_exists/is_collection_exists_usecase.dart';
import 'package:poetlum/features/saved_poems/domain/usecases/is_poem_exists/is_poem_exists_usecase.dart';
import 'package:poetlum/features/saved_poems/domain/usecases/is_poem_exists_by_name/is_poem_exists_by_name_usecase.dart';
import 'package:poetlum/features/saved_poems/domain/usecases/save_poem/save_poem_usecase.dart';
import 'package:poetlum/features/saved_poems/domain/usecases/update_poems_in_collection/update_poems_in_collection_usecase.dart';
import 'package:poetlum/features/saved_poems/presentation/bloc/firebase_database/firebase_database_cubit.dart';
import 'package:poetlum/features/theme_change/data/data_sources/local/shared_preferences_service.dart';
import 'package:poetlum/features/theme_change/data/repository/shared_preferences_repository_impl.dart';
import 'package:poetlum/features/theme_change/domain/repository/shared_preferences_repository.dart';
import 'package:poetlum/features/theme_change/domain/usecases/get_color/get_color_usecase.dart';
import 'package:poetlum/features/theme_change/domain/usecases/save_color/save_color_usecase.dart';
import 'package:poetlum/features/theme_change/presentation/bloc/change_theme_cubit.dart';

GetIt getIt = GetIt.instance;

void initializeDependencies() {
  if(!GetIt.instance.isRegistered<Dio>()){
    getIt
      // Dio
      ..registerSingleton<Dio>(Dio())

      // API Service
      ..registerSingleton<PoemApiService>(PoemApiService(getIt()))
      ..registerSingleton<FirebaseService>(FirebaseServiceImpl())
      ..registerSingleton<FirebaseDatabaseService>(FirebaseDatabaseServiceImpl())
      ..registerSingleton<SharedPreferencesService>(SharedPreferencesServiceImpl())

      // Repository
      ..registerSingleton<AuthenticationRepository>(AuthenticationRepositoryImpl())
      ..registerSingleton<PoemRepository>(PoemRepositoryImpl(getIt()))
      ..registerSingleton<FirebaseRepository>(FirebaseRepositoryImpl(getIt()))
      ..registerSingleton<FirebaseDatabaseRepository>(FirebaseDatabaseRepositoryImpl(getIt()))
      ..registerSingleton<SharedPreferencesRepository>(SharedPreferencesRepositoryImpl(getIt()))
      ..registerSingleton<UserRepository>(UserRepositoryImpl(FirebaseAuth.instance))

      // Usecase
      ..registerSingleton<GetInitialPoemsUseCase>(GetInitialPoemsUseCase(getIt()))
      ..registerSingleton<GetPoemsUseCase>(GetPoemsUseCase(getIt()))
      ..registerSingleton<RegisterUserUseCase>(RegisterUserUseCase(getIt()))
      ..registerSingleton<LoginUserUseCase>(LoginUserUseCase(getIt()))
      ..registerSingleton<GetUserPoemsUseCase>(GetUserPoemsUseCase(getIt()))
      ..registerSingleton<GetUserCollectionsUseCase>(GetUserCollectionsUseCase(getIt()))
      ..registerSingleton<SavePoemUseCase>(SavePoemUseCase(getIt()))
      ..registerSingleton<DeletePoemUseCase>(DeletePoemUseCase(getIt()))
      ..registerSingleton<IsPoemExistsUseCase>(IsPoemExistsUseCase(getIt()))
      ..registerSingleton<IsPoemExistsByNameUseCase>(IsPoemExistsByNameUseCase(getIt()))
      ..registerSingleton<CreateNewCollectionUseCase>(CreateNewCollectionUseCase(getIt()))
      ..registerSingleton<DeleteCollectionUseCase>(DeleteCollectionUseCase(getIt()))
      ..registerSingleton<DeletePoemFromCollectionUseCase>(DeletePoemFromCollectionUseCase(getIt()))
      ..registerSingleton<UpdatePoemsInCollectionUseCase>(UpdatePoemsInCollectionUseCase(getIt()))
      ..registerSingleton<GetPoemsInCollectionUseCase>(GetPoemsInCollectionUseCase(getIt()))
      ..registerSingleton<IsCollectionExistsUseCase>(IsCollectionExistsUseCase(getIt()))
      ..registerSingleton<SaveColorUseCase>(SaveColorUseCase(getIt()))
      ..registerSingleton<GetColorUseCase>(GetColorUseCase(getIt()))

      // Validators
      ..registerLazySingleton<UsernameValidator>(() => UsernameValidator())
      ..registerLazySingleton<LocalEmailValidator>(() => LocalEmailValidator())
      ..registerLazySingleton<PasswordValidator>(() => PasswordValidator())

      // Bloc 
      ..registerFactory<RemotePoemBloc>(() => RemotePoemBloc(getIt(), getIt()))
      ..registerFactory<AuthCubit>(() => AuthCubit(getIt(), getIt()))
      ..registerFactory<CredentialsCubit>(() => CredentialsCubit())
      ..registerFactory<ThemeCubit>(() => ThemeCubit(getIt(), getIt()))
      ..registerFactory<FirebaseDatabaseCubit>(
        () => FirebaseDatabaseCubit(
          getIt(), 
          getIt(), 
          getIt(), 
          getIt(), 
          getIt(), 
          getIt(), 
          getIt(),
          getIt(),
          getIt(),
          getIt(),
          getIt(),
          getIt(),
        ),
      )
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
