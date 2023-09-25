import 'package:flutter/material.dart';
import 'package:mailer/smtp_server.dart';
import 'package:mailer/mailer.dart';

class UsuarioEmail extends StatelessWidget {
  const UsuarioEmail({super.key});

  @override
  Widget build(BuildContext context) {
    String username = 'amilton@cota.com.br';
    var smtpServer = gmail(username, '#amilton313131');

    enviarEmail() async {
      final message = Message()
        ..from = Address(username, 'Nome')
        ..recipients.add(username)
        ..subject = 'Teste de envio'
        ..text = 'Textando o envio de email através do flutter';

      try {
        final sendReport = await send(message, smtpServer);
        print('Message sent: $sendReport');

        return true;
      } on MailerException catch (e) {
        print('Message not sent.');
        for (var p in e.problems) {
          print('Problem: ${p.code}: ${p.msg}');
        }
        return false;
      }
    }

    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            enviarEmail();
            // sendEmail('subject', 'body', 'recipientemail');
          },
          child: const Text('Enviar email'),
        ),
      ),
    );
  }
}
