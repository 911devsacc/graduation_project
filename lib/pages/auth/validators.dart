class Validators {
  static String? email(String? value) {
    if (value == null || value.isEmpty) return 'Enter email';
    if (!value.endsWith('@st.aabu.edu.jo')) {
      return 'Only @st.aabu.edu.jo emails allowed';
    }
    return null;
  }

  static String? password(String? value) {
    if (value == null || value.isEmpty) return 'Enter password';
    if (value.length < 6) return 'Min 6 characters';
    return null;
  }

  static String? confirmPassword(String? value, String original) {
    if (value != original) return 'Passwords do not match';
    return null;
  }
}