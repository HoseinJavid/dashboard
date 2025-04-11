class PhoneValidator {
  static const _validPrefixes = ['+989', '989', '09'];

  static String? format(String phone) {
    final normalized = _normalizeNumber(phone);
    if (!_isValid(normalized)) return null;
    return normalized;
  }

  static bool isValid(String phone) => _isValid(_normalizeNumber(phone));

  static String _normalizeNumber(String phone) {
    return phone
        .replaceAllMapped(
          RegExp(r'[۰-۹]'),
          (Match m) => String.fromCharCode(m[0]!.codeUnitAt(0) - 1728),
        )
        .replaceAll(RegExp(r'[^0-9+]'), '');
  }

  static bool _isValid(String phone) {
    return _validPrefixes.any((prefix) => phone.startsWith(prefix)) &&
        phone.length >= 11;
  }
}