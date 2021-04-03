String emptyValidator(String value) {
  if (value.trim().isEmpty) {
    return "Cannot be empty";
  }
  return null;
}
