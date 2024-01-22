import 'package:flutter/material.dart';

class LogarFunctions {
  BuildContext context;
  LogarFunctions(this.context);

  final emailController = TextEditingController();
  final senhaController = TextEditingController();

  Future logarFunctionsPrincipal() async{
    
  }

  void limpaControllers() async {
    emailController.clear();
    senhaController.clear();
  }
}