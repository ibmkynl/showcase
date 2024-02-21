import "package:email_validator/email_validator.dart";
import "package:flutter/material.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";
import "package:showcase/api/api.dart";
import "package:showcase/models/response_model.dart";
import "package:showcase/storage/shared_manager.dart";
import "package:showcase/utils/shared_manager_keys.dart";

final registerProvider = ChangeNotifierProvider((ref) => RegisterViewModel());

class RegisterViewModel extends ChangeNotifier {
  RegisterViewModel() {
    //whenever model view calls, if token exits in local storage
    token = SharedManager.getString(SharedManagerKeys.tokenKey);
  }

  final Api _api = Api();

  bool registerLoading = false, loginLoading = false;

  ///if user fill all credentials correctly
  bool credentialsReady = false;

  String emailErrorString = "", passwordErrorString = "";

  ///user login token, accessible from anywhere
  String token = "";

  void setRegisterLoading(bool val) {
    registerLoading = val;
    notifyListeners();
  }

  void setLoginLoading(bool val) {
    loginLoading = val;
    notifyListeners();
  }

  void emailValidate({required String email}) {
    if (email.isEmpty) {
      emailErrorString = "";
      notifyListeners();
      return;
    }

    //only notify the app when there should be changing the email error text
    if (!EmailValidator.validate(email)) {
      emailErrorString = "Please enter valid email";
      notifyListeners();
    } else if (emailErrorString.isNotEmpty) {
      emailErrorString = "";
      notifyListeners();
    }
  }

  void passwordValidate({required String password}) {
    if (password.isEmpty) {
      passwordErrorString = "";
      notifyListeners();
      return;
    }

    // Minimum length check
    if (password.length < 6) {
      passwordErrorString = "Password length should be longer than 5";
      notifyListeners();
    }

    // Uppercase letter check
    else if (!password.contains(RegExp(r'[A-Z]'))) {
      passwordErrorString = "Password should contain at least one uppercase letter";
      notifyListeners();
    }

    // Lowercase letter check
    else if (!password.contains(RegExp(r'[a-z]'))) {
      passwordErrorString = "Password should contain at least one lowercase letter";
      notifyListeners();
    }

    // Number check
    else if (!password.contains(RegExp(r'[0-9]'))) {
      passwordErrorString = "Password should contain at least one number";
      notifyListeners();
    }

    // Special character check
    else if (!password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      passwordErrorString = "Password should contain at least one special character";
      notifyListeners();
    } else if (passwordErrorString.isNotEmpty) {
      passwordErrorString = "";
      notifyListeners();
    }
  }

  ///before request anything we make sure user filled both fields and has no error messages
  bool checkFields({required String email, required String password}) {
    //this help us to show both error message at same time if needed
    bool result = true;

    if (email.isEmpty || email.trim().isEmpty || emailErrorString.isNotEmpty) {
      emailErrorString = "Please enter valid email";
      notifyListeners();
      result = false;
      //if we return false here, then in scenario where also password is empty, password error message will not shown
    }

    if (password.isEmpty || password.trim().isEmpty || passwordErrorString.isNotEmpty) {
      //if user already error message, we wont change it but if field is blank then we will give this error message
      passwordErrorString = passwordErrorString.isNotEmpty ? passwordErrorString : "Please enter a password";
      notifyListeners();
      result = false;
    }
    return result;
  }

  Future<bool?> login({required String email, required String password}) async {
    if (!checkFields(email: email, password: password)) return null;

    setLoginLoading(true);

    ResponseModel model = await _api.login(email: email, password: password);

    setLoginLoading(false);

    if (model.statusCode == 200) {
      String token = model.body!['token'];

      //after successful login, take token and store it
      SharedManager.setString(data: token, id: SharedManagerKeys.tokenKey);

      return true;
    }

    return false;
  }

  Future<bool?> register({required String email, required String password}) async {
    if (!checkFields(email: email, password: password)) return null;

    setRegisterLoading(true);

    ResponseModel model = await _api.register(email: email, password: password);

    setRegisterLoading(false);

    if (model.statusCode == 200) {
      String token = model.body!['token'];

      //after successful register, take token and store it
      SharedManager.setString(data: token, id: SharedManagerKeys.tokenKey);

      return true;
    }

    return false;
  }
}
