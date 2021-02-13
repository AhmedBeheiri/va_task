import 'package:flutter/material.dart';

class CacheException implements Exception {
  final String message;

  CacheException(this.message);
}
