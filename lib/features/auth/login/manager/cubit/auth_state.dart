import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthSuccessState extends AuthState {
  final UserCredential userCredential;

  AuthSuccessState({required this.userCredential});
}

class AuthErrorState extends AuthState {
  final String error;

  AuthErrorState({required this.error});
}

class AuthLoadingState extends AuthState {}
