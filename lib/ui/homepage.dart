import 'package:agenda_de_contatos/ui/contacts_page.dart';
import 'package:flutter/material.dart';
import 'package:agenda_de_contatos/helpers/contact_helper.dart';
import 'dart:io';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  ContactHelper helper = ContactHelper();

  List<Contact> contacts = List();

  void _showContactPage({Contact contact}) async {
    final recContact = await Navigator.push(context, MaterialPageRoute(builder: (context) => ContactPage(contact: contact,)));
    if(recContact != null){
      if(contact != null){
        await helper.updateContact(recContact);
        _getAllContacts();
      } else {
        await helper.saveContact(recContact);
      }
      _getAllContacts();
    }
  }

  void _getAllContacts(){
    helper.getAllContacts().then((list){
      setState((){
        contacts = list;
      });
    });
  }

  @override
  void initState() {
    super.initState();

    _getAllContacts();
  }

  Widget _contactCard(BuildContext context, int index){
    return GestureDetector(
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Row(
            children: [
              Container(
                width: 80.0,
                height: 80.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: contacts[index].img != null ?
                    FileImage(File(contacts[index].img)) :
                      AssetImage("images/personal.png")
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(contacts[index].name ?? "",
                      style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),),
                    Text(contacts[index].email ?? "",
                      style: TextStyle(fontSize: 18.0),),
                    Text(contacts[index].phone ?? "",
                      style: TextStyle(fontSize: 18.0),),
                  ],
                  ),
              )
            ],
          ),
        ),
      ),
      onTap: (){
        _showContactPage(contact: contacts[index]);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Contatos"),
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          _showContactPage();
        },
          child: Icon(Icons.add),
          backgroundColor: Colors.blueAccent,
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(10.0),
        itemCount: contacts.length,
        itemBuilder: (context, index){
          return _contactCard(context, index);
        }
        ),
    );
  }
}