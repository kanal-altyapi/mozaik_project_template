extension StringExtension on String {
  bool get isNullEmptyOrWhitespace =>  isEmpty || trim().isEmpty;
}

extension StringNullExtension on String? {
  bool get isNullOrEmpty {
    if (null == this) {
      return true;
    } else {
      if (this!.isEmpty || this!.trim().isEmpty) {
        return true;
      }
      return false;
    }
  }

  String  toNullString() {
    if (null == this) {
      return '';
    } else {
      return this!;
    }
  }
}
