import 'package:encrypt/encrypt.dart';

class Encrypt {

  static const String keyString = 'Your16CharacterK';

  static String encryptText({required text}) {
    final key = Key.fromUtf8(keyString);
    final encrypter = Encrypter(AES(key, mode: AESMode.cbc));
    final initVector = IV.fromUtf8(keyString.substring(0, 16));
    Encrypted encryptedData = encrypter.encrypt(text, iv: initVector);
    String result = encryptedData.base64;
    return result;
  }

  static String decryptedText({required text}) {
    Encrypted encrypted = Encrypted.fromBase64(text);
    final key = Key.fromUtf8(keyString);
    final encrypter = Encrypter(AES(key, mode: AESMode.cbc));
    final initVector = IV.fromUtf8(keyString.substring(0, 16));
    String result = encrypter.decrypt(encrypted, iv: initVector);
    return result;
  }

}
