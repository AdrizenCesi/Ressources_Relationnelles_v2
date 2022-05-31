class FieldValidator {
  static String validateEmail(value) {
    if (value.isEmpty) return 'Enter Email' ;

    //Pattern pattern = r'\S+@\S+\.\S+' ;

    RegExp regex = new RegExp(r'\S+@\S+\.\S+');

    if (!regex.hasMatch(value)) {
      return 'Enter Valid Email';
    }

    return '';
  }
  static String validatePassword(value) {
    if (value.isEmpty) return 'Enter Password';

    if (value.length < 8) {
      return 'Password must be more than 8 characters';
    }

    return '';
  }
}