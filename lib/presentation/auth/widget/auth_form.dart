import 'package:enxolist/data/data_source/product/product_remote_datasource_offline.dart';
import 'package:enxolist/data/data_source/product/product_remote_datasource_online.dart';
import 'package:enxolist/data/data_source/product/product_remote_datasource_proxy.dart';
import 'package:enxolist/data/models/auth/request/auth_request.dart';
import 'package:enxolist/di/injectable.dart';
import 'package:enxolist/infra/utils/approuter.dart';
import 'package:enxolist/presentation/auth/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum AuthMode { Signup, Login }

class AuthForm extends StatefulWidget {
  bool Function() toggleLogin;

  AuthForm({required this.toggleLogin});

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  bool _obscurePassword = true;
  bool _confirmObscurePassword = true;
  AuthController authController = getIt<AuthController>();
  final _passwordController = TextEditingController();
  late TextEditingController _emailController;
  final _formKey = GlobalKey<FormState>();
  AuthMode _authMode = AuthMode.Login;
  bool _isLogin() => _authMode == AuthMode.Login;
  Map<String, String> _authData = {
    'email': '',
    'password': '',
  };
  late bool saveLogin;
  bool isLoading = false;

  // FocusNode
  final _emailFocus = FocusNode();
  final _emailCoupleFocus = FocusNode();
  final _passwordFocus = FocusNode();
  final _confirmPasswordFocus = FocusNode();
  final _nameFocus = FocusNode();

  @override
  void dispose() {
    super.dispose();
    _emailFocus.dispose();
    _emailCoupleFocus.dispose();
    _passwordFocus.dispose();
    _confirmPasswordFocus.dispose();
    _nameFocus.dispose();
    _emailController.dispose();
  }

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    saveLogin = false;

