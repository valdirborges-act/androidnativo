import 'package:flutter/material.dart';
import 'package:encrypt/encrypt.dart' as cripto;

class AESView extends StatelessWidget {
  static const routeName = '/aes';
  const AESView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController textoParaCriptografar = TextEditingController();
    TextEditingController textoCriptografado = TextEditingController();

    String textoDecriptografado = "";

    // Deve ter 32 caracteres
    const chave = "Esta chave deve ter 32caracteres";
    cripto.Encrypted encrypted =  encryptWithAES(chave, "A");

    return Scaffold(
      appBar: AppBar(
        title: const Text('CRIPTOGRAFIA'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 30),
              const Text(
                'criptografia algotitmo AES-CBC-PKSC7',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 24),
              TextField(
                controller: textoParaCriptografar,
                decoration: const InputDecoration(
                  labelText: 'Texto a ser criptografado',
                  border: OutlineInputBorder(),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () async {
                      encrypted =
                          encryptWithAES(chave, textoParaCriptografar.text);
                      textoCriptografado.text = encrypted.base64;
                    },
                    style: ButtonStyle(
                      backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.blue),
                    ),
                    child: const Text(
                      'Criptografar',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  const SizedBox(width: 50),
                  TextButton(
                    onPressed: () async {
                      textoParaCriptografar.text = "";
                    },
                    style: ButtonStyle(
                      backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.blue),
                    ),
                    child: const Text(
                      'Limpar',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              const Text(
                'Texto criptografado',
                style: TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 24),
              TextField(
                controller: textoCriptografado,
                decoration: const InputDecoration(
                  labelText: 'Texto criptografado',
                  border: OutlineInputBorder(),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () async {

                      textoDecriptografado = decryptWithAES(chave, encrypted);

                      showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            title: const Text('Texto Decriptografado!'),
                            content: Text(textoDecriptografado),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () =>
                                    Navigator.pop(context, 'OK'),
                                child: const Text('OK'),
                              ),
                            ],
                          ));
                    },
                    style: ButtonStyle(
                      backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.blue),
                    ),
                    child: const Text(
                      'Decriptografar',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  const SizedBox(width: 50),
                  TextButton(
                    onPressed: () async {
                      textoCriptografado.text = "";
                      textoDecriptografado = "";
                    },
                    style: ButtonStyle(
                      backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.blue),
                    ),
                    child: const Text(
                      'Limpar',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(Icons.backspace),
        label: const Text('Volta'),
        backgroundColor: Colors.indigoAccent,
      ),
    );
  }

  String decryptWithAES(String key, cripto.Encrypted encryptedData) {
    final cipherKey = cripto.Key.fromUtf8(key);
    final encryptService = cripto.Encrypter(cripto.AES(cipherKey,
        mode: cripto.AESMode.cbc)); //Using AES CBC encryption
    final initVector = cripto.IV.fromUtf8(key.substring(0,
        16)); //Here the IV is generated from key. This is for example only. Use some other text or random data as IV for better security.

    return encryptService.decrypt(encryptedData, iv: initVector);
  }

  cripto.Encrypted encryptWithAES(String key, String plainText) {
    final cipherKey = cripto.Key.fromUtf8(key);
    final encryptService =
    cripto.Encrypter(cripto.AES(cipherKey, mode: cripto.AESMode.cbc));
    final initVector = cripto.IV.fromUtf8(key.substring(0,
        16)); //Here the IV is generated from key. This is for example only. Use some other text or random data as IV for better security.

    cripto.Encrypted encryptedData =
    encryptService.encrypt(plainText, iv: initVector);
    return encryptedData;
  }
}
