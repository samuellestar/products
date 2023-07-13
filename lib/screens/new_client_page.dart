import 'package:flutter/material.dart';
import 'package:forms/screens/home_page.dart';

class PageNewClient extends StatefulWidget {
  const PageNewClient({super.key});

  @override
  State<PageNewClient> createState() => _PageNewClientState();
}

class _PageNewClientState extends State<PageNewClient> {
  List<Contact> contacts = [];

  final formKey = GlobalKey<FormState>();
  final contactNameController = TextEditingController();
  final contactNumberController = TextEditingController();
  final contactEmailController = TextEditingController();
  final updateNameController = TextEditingController();

  final type = ['End User', 'one', 'two'];
  final assignedUser = ['sajith', 'samuel', 'helen'];
  final routes = ['Ekm', 'Tsr', 'Tvm'];
  final contactType = ['Home', 'Office', 'Other'];

  String? selectedType = 'End User';
  String? selectedAssignedUser = 'sajith';
  String? selectedRoute = '';
  String? selectedContactType = 'Home';

  int selectedIndex = -1;
  bool isUpdating = false;

  void addItemToList() {
    String contactName = contactNameController.text;
    contactNameController.clear();

    String contactNumber = contactNumberController.text;
    contactNumberController.clear();

    String contactEmail = contactEmailController.text;
    contactEmailController.clear();

    selectedContactType = selectedContactType.toString();

    setState(() {
      contacts.add(Contact(
          contactName, contactNumber, contactEmail, selectedContactType));
    });
  }

  @override
  void dispose() {
    contactNameController.dispose();
    super.dispose();

    contactNumberController.dispose();
    super.dispose();

    contactEmailController.dispose();
    super.dispose();
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
          'New Client',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        elevation: 3,
      ),

      //body

