import 'package:algeria_eats/core/managers/dio_instance.dart';
import 'package:algeria_eats/core/managers/token_manager.dart';
import 'package:algeria_eats/features/auth/models/user.dart' as model;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final dio = DioInstance.getDio();
  final TokenManager _tokenManager = TokenManager();

  Stream<User?> get user => _auth.authStateChanges();

  Future<model.User?> signInWithGoogle() async {
    GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
    AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken, idToken: googleAuth?.idToken);

    UserCredential userCredentials =
        await _auth.signInWithCredential(credential);

    User? user = userCredentials.user;
    final response = await dio.post("/auth/login/google", data: {
      "user": {
        "uid": user!.uid,
        "displayName": user.displayName,
        "email": user.email,
        "photoURL": user.photoURL,
        "num_telephone": user.phoneNumber
      }
    });
    var data = response.data;
    await _tokenManager.removeToken();
    await _tokenManager.trimAndSaveToken(data["token"]);

    return model.User.fromJson(data["user"]);
  }
}
