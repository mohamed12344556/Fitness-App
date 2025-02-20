import 'package:fitness_app/core/routes/routs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../logic/auth_cubit.dart';
import '../logic/auth_state.dart';
import '../../../../core/di/dependency_injection.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _fullNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => sl<AuthCubit>(),
        child: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            switch (state) {
              case AuthError():
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(state.message)));
              case AuthSuccess():
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  Routes.home,
                  (route) => false, // يحذف كل الصفحات السابقة من الـ stack
                );
              case _:
                break;
            }
          },
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextFormField(
                      controller: _fullNameController,
                      decoration: const InputDecoration(labelText: 'Full Name'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your full name';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _emailController,
                      decoration: const InputDecoration(labelText: 'Email'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _passwordController,
                      decoration: const InputDecoration(labelText: 'Password'),
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed:
                          state is AuthLoading
                              ? null
                              : () {
                                if (_formKey.currentState!.validate()) {
                                  context.read<AuthCubit>().signUp(
                                    email: _emailController.text,
                                    password: _passwordController.text,
                                    fullName: _fullNameController.text,
                                  );
                                }
                              },
                      child:
                          state is AuthLoading
                              ? const CircularProgressIndicator()
                              : const Text('Sign Up'),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
