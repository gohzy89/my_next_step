import 'package:flutter/material.dart';

TextEditingController usernameTextEditingController = TextEditingController();

TextEditingController passwordTextEditingController = TextEditingController();

TextEditingController confirmPasswordTextEditingController = TextEditingController();

TextEditingController recoveryEmailTextEditingController = TextEditingController();

TextEditingController confirmRecoveryEmailTextEditingController = TextEditingController();


final usernameFormKey = GlobalKey<FormState>();

final passwordFormKey = GlobalKey<FormState>();

final cfmPasswordFormKey = GlobalKey<FormState>();

final recoveryEmailFormKey = GlobalKey<FormState>();

final cfmRecoveryEmailFormKey = GlobalKey<FormState>();