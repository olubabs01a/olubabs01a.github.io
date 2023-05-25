import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';

import 'utils/get_material_state_colors.dart';
import 'utils/on_error.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({super.key});

  @override
  ContactPageState createState() {
    return ContactPageState();
  }
}

// Define a corresponding State class.
// This class holds data related to the form.
class ContactPageState extends State<ContactPage> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a `GlobalKey<FormState>`,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();
  final _emailSent = false;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    Future<void> validateAndSendEmail() async {
      final Email email = Email(
        body: "THIS IS A TEST",
        subject: "[olubabs01a] Inquiry from 'test",
        recipients: ['osb1271.rit@gmail.com'],
        isHTML: true,
      );

      try {
        await FlutterEmailSender.send(email);
        setState(() {
          _emailSent: true;
        });

        // Reset all text fields
        _formKey.currentState?.reset();
      } on Exception catch (e) {
        onError(context, e);
        rethrow;
      } finally {
        Timer(const Duration(seconds: 5), () {
          setState(() {
            _emailSent: false;
          });
        });
      }
    }

    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            // Make better use of wide windows with a grid.
            child: Padding(
                padding: const EdgeInsets.all(30),
                child: ListView(scrollDirection: Axis.vertical, children: [
                  Column(children: [
                    const Padding(
                        padding: EdgeInsets.all(30),
                        child: CircleAvatar(
                          maxRadius: 100,
                          backgroundImage: AssetImage('images/2765p.jpg'),
                        )),
                    Padding(
                        padding: const EdgeInsets.all(15),
                        child: TextFormField(
                            decoration: const InputDecoration(
                              filled: true,
                              errorMaxLines: 3,                                hintText: 'Full Name',
                                border: UnderlineInputBorder(),
                                prefixIcon: Icon(Icons.person_2_rounded)),
                            autocorrect: false,
                            autofocus: true,
                            autovalidateMode: AutovalidateMode.always,
                            validator: (value) =>
                                RegExp(r"\w+(?:\s+\w+)+").hasMatch(value!) ==
                                        false
                                    ? 'A full name is required'
                                    : null)),
                    Padding(
                        padding: const EdgeInsets.all(15),
                        child: TextFormField(
                            decoration: const InputDecoration(
                              filled: true,
                              errorMaxLines: 3,
                              hintText: 'Email',
                              border: UnderlineInputBorder(),
                              prefixIcon: Icon(Icons.email_rounded),
                            ),
                            keyboardType: TextInputType.emailAddress,
                            enableSuggestions: true,
                            autocorrect: false,
                            autovalidateMode: AutovalidateMode.always,
                            validator: (value) =>
                                RegExp(r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])+")
                                            .hasMatch(value!) ==
                                        false
                                    ? 'A valid email address is required'
                                    : null)),
                    Padding(
                        padding: const EdgeInsets.all(15),
                        child: TextFormField(
                          decoration: const InputDecoration(
                              filled: true,
                              errorMaxLines: 3,                            hintText: 'Phone',
                            border: UnderlineInputBorder(),
                            prefixIcon: Icon(Icons.phone_rounded),
                          ),
                          keyboardType: TextInputType.phone,
                        )),
                    Padding(
                        padding: const EdgeInsets.all(15),
                        child: TextFormField(
                            decoration: const InputDecoration(
                              filled: true,
                              errorMaxLines: 3,                              hintText: 'Message',
                              border: OutlineInputBorder(),
                            ),
                            keyboardType: TextInputType.text,
                            maxLines: 8,
                            minLines: 3,
                            autovalidateMode: AutovalidateMode.always,
                            validator: (value) => value!.isEmpty
                                ? 'A message is required'
                                : null)),
                    Padding(
                        padding: const EdgeInsets.all(20),
                        child: ElevatedButton.icon(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                // If the form is valid, display a snackbar. In the real world,
                                // you'd often call a server or save the information in a database.
                                // ScaffoldMessenger.of(context).showSnackBar(
                                //   const SnackBar(content: Text('Processing...')),
                                // );
                                validateAndSendEmail();
                              }
                            },
                            icon: const Icon(Icons.send_rounded),
                            label: const Text('Submit'),
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.resolveWith((s) => 
                          getBackgroundColor(s, theme, _emailSent)),
                                foregroundColor:
                                    MaterialStateProperty.resolveWith(
                                        (s) => 
                          getForegroundColor(s, theme, _emailSent)))))
                  ]),
                ])),
          ),
        ],
      ),
    );
  }
}
