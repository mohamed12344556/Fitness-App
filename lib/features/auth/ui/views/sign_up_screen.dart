import 'package:fitness_app/core/routes/routs.dart';
import 'package:fitness_app/features/auth/ui/views/signup_page_one.dart';
import 'package:fitness_app/features/auth/ui/views/signup_page_two.dart';
import 'package:fitness_app/features/auth/ui/widgets/confirmation_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../logic/auth_cubit.dart';
import '../logic/auth_state.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _fullNameController = TextEditingController();

  // Controllers for additional fields
  final _birthYearController = TextEditingController();
  final _birthMonthController = TextEditingController();
  final _birthDayController = TextEditingController();
  final _heightController = TextEditingController(text: '177');
  final _weightController = TextEditingController(text: '71');

  // To track which page we are on
  int _currentPage = 0;
  final int _totalPages = 2;

  // PageController for swiping between pages
  final PageController _pageController = PageController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _fullNameController.dispose();
    _birthYearController.dispose();
    _birthMonthController.dispose();
    _birthDayController.dispose();
    _heightController.dispose();
    _weightController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  void _showConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return ConfirmationDialog(
          onConfirm: () {
            if (_formKey.currentState!.validate()) {
              context.read<AuthCubit>().signUp(
                email: _emailController.text,
                password: _passwordController.text,
                fullName: _fullNameController.text,
                birthYear: _birthYearController.text,
                birthMonth: _birthMonthController.text,
                birthDay: _birthDayController.text,
                height: _heightController.text,
                weight: _weightController.text,
              );
            }
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccess) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            Routes.home,
            (route) => false,
          );
        } else if (state is AuthError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: const Color(0xFF001845),
          body: SafeArea(
            child: SingleChildScrollView(
              child: SizedBox(
                height: MediaQuery.of(context).size.height -
                    MediaQuery.of(context).padding.top -
                    MediaQuery.of(context).padding.bottom,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        const SizedBox(height: 40),
                        // Header
                        const Text(
                          "SIGN UP",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Text(
                          "CREATE AN ACCOUNT TO GET STARTED",
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        ),
                        const SizedBox(height: 30),
    
                        // Page dots indicator
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(
                            _totalPages,
                            (index) => Container(
                              margin: const EdgeInsets.symmetric(horizontal: 5),
                              width: 10,
                              height: 10,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color:
                                    index == _currentPage
                                        ? Colors.white
                                        : Colors.white.withOpacity(0.3),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),
    
                        // Pages content
                        Expanded(
                          child: PageView(
                            controller: _pageController,
                            onPageChanged: (page) {
                              setState(() {
                                _currentPage = page;
                              });
                            },
                            children: [
                              // First page - Basic information
                              SignupPageOne(
                                fullNameController: _fullNameController,
                                emailController: _emailController,
                                passwordController: _passwordController,
                              ),
    
                              // Second page - Additional information
                              SignupPageTwo(
                                birthYearController: _birthYearController,
                                birthMonthController: _birthMonthController,
                                birthDayController: _birthDayController,
                                heightController: _heightController,
                                weightController: _weightController,
                              ),
                            ],
                          ),
                        ),
    
                        // Next button and page indicator
                        ElevatedButton(
                          onPressed: state is AuthLoading
                              ? null
                              : () {
                                  if (_currentPage < _totalPages - 1) {
                                    // Validate the first page before proceeding
                                    if (_currentPage == 0) {
                                      if (_emailController.text.isEmpty ||
                                          _passwordController.text.isEmpty ||
                                          _fullNameController.text.isEmpty) {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          const SnackBar(
                                              content: Text('Please fill all required fields')),
                                        );
                                        return;
                                      }
                                    }
                                    
                                    _pageController.nextPage(
                                      duration: const Duration(milliseconds: 300),
                                      curve: Curves.easeInOut,
                                    );
                                  } else {
                                    _showConfirmationDialog(context);
                                  }
                                },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF1E65F3),
                            minimumSize: const Size(double.infinity, 55),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          child:
                              state is AuthLoading
                                  ? const CircularProgressIndicator(
                                    color: Colors.white,
                                  )
                                  : Text(
                                    _currentPage < _totalPages - 1 ? "NEXT" : "SIGN UP",
                                    style: const TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                        ),
                        const SizedBox(height: 10),
                        TextButton(
                          onPressed:
                              state is AuthLoading
                                  ? null
                                  : () {
                                    Navigator.pushNamed(context, Routes.logIn);
                                  },
                          child: const Text(
                            "HAVE AN ACCOUNT?",
                            style: TextStyle(
                              color: Color(0xFF1E65F3),
                              fontSize: 14,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}