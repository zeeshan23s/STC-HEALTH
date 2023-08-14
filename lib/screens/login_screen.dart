import '../exports.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  bool isPasswordVisible = false;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    _usernameController.addListener(() {
      setState(() {});
    });

    _passwordController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                Container(
                  decoration: const BoxDecoration(
                      gradient: AppGradients.linearGradient),
                  child: Center(
                    child: Text('STC\nHEALTH',
                        style: Theme.of(context)
                            .textTheme
                            .headlineLarge
                            ?.copyWith(color: Colors.white),
                        textAlign: TextAlign.center),
                  ),
                ),
                Positioned(
                  bottom: ScreenHelper.screenHeight(context) * 0.02,
                  left: ScreenHelper.screenWidth(context) * 0.04,
                  child: Text(
                    'Log In',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        color: Colors.white, fontWeight: FontWeight.w700),
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(
                    vertical: ScreenHelper.screenHeight(context) * 0.02,
                    horizontal: ScreenHelper.screenWidth(context) * 0.04),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      customTextField(
                        context: context,
                        validator: (value) {
                          if (value == null) {
                            return 'Username not provider!';
                          }
                          return null;
                        },
                        controller: _usernameController,
                        label: 'Username',
                        suffix: _usernameController.text != ''
                            ? const Icon(Icons.done_rounded,
                                color: Colors.green)
                            : const SizedBox(),
                      ),
                      SizedBox(
                          height: ScreenHelper.screenHeight(context) * 0.04),
                      customTextField(
                        context: context,
                        validator: (value) {
                          if (value == null) {
                            return 'Password not provided!';
                          }
                          if (value.length < 4 && value.length > 15) {
                            return 'Invalid Password!';
                          }
                          return null;
                        },
                        controller: _passwordController,
                        label: 'Password',
                        suffix: GestureDetector(
                          onTap: () => setState(
                            () {
                              isPasswordVisible = !isPasswordVisible;
                            },
                          ),
                          child: Icon(isPasswordVisible
                              ? Icons.visibility_off
                              : Icons.visibility),
                        ),
                        obscureText: !isPasswordVisible,
                      ),
                      SizedBox(
                          height: ScreenHelper.screenHeight(context) * 0.04),
                      Consumer<AuthProvider>(
                        builder: (context, auth, child) {
                          if (!auth.isLoading) {
                            return CustomButton(
                                onTab: () async {
                                  await auth
                                      .login(_usernameController.text,
                                          _passwordController.text)
                                      .whenComplete(
                                    () {
                                      if (auth.message ==
                                          'Login Successfully!') {
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const ProductScreen()));
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(auth.message!,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium
                                                    ?.copyWith(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: Colors.white)),
                                            backgroundColor: Colors.red,
                                            duration:
                                                const Duration(seconds: 2),
                                          ),
                                        );
                                      }
                                      _usernameController.clear();
                                      _passwordController.clear();
                                    },
                                  );
                                },
                                label: 'Login',
                                height:
                                    ScreenHelper.screenHeight(context) * 0.08,
                                width: ScreenHelper.screenWidth(context) * 0.9);
                          } else {
                            return const CircularProgressIndicator();
                          }
                        },
                      ),
                      SizedBox(
                          height: ScreenHelper.screenHeight(context) * 0.04),
                      Text(
                        'NEED HELP?',
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget customTextField(
      {required BuildContext context,
      required String? Function(String?)? validator,
      required TextEditingController controller,
      required String label,
      required Widget suffix,
      bool obscureText = false}) {
    return TextFormField(
      validator: validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: controller,
      cursorHeight: ScreenHelper.screenHeight(context) * 0.020,
      style: Theme.of(context).textTheme.bodyMedium,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: Theme.of(context).textTheme.bodyMedium,
        suffixIcon: suffix,
      ),
      obscureText: obscureText,
      keyboardType: TextInputType.emailAddress,
    );
  }
}
