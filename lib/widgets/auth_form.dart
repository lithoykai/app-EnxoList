import 'package:flutter/material.dart';

enum AuthMode { Signup, Login }

class AuthForm extends StatefulWidget {
  bool Function() toggleLogin;

  AuthForm({required this.toggleLogin});

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  AuthMode _authMode = AuthMode.Login;
  bool _isLogin() => _authMode == AuthMode.Login;
  bool _isSignup() => _authMode == AuthMode.Signup;

  void _switchAuthMode() {
    setState(() {
      widget.toggleLogin();
      if (_isLogin()) {
        _authMode = AuthMode.Signup;
      } else {
        _authMode = AuthMode.Login;
      }
    });
  }

  Map<String, String> _authData = {
    'email': '',
    'password': '',
  };
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 0),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              _isLogin() ? 'Login' : 'Cadastro',
              textAlign: TextAlign.left,
              style: const TextStyle(
                fontSize: 40,
                fontFamily: "MarkaziText",
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  decoration: const InputDecoration(
                    fillColor: Color(0xFFFDFDFD),
                    filled: true,
                    enabledBorder: UnderlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      borderSide:
                          BorderSide(color: Colors.transparent, width: 5),
                    ),
                    labelText: 'E-mail',
                    labelStyle: TextStyle(
                      fontFamily: "Roboto",
                      color: Color(0xFF6B6B6B),
                      fontSize: 17,
                    ),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  onSaved: (email) => _authData['email'] = email ?? '',
                  validator: (_email) {
                    final email = _email ?? '';
                    if (email.trim().isEmpty || !email.contains('@')) {
                      return 'Informe um email válido';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    enabledBorder: UnderlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      borderSide:
                          BorderSide(color: Colors.transparent, width: 0),
                    ),
                    labelStyle: TextStyle(
                      fontFamily: "Roboto",
                      color: Color(0xFF6B6B6B),
                      fontSize: 17,
                    ),
                    labelText: 'Senha',
                  ),
                  obscureText: true,
                  controller: _passwordController,
                  onSaved: (password) => _authData['password'] = password ?? '',
                  validator: (_password) {
                    final password = _password ?? '';
                    if (password.isEmpty || password.length < 5) {
                      return 'Informe uma senha válida (no minímo 5 caracteres)';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          AnimatedContainer(
            constraints: BoxConstraints(
                minHeight: _isLogin() ? 0 : 60,
                maxHeight: _isLogin() ? 0 : 120),
            duration: const Duration(milliseconds: 300),
            curve: Curves.linear,
            child: TextFormField(
                decoration: const InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  enabledBorder: UnderlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    borderSide: BorderSide(color: Colors.transparent, width: 0),
                  ),
                  labelStyle: TextStyle(
                    fontFamily: "Roboto",
                    color: Color(0xFF6B6B6B),
                    fontSize: 17,
                  ),
                  labelText: 'Confirmar senha',
                ),
                obscureText: true,
                validator: _isLogin()
                    ? null
                    : (_password) {
                        final password = _password ?? '';
                        if (password != _passwordController.text) {
                          return 'As senhas não conferem!';
                        } else {
                          return null;
                        }
                      }),
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFE36F6F)),
              onPressed: () {},
              child: const Text(
                'Login',
                style: TextStyle(
                  fontFamily: "Roboto",
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: TextButton(
              onPressed: _switchAuthMode,
              child: Text(
                _isLogin() ? 'CRIAR UMA CONTA' : 'JÁ POSSUI CONTA?',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