    _loadSavedLogin();
  }

  Future<void> _loadSavedLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      saveLogin = prefs.getBool('saveLogin') ?? false;
      if (saveLogin) {
        _emailController.text = prefs.getString('savedLogin') ?? '';
      }
    });
  }

  Future<void> _saveLoginData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (saveLogin) {
      await prefs.setBool('saveLogin', true);
      await prefs.setString('savedLogin', _emailController.text);
    } else {
      await prefs.setBool('saveLogin', false);
      await prefs.remove('savedLogin');
    }
  }

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

  onSubmit() async {
    final isValid = _formKey.currentState?.validate() ?? false;

    if (!isValid) {
      return;
    }

    setState(() {
      isLoading = true;
    });
    if (_isLogin()) _authData.remove('name');

    _formKey.currentState?.save();
    await _saveLoginData();

    try {
      AuthRequest request = AuthRequest.fromJson(_authData);
      await authController.authenticate(request, request.name == null).then(
          (_) => Navigator.of(context)
              .pushReplacementNamed(AppRouter.AUTH_OR_HOME));
    } catch (e) {
      _showErrorDialog(e.toString());
    }

    setState(() {
      isLoading = false;
    });
  }

  void _toggle() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
  }

  void _showErrorDialog(String msg) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Theme.of(context).colorScheme.onSurface,
            title: const Text(
              'Ocorreu um erro.',
            ),
            content: Text(msg,
                style:
                    TextStyle(color: Theme.of(context).colorScheme.secondary)),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text('Fechar.',
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary)),
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const CircularProgressIndicator()
        : Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 0),
            child: Column(
              children: [
                Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        _isLogin() ? 'Login' : 'Cadastro',
                        textAlign: TextAlign.left,
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          !_isLogin()
                              ? TextFormField(
                                  style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                  ),
                                  decoration: InputDecoration(
                                    fillColor:
                                        Theme.of(context).colorScheme.onSurface,
                                    filled: true,
                                    enabledBorder: const UnderlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(5)),
                                      borderSide: BorderSide(
                                          color: Colors.transparent, width: 5),
                                    ),
                                    labelText: 'Nome',
                                    labelStyle: TextStyle(
                                      fontFamily: "Roboto",
                                      color:
                                          Theme.of(context).colorScheme.surface,
                                      fontSize: 17,
                                    ),
                                  ),
                                  focusNode: _nameFocus,
                                  onSaved: (name) =>
                                      _authData['name'] = name ?? '',
                                  validator: (_name) {
                                    final name = _name ?? '';
                                    if (name.trim().isEmpty) {
                                      return 'Informe um nome válido';
                                    }
                                    return null;
                                  },
                                )
                              : Container(),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                            decoration: InputDecoration(
                              // prefixIcon: Icon(Icons.email_rounded),
                              fillColor:
                                  Theme.of(context).colorScheme.onSurface,
                              filled: true,
                              enabledBorder: const UnderlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                                borderSide: BorderSide(
                                    color: Colors.transparent, width: 5),
                              ),
                              labelText: 'E-mail',
                              labelStyle: TextStyle(
                                fontFamily: "Roboto",
                                color: Theme.of(context).colorScheme.surface,
                                fontSize: 17,
                              ),
                            ),
                            focusNode: _emailFocus,
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            onSaved: (email) =>
                                _authData['email'] = _emailController.text,
                            validator: (_email) {
                              final email = _email ?? '';
                              if (email.trim().isEmpty ||
                                  !email.contains('@')) {
                                return 'Informe um email válido';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                            decoration: InputDecoration(
                              fillColor:
                                  Theme.of(context).colorScheme.onSurface,
                              // prefixIcon: const Icon(Icons.lock_rounded),
                              suffixIcon: IconButton(
                                onPressed: _toggle,
                                icon: Icon(
                                  _obscurePassword
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Colors.black54,
                                ),
                              ),
                              filled: true,
                              enabledBorder: const UnderlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                                borderSide: BorderSide(
                                    color: Colors.transparent, width: 0),
                              ),
                              labelStyle: TextStyle(
                                fontFamily: "Roboto",
                                color: Theme.of(context).colorScheme.surface,
                                fontSize: 17,
                              ),
                              labelText: 'Senha',
                            ),
                            obscureText: _obscurePassword,
                            focusNode: _passwordFocus,
                            controller: _passwordController,
                            onSaved: (password) =>
                                _authData['password'] = password!,
                            validator: (_password) {
                              final password = _password ?? '';
                              if (password.isEmpty || password.length < 5) {
                                return 'Informe uma senha válida (no minímo 5 caracteres)';
                              }
                              return null;
                            },
                          ),
                          !_isLogin()
                              ? Column(
                                  children: [
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    AnimatedContainer(
                                      constraints: BoxConstraints(
                                          minHeight: _isLogin() ? 0 : 60,
                                          maxHeight: _isLogin() ? 0 : 120),
                                      duration:
                                          const Duration(milliseconds: 300),
                                      curve: Curves.linear,
                                      child: TextFormField(
                                          style: TextStyle(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .secondary,
                                          ),
                                          decoration: InputDecoration(
                                            fillColor: Theme.of(context)
                                                .colorScheme
                                                .onSurface,
                                            filled: true,
                                            enabledBorder:
                                                const UnderlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(5)),
                                              borderSide: BorderSide(
                                                  color: Colors.transparent,
                                                  width: 0),
                                            ),
                                            labelStyle: TextStyle(
                                              fontFamily: "Roboto",
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .surface,
                                              fontSize: 17,
                                            ),
                                            labelText: 'Confirmar senha',
                                            suffixIcon: IconButton(
                                              onPressed: () => setState(() {
                                                _confirmObscurePassword =
                                                    !_confirmObscurePassword;
                                              }),
                                              icon: Icon(
                                                _confirmObscurePassword
                                                    ? Icons.visibility
                                                    : Icons.visibility_off,
                                                color: Colors.black54,
                                              ),
                                            ),
                                          ),
                                          obscureText: _confirmObscurePassword,
                                          onSaved: (confirm) =>
                                              _authData['confirm'] =
                                                  confirm ?? '',
                                          focusNode: _confirmPasswordFocus,
                                          validator: _isLogin()
                                              ? null
                                              : (_password) {
                                                  final password =
                                                      _password ?? '';
                                                  if (_password !=
                                                      _passwordController
                                                          .text) {
                                                    return 'As senhas não conferem!';
                                                  } else {
                                                    return null;
                                                  }
                                                }),
                                    ),
                                  ],
                                )
                              : Container(),
                          !_isLogin()
                              ? Column(children: [
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  TextFormField(
                                    style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                    ),
                                    decoration: InputDecoration(
                                      fillColor: Theme.of(context)
                                          .colorScheme
                                          .onSurface,
                                      filled: true,
                                      enabledBorder: const UnderlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5)),
                                        borderSide: BorderSide(
                                            color: Colors.transparent,
                                            width: 5),
                                      ),
                                      labelText: 'Email do casal',
                                      labelStyle: TextStyle(
                                        fontFamily: "Roboto",
                                        color: Theme.of(context)
                                            .colorScheme
                                            .surface,
                                        fontSize: 17,
                                      ),
                                    ),
                                    validator: (_coupleEmail) {
                                      final name = _coupleEmail ?? '';

                                      return null;
                                    },
                                    focusNode: _emailCoupleFocus,
                                    keyboardType: TextInputType.emailAddress,
                                    onSaved: (coupleEmail) =>
                                        _authData['coupleEmail'] =
                                            coupleEmail ?? "",
                                  ),
                                  const Padding(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 8.0),
                                    child: Text(
                                      '*Se você deseja compartilhar a lista com alguém já cadastrado, adicione aqui o email dessa pessoa. Caso não, só ignorar.',
                                    ),
                                  )
                                ])
                              : Container(),
                        ],
                      ),
                    ),
                    _isLogin()
                        ? Column(
                            children: [
                              const SizedBox(
                                height: 13,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Checkbox(
                                    value: saveLogin,
                                    onChanged: (value) {
                                      setState(() {
                                        saveLogin = value!;
                                      });
                                    },
                                  ),
                                  Text(
                                    'Salvar email',
                                    style: TextStyle(
                                      fontFamily: "Roboto",
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSecondary,
                                      fontSize: 17,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          )
                        : Container(),
                    const SizedBox(
                      height: 20,
                    ),
                    isLoading
                        ? const CircularProgressIndicator()
                        : SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    Theme.of(context).colorScheme.primary,
                                shape: ContinuousRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                              onPressed: onSubmit,
                              child: Text(
                                _isLogin() ? 'Login' : 'Cadastrar',
                                style: const TextStyle(
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
                  ],
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: TextButton(
                    onPressed: _switchAuthMode,
                    child: Text(
                      _isLogin() ? 'CRIAR UMA CONTA' : 'JÁ POSSUI CONTA?',
                      style: Theme.of(context).textTheme.displaySmall,
                    ),
                  ),
                ),
                TextButton(
                    onPressed: () async {
                      switchDataSource(true);
                      Navigator.of(context).pushNamed(AppRouter.AUTH_OR_HOME);
                    },
                    child: const Text('Continuar sem conta.')),
              ],
            ),
          );
  }

  void switchDataSource(bool offline) {
    final dataSourceProxy = getIt<ProductDataSourceProxy>();

    if (offline) {
      dataSourceProxy.switchDataSource(getIt<ProductRemoteDataSourceOffline>());
    } else {
      dataSourceProxy.switchDataSource(getIt<ProductRemoteDataSourceOnline>());
    }
  }
}