      body: Padding(
        padding: const EdgeInsets.all(5.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 15,
                  ),

                  // type

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(
                            left: 10,
                            right: 5,
                          ),
                          child: DropdownButtonFormField(
                            decoration:
                                const InputDecoration(labelText: 'Type'),
                            icon: const Icon(Icons.keyboard_arrow_down_sharp),
                            value: selectedType,
                            items: type
                                .map((e) => DropdownMenuItem(
                                      value: e,
                                      child: Text(e),
                                    ))
                                .toList(),
                            onChanged: (val) {
                              setState(() {
                                selectedType = val as String;
                              });
                            },
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),

                      // assigned user

                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(
                            left: 10,
                            right: 5,
                          ),
                          child: DropdownButtonFormField(
                            decoration: const InputDecoration(
                              labelText: 'Assigned User',
                            ),
                            icon: const Icon(Icons.keyboard_arrow_down_sharp),
                            value: selectedAssignedUser,
                            items: assignedUser
                                .map((e) => DropdownMenuItem(
                                      value: e,
                                      child: Text(e),
                                    ))
                                .toList(),
                            onChanged: (val) {
                              setState(() {
                                selectedAssignedUser = val as String;
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  ),

                  //name

                  //
                  const SizedBox(
                    height: 15,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Text('Name'),
                  ),
                  Row(
                    children: [
                      const Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(
                            left: 10,
                            right: 10,
                          ),
                          child: TextField(
                            decoration: InputDecoration(),
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.person_add_alt_1,
                          color: Colors.blue,
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.document_scanner,
                          color: Colors.blue,
                        ),
                      ),
                    ],
                  ),

                  //mobile number

                  //
                  const SizedBox(
                    height: 15,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Text('Mobile Number'),
                  ),
                  Row(
                    children: [
                      const Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(
                            left: 10,
                            right: 10,
                          ),
                          child: TextField(
                            decoration: InputDecoration(),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Image.asset(
                        'assets/images/whatsapp.jpg',
                        height: 20,
                      ),
                      const SizedBox(
                        width: 18,
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.check_box_outline_blank,
                          // color: Colors.blue,
                        ),
                      ),
                    ],
                  ),
                  //
                  //follow up date/time

                  ///
                  const SizedBox(
                    height: 15,
                  ),

                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Text('Followup Date'),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 90),
                        child: Text('Followup Time'),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(
                            left: 10,
                            right: 5,
                          ),
                          child: TextField(
                            decoration: InputDecoration(
                              suffixIcon: Icon(
                                Icons.calendar_today_outlined,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(
                            left: 5,
                            right: 10,
                          ),
                          child: TextField(
                            decoration: InputDecoration(
                              suffixIcon: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const HomePage(),
                                    ),
                                  );
                                },
                                child: const Icon(
                                  Icons.access_time,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  //

                  //location

                  const SizedBox(
                    height: 15,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Text('Location'),
                  ),
                  Row(
                    children: [
                      const Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(
                            left: 10,
                            right: 10,
                          ),
                          child: TextField(
                            decoration: InputDecoration(),
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.location_on,
                          color: Colors.blue,
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.add_circle_rounded,
                          color: Colors.blue,
                        ),
                      ),
                    ],
                  ),

                  //gst number/ route head

                  const SizedBox(
                    height: 20,
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Text('GST Number'),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 130),
                        child: Text('Routes'),
                      ),
                    ],
                  ),

                  // gst number

                  Row(
                    children: [
                      const Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(
                            left: 10,
                            right: 5,
                          ),
                          child: TextField(
                              // decoration: InputDecoration(
                              //   suffixIcon: Icon(
                              //     Icons.keyboard_arrow_down,
                              //   ),
                              // ),
                              ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),

                      //route dropdown

                      Expanded(
                        child: Padding(
                            padding: const EdgeInsets.only(
                              left: 5,
                              right: 10,
                            ),
                            child: DropdownButtonFormField(
                              items: routes
                                  .map((e) => DropdownMenuItem(
                                        value: e,
                                        child: Text(e),
                                      ))
                                  .toList(),
                              onChanged: (val) {
                                setState(() {
                                  selectedRoute = val as String;
                                });
                              },
                            )),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              GestureDetector(
                onTap: () {
                  openDialog();
                  isUpdating = false;
                  setState(() {
                    contactNameController.clear();
                    contactNumberController.clear();
                    contactEmailController.clear();
                    selectedContactType = '';
                  });
                },
                child: const Text(
                  'Add more details',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {},
                child: const Text(
                  'Add more contacts',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
              const SizedBox(
                height: 60,
              ),
              Container(
                color: Colors.white,
                child: Expanded(
                  child: Table(
                    border: TableBorder.all(color: Colors.grey),
                    defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                    children: [
                      const TableRow(
                        children: [
                          TableCell(
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                'Contact Name',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          TableCell(
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                'Contact Number',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          TableCell(
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                'Contact Type',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          TableCell(
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                'Edit',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          TableCell(
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                'Delete',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      ...List.generate(
                        contacts.length,
                        (index) => TableRow(
                          children: [
                            TableCell(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  contacts[index].name,
                                  style: const TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                            TableCell(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  contacts[index].number,
                                  style: const TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                            TableCell(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  contacts[index].type,
                                  style: const TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                            TableCell(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: GestureDetector(
                                  onTap: () {
                                    isUpdating = true;
                                    openDialog();
                                    selectedIndex = index;
                                    contactNameController.text =
                                        contacts[index].name;

                                    contactNumberController.text =
                                        contacts[index].number;

                                    contactEmailController.text =
                                        contacts[index].email;

                                    selectedContactType = contacts[index].type;
                                  },
                                  child: const Icon(
                                    Icons.mode_edit_outline_rounded,
                                    color: Colors.blue,
                                  ),
                                ),
                              ),
                            ),
                            TableCell(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: GestureDetector(
                                  onTap: () {
                                    // openDialogDelete();
                                    setState(() {
                                      contacts.removeAt(index);
                                    });
                                  },
                                  child: const Icon(
                                    Icons.delete,
                                    color: Colors.blue,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future openDialog() => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          // ignore: sized_box_for_whitespace
          content: SingleChildScrollView(
            // ignore: sized_box_for_whitespace
            child: Container(
              height: 400,
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    const Text('Contact Name'),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: TextFormField(
                              controller: contactNameController,
                              validator: (val) =>
                                  val!.isEmpty ? "enter a valid name" : null,
                            ),
                          ),
                        ),
                        const Icon(
                          Icons.person_add_alt_rounded,
                          color: Colors.blue,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text('Contact Number'),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: TextFormField(
                              controller: contactNumberController,
                              validator: (val) =>
                                  val!.isEmpty || val.length != 10
                                      ? "enter a valid number"
                                      : null,
                            ),
                          ),
                        ),
                        const Icon(
                          Icons.check_box_outline_blank,
                          color: Colors.blue,
                        ),
                        const SizedBox(
                          width: 18,
                        ),
                        Image.asset(
                          'assets/images/whatsapp.jpg',
                          height: 20,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text('Contact Type'),
                    const SizedBox(
                      height: 10,
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: 5,
                          right: 5,
                        ),
                        child: DropdownButtonFormField(
                          icon: const Icon(Icons.keyboard_arrow_down_sharp),
                          // value: selectedContactType,
                          items: contactType
                              .map((e) => DropdownMenuItem(
                                    value: e,
                                    child: Text(e),
                                  ))
                              .toList(),
                          onChanged: (val) {
                            setState(() {
                              selectedContactType = val as String;
                            });
                          },
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text('Email'),
                    const SizedBox(
                      height: 10,
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: TextFormField(
                          controller: contactEmailController,
                          validator: (val) => val!.isEmpty ||
                                  !val.contains("@") ||
                                  !val.contains(".com")
                              ? "enter a valid email"
                              : null,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
          ),
          actions: [
            Align(
              alignment: Alignment.center,
              child: ElevatedButton(
                onPressed: () {
                  if (isUpdating) {
                    final form = formKey.currentState;
                    if (form!.validate()) {
                      Navigator.pop(context);
                      setState(() {
                        contacts[selectedIndex].name =
                            contactNameController.text;

                        contacts[selectedIndex].number =
                            contactNumberController.text;

                        contacts[selectedIndex].email =
                            contactEmailController.text;

                        contacts[selectedIndex].type =
                            selectedContactType.toString();
                      });
                    }
                  } else {
                    final form = formKey.currentState;
                    if (form!.validate()) {
                      addItemToList();
                      selectedContactType = '';
                      Navigator.pop(context);
                    }
                  }
                },
                style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 50,
                      vertical: 10,
                    ),
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    )),
                child: Text(
                  isUpdating ? 'Update' : 'Add',
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 50,
                      vertical: 10,
                    ),
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    )),
                child: const Text(
                  "Close",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      );

  // Text showDetils() {
  //   return const Text(
  //     'Details',
  //     style: TextStyle(
  //       fontSize: 18,
  //       fontWeight: FontWeight.bold,
  //       decoration: TextDecoration.underline,
  //     ),
  //   );
  // }
}

class Contact {
  String name;
  String number;
  String email;
  dynamic type;

  Contact(this.name, this.number, this.email, this.type);
}
