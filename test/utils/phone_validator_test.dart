import 'package:dashboard/utils/phone_validator.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('PhoneValidator', () {
    group('isValid', () {
      test('Valid phone numbers with correct prefixes', () {
        // Valid number with +989 prefix (13 digits)
        expect(PhoneValidator.isValid('+989123456789'), true);
        // Valid number with 989 prefix (11 digits)
        expect(PhoneValidator.isValid('98912345678'), true);
        // Valid number with 09 prefix (11 digits)
        expect(PhoneValidator.isValid('09123456789'), true);
        // Valid number with Persian digits
        expect(PhoneValidator.isValid('۰۹۱۲۳۴۵۶۷۸۹'), true);
        expect(PhoneValidator.isValid('+۹۸۹۱۲۳۴۵۶۷۸۹'), true);
      });

      test('Invalid phone numbers (wrong prefixes)', () {
        expect(PhoneValidator.isValid('+981234567890'),
            false); // Wrong country code
        expect(PhoneValidator.isValid('08123456789'), false); // Invalid prefix
        expect(PhoneValidator.isValid('0912345'), false); // Too short
      });

      test('Invalid phone numbers (incorrect length)', () {
        expect(
            PhoneValidator.isValid('+98912345'), false); // Too short (8 digits)
        expect(
            PhoneValidator.isValid('0912345'), false); // Too short (7 digits)
        expect(PhoneValidator.isValid('989123'), false); // Too short (6 digits)
      });
    });

    group('format', () {
      test('Normalization of valid numbers', () {
        expect(PhoneValidator.format('۰۹۱۲۳۴۵۶۷۸۹'), '09123456789');
        expect(PhoneValidator.format('09 12-345\$6789'), '09123456789');
        expect(PhoneValidator.format('+۹۸۹۱ ۲۳۴۵۶۷۸۹'), '+989123456789');
      });

      test('Return null for invalid numbers', () {
        expect(PhoneValidator.format('08123456789'), null); // Wrong prefix
        expect(PhoneValidator.format('09123'), null); // Too short
      });
    });
  });
}
