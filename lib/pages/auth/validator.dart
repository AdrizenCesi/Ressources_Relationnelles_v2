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

    RegExp regexpassword = new RegExp(r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[-+!*$@%_])([-+!*$@%_\w]{8,15})$');

    if (!regexpassword.hasMatch(value)) {
      return 'Votre mot de passe ne respecte la politique de mot de passe !';
    }

    return '';
  }

  static String validateName(value) {
    if (value.isEmpty) return 'Entrez votre nom';

    return '';
  }

  static String validateFirstname(value) {
    if (value.isEmpty) return 'Entrez votre prenom';

    return '';
  }

}