import 'package:flutter/material.dart';
import 'package:encrypt/encrypt.dart' as cripto;
import 'package:flutter/services.dart';
import 'package:pointycastle/asymmetric/api.dart';
import 'package:encrypt/encrypt_io.dart';

class RSAView extends StatefulWidget {
  static const routeName = '/rsa';
  RSAView({Key? key}) : super(key: key);

  @override
  State<RSAView> createState() => _RSAViewState();
}

class _RSAViewState extends State<RSAView> {

  @override
  Widget build(BuildContext context) {

    TextEditingController textoParaCriptografar = TextEditingController();
    TextEditingController textoCriptografado = TextEditingController();

    String textoDecriptografado = "";

    Future<void> criptografa() async {
      final publicPem = await rootBundle.loadString('assets/rsa_public.pem');
      final privatePem = await rootBundle.loadString('assets/rsa_private.pem');
      final publicKey = cripto.RSAKeyParser().parse(publicPem) as RSAPublicKey;
      final privateKey = cripto.RSAKeyParser().parse(privatePem) as RSAPrivateKey;

      cripto.Encrypter encrypter;
      cripto.Encrypted encrypted;
      String decrypted;

      encrypter = cripto.Encrypter(cripto.RSA(publicKey: publicKey, privateKey: privateKey));

      print(textoParaCriptografar.text);

      encrypted = encrypter.encrypt(textoParaCriptografar.text);

      textoCriptografado.text = encrypted.base64;

      decrypted = encrypter.decrypt(encrypted);

      textoDecriptografado = decrypted;

      print('RSA PKCS1');
      print("Decriptado: " + decrypted);
      print("Encriptado bytes: ");
      print(encrypted.bytes);
      print("Encriptado base16: ");
      print(encrypted.base16);
      print("Encriptado base64: ");
      print(encrypted.base64);

    }

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
                'criptografia algotitmo RSA PKCS1',
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
                      criptografa();
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
}
