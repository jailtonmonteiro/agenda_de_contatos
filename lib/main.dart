import 'package:flutter/material.dart';

import 'package:agenda_de_contatos/ui/homepage.dart';
import 'package:agenda_de_contatos/ui/contacts_page.dart';

void main(){
  runApp(MaterialApp(
    home: ContactPage(),
    debugShowCheckedModeBanner: false,
  ));
}