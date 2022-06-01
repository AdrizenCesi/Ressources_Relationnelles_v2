import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ressources_relationnelles_v1/main.dart';
import 'package:ressources_relationnelles_v1/pages/auth/authenticateScreen.dart';

import 'package:ressources_relationnelles_v1/pages/auth/validator.dart';

void main() {
  test('Empty Email Test', () {
    var result = FieldValidator.validateEmail('');
    expect(result, 'Enter Email');
  });

  test('Invalid Email Test', () {
    var result = FieldValidator.validateEmail('ress');
    expect(result, 'Enter Valid Email');
  });

  test('Valid Email Test', () {
    var result = FieldValidator.validateEmail('ressour.rela@tionel.com');
    expect(result, '');
  });
  test('Empty Password Test', () {
    var result = FieldValidator.validatePassword('');
    expect(result, 'Enter Password');
  });

  test('Invalid Password Test', () {
    var result = FieldValidator.validatePassword('12dz3');
    expect(result, 'Votre mot de passe ne respecte la politique de mot de passe !');
  });

  test('Valid Password Test', () {
    var result = FieldValidator.validatePassword('Ressources21*');
    expect(result, '');
  });

  test('Valid Name Test', () {
    var result = FieldValidator.validateName('ajay');
    expect(result, '');
  });

  test('Empty Name Test', () {
    var result = FieldValidator.validateName('');
    expect(result, 'Entrez votre nom');
  });

  test('Valid Firstname Test', () {
    var result = FieldValidator.validateFirstname('ajay');
    expect(result, '');
  });

  test('Empty Firstname Test', () {
    var result = FieldValidator.validateFirstname('');
    expect(result, 'Entrez votre prenom');
  });

}
