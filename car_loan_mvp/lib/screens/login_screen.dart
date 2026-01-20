import 'package:flutter/material.dart';
import 'upload_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  late AnimationController _logoController;
  late AnimationController _bgController;

  final Color themeColor = const Color(0xFF1A237E);

  @override
  void initState() {
    super.initState();

    _logoController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _bgController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 30),
    )..repeat();

    checkLoginStatus(); // ✅ auto login check
  }

  @override
  void dispose() {
    _logoController.dispose();
    _bgController.dispose();
    super.dispose();
  }

  // ================= STORAGE LOGIC =================

  Future<void> checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool("isLoggedIn") ?? false;

    if (isLoggedIn) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const UploadScreen()),
      );
    }
  }

  Future<void> registerUser() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString("email", emailController.text);
    await prefs.setString("password", passwordController.text);

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text("Registered successfully")));

    setState(() => showLogin = true);
  }

  Future<void> loginUser() async {
    final prefs = await SharedPreferences.getInstance();

    String? savedEmail = prefs.getString("email");
    String? savedPassword = prefs.getString("password");

    if (emailController.text == savedEmail &&
        passwordController.text == savedPassword) {
      await prefs.setBool("isLoggedIn", true);

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

  // ================= UI =================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
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

          Container(color: Colors.black.withOpacity(0.2)),

          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(30),
              child: Column(
                children: [
                  ScaleTransition(
                    scale: Tween(
                      begin: 0.9,
                      end: 1.05,
                    ).animate(_logoController),
                    child: CircleAvatar(
                      radius: 45,
                      backgroundColor: Colors.white,
                      child: Icon(
                        Icons.directions_car,
                        size: 40,
                        color: themeColor,
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  const Text(
                    "Car Loan AutoAssist AI",
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),

                  const SizedBox(height: 30),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      toggleButton("Login", showLogin, () {
                        setState(() => showLogin = true);
                      }),
                      const SizedBox(width: 15),
                      toggleButton("Register", !showLogin, () {
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

  Widget toggleButton(String text, bool active, VoidCallback onTap) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: active ? themeColor : Colors.white,
        foregroundColor: active ? Colors.white : themeColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
      onPressed: onTap,
      child: Text(text),
    );
  }

  Widget loginForm() {
    return Column(
      children: [
        inputField(emailController, "Email"),
        const SizedBox(height: 15),
        inputField(passwordController, "Password", isPassword: true),
        const SizedBox(height: 25),
        mainButton("Login", loginUser),
      ],
    );
  }

  Widget registerForm() {
    return Column(
      children: [
        inputField(emailController, "Email"),
        const SizedBox(height: 15),
        inputField(passwordController, "Password", isPassword: true),
        const SizedBox(height: 25),
        mainButton("Create Account", registerUser),
      ],
    );
  }

  Widget inputField(
    TextEditingController controller,
    String hint, {
    bool isPassword = false,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: TextField(
        controller: controller,
        obscureText: isPassword,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hint,
          icon: Icon(isPassword ? Icons.lock : Icons.email, color: themeColor),
        ),
      ),
    );
  }

  Widget mainButton(String text, VoidCallback onTap) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: themeColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        onPressed: onTap,
        child: Text(
          text,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
