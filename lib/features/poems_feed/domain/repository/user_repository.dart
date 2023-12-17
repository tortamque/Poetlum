import 'package:poetlum/features/poems_feed/data/models/firebase_user.dart';

abstract class UserRepository{
  FirebaserUserModel getCurrentUser();
}
