import 'package:flutter/material.dart';

class PageCrypto extends StatelessWidget {
  PageCrypto({super.key});

  @override
  Widget build(BuildContext context) {

    return Container(
      child: MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: Text('Criptografia POC'),
          ),
          body: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Center(
                  child: ElevatedButton(
                    child: Text('AES'),
                    onPressed: () {
                      print('Clicou no botão');

                      Navigator.pushNamed(context, '/aes');
                    },
                  ),
                ),
                Center(
                  child: ElevatedButton(
                    child: Text('RSA'),
                    onPressed: () {
                      print('Clicou no botão');

                      Navigator.pushNamed(context, '/rsa');
                    },
                  ),
                ),
              ]),
        ),
      ),
    );
  }
}