import 'package:firebase_auth/firebase_auth.dart';

import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../firebase/references.dart';
import '../screens/auth_and_profile/login_screen.dart';
import '../screens/home/home_screen.dart';
import '../screens/onboarding/app_indroduction_screen.dart';
import '../utils/logger.dart';
import '../widgets/dialogs/dialogs.dart';

class AuthController extends GetxController {
  @override
  void onReady() {
    initAuth();
    super.onReady();
  }

  late FirebaseAuth _auth;
  final _user = Rxn<User>();
  late Stream<User?> _authStateChanges;
  bool isloadingCp = false;

  void initAuth() async {
    await Future.delayed(const Duration(seconds: 2)); // waiting in splash
    _auth = FirebaseAuth.instance;
    _authStateChanges = _auth.authStateChanges();
    _authStateChanges.listen((User? user) {
      _user.value = user;
    });
    navigateToIntroduction();
  }

  final GoogleSignIn googleSignIn = GoogleSignIn();
  Future<void> siginInWithGoogle() async {
    //final GoogleSignIn googleSignIn = GoogleSignIn();

    try {
      isloadingCp = true;
      final account = await googleSignIn.signIn();
      if (account != null) {
        final _gAuthentication = await account.authentication;
        final _credential = GoogleAuthProvider.credential(
            idToken: _gAuthentication.idToken,
            accessToken: _gAuthentication.accessToken);

        await _auth.signInWithCredential(_credential);
        await saveUser(account);
        navigateToHome();
        update();
      }
    } on Exception catch (error) {
      AppLogger.e(error);
    }
  }

  Future<void> signOut() async {
    AppLogger.d("Sign out");
    try {
      await googleSignIn.disconnect();
      FirebaseAuth.instance.signOut();
      navigateToHome();
    } on FirebaseAuthException catch (e) {
      AppLogger.e(e);
    }
  }

  Future<void> saveUser(GoogleSignInAccount account) async {
    userFR.doc(account.email).set({
      "email": account.email,
      "name": account.displayName,
      "profilepic": account.photoUrl
    });
  }

  User? getUser() {
    _user.value = _auth.currentUser;
    return _user.value;
  }

  bool isLogedIn() {
    return _auth.currentUser != null;
  }

  void navigateToHome() {
    Get.offAllNamed(HomeScreen.routeName);
  }

  void navigateToLogin() {
    Get.toNamed(LoginScreen.routeName);
  }

  void navigateToIntroduction() {
    Get.offAllNamed(AppIntroductionScreen.routeName);
  }

  void showLoginAlertDialog() {
    Get.dialog(
      Dialogs.quizStartDialog(onTap: () {
        Get.back();
        navigateToLogin();
      }),
      barrierDismissible: false,
    );
  }
}
