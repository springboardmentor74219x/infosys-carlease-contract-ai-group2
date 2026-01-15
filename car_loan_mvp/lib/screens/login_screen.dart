import 'package:flutter/material.dart';
import 'upload_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with TickerProviderStateMixin {
  bool showLogin = true;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  String? registeredEmail;
  String? registeredPassword;

  late AnimationController _logoController;
  late AnimationController _bgController;

  final Color themeColor = const Color(0xFF1A237E); // Deep Blue

  @override
  void initState() {
    super.initState();

    _logoController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _bgController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 25),
    )..repeat();
  }

  @override
  void dispose() {
    _logoController.dispose();
    _bgController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Moving background
          AnimatedBuilder(
            animation: _bgController,
            builder: (context, child) {
              return Transform.translate(
                offset: Offset(-50 + (_bgController.value * 100), 0),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width + 100,
                  height: MediaQuery.of(context).size.height,
                  child: Image.asset(
                    "assets/background.png",
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
          ),

          // Soft overlay (kept light so image still visible)
          Container(color: Colors.black.withOpacity(0.15)),

          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                children: [
                  // Animated logo
                  ScaleTransition(
                    scale: Tween(
                      begin: 0.9,
                      end: 1.05,
                    ).animate(_logoController),
                    child: CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.white,
                      child: Icon(
                        Icons.directions_car,
                        color: themeColor,
                        size: 40,
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Title
                  Text(
                    "Car Loan AutoAssist AI",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: themeColor,
                      letterSpacing: 1.2,
                    ),
                  ),

                  const SizedBox(height: 40),

                  // Login / Register
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      tabText("Login", showLogin, () {
                        setState(() => showLogin = true);
                      }),
                      const SizedBox(width: 40),
                      tabText("Register", !showLogin, () {
                        setState(() => showLogin = false);
                      }),
                    ],
                  ),

                  const SizedBox(height: 30),

                  showLogin ? loginForm() : registerForm(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget tabText(String text, bool active, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        text,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: active ? themeColor : themeColor.withOpacity(0.5),
        ),
      ),
    );
  }

  Widget loginForm() {
    return Column(
      children: [
        field(emailController, "Email"),
        const SizedBox(height: 20),
        field(passwordController, "Password", isPassword: true),
        const SizedBox(height: 30),
        actionButton("Login", loginUser),
      ],
    );
  }

  Widget registerForm() {
    return Column(
      children: [
        field(emailController, "Email"),
        const SizedBox(height: 20),
        field(passwordController, "Password", isPassword: true),
        const SizedBox(height: 30),
        actionButton("Create Account", registerUser),
      ],
    );
  }

  Widget field(
    TextEditingController controller,
    String hint, {
    bool isPassword = false,
  }) {
    return TextField(
      controller: controller,
      obscureText: isPassword,
      style: TextStyle(
        color: themeColor,
        fontSize: 17,
        fontWeight: FontWeight.w600,
      ),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: themeColor.withOpacity(0.6)),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: themeColor.withOpacity(0.6)),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: themeColor),
        ),
      ),
    );
  }

  Widget actionButton(String text, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        text,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.2,
          color: themeColor,
        ),
      ),
    );
  }

  void registerUser() {
    registeredEmail = emailController.text;
    registeredPassword = passwordController.text;

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text("Registered successfully!")));

    setState(() => showLogin = true);
  }

  void loginUser() {
    if (emailController.text == registeredEmail &&
        passwordController.text == registeredPassword) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const UploadScreen()),
      );
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Invalid credentials")));
    }
  }
}
