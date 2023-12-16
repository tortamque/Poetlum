// ignore_for_file: one_member_abstracts

import 'package:poetlum/features/poems_feed/data/models/firebase_user.dart';

abstract class UserRepository{
  FirebaserUserModel getCurrentUser();
}
