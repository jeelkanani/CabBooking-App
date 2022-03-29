
import 'package:firebase_auth/firebase_auth.dart';
import 'package:user_app/models/user_model.dart';

final FirebaseAuth fAuth = FirebaseAuth.instance;
User? currentFirebaseUser;
UserModel?  userModelCurrentInfo;