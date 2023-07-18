import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class ContactsPage extends StatefulWidget {
  const ContactsPage({super.key});

  @override
  State<ContactsPage> createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  List<Contact> contacts = [];

  bool isLoading = true;

  @override
  void initState() {
    // 
    super.initState();
    getContactPermission();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.white,
          ),
        ),
        title: const Text(
          'Contacts',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        elevation: 3,
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: contacts.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.pop(
                      context,
                      contacts[index],
                    );
                  },
                  child: Card(
                    child: ListTile(
                      leading: Container(
                        height: 40,
                        width: 40,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 7,
                              color: Colors.white.withOpacity(0.1),
                              offset: const Offset(-3, -3),
                            ),
                          ],
                          borderRadius: BorderRadius.circular(6),
                          color: const Color(0xff262626),
                        ),
                        child: Text(
                          contacts[index].givenName![0],
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      title: Text(
                        contacts[index].givenName!,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      subtitle: Text(
                        contacts[index].phones![0].value!,
                        style: const TextStyle(
                          fontSize: 11,
                          color: Colors.black,
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      horizontalTitleGap: 12,
                    ),
                  ),
                );
              },
            ),
    );
  }

  void getContactPermission() async {
    if (await Permission.contacts.isGranted) {
      fetchContacts();
    } else {
      await Permission.contacts.request();
    }
  }

  void fetchContacts() async {
    contacts = await ContactsService.getContacts();

    setState(() {
      isLoading = false;
    });
  }
}
