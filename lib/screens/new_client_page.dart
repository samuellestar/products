import 'package:flutter/material.dart';
import 'package:forms/screens/home_page.dart';

class PageNewClient extends StatefulWidget {
  const PageNewClient({super.key});

  @override
  State<PageNewClient> createState() => _PageNewClientState();
}

class _PageNewClientState extends State<PageNewClient> {
  List<String> contactNameList = [];
  List<String> contactNumberList = [];
  List<String> contactTypeList = [];
  List<String> contactEmailList = [];

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
  String? selectedContactType = '';

  int selectedIndex = -1;

  void addItemToList() {
    setState(() {
      contactNameList.add(contactNameController.text);
      contactNameController.clear();

      contactNumberList.add(contactNumberController.text);
      contactNumberController.clear();

      contactEmailController.clear();

      contactTypeList.add(selectedContactType.toString());
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

                  // DropdownButtonFormField(
                  //   decoration: InputDecoration(labelText: 'Type'),
                  //   icon: Icon(Icons.keyboard_arrow_down_sharp),
                  //   value: selectedType,
                  //   items: type
                  //       .map((e) => DropdownMenuItem(
                  //             child: Text(e),
                  //             value: e,
                  //           ))
                  //       .toList(),
                  //   onChanged: (val) {
                  //     setState(() {
                  //       selectedType = val as String;
                  //     });
                  //   },
                  // ),

                  //
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              GestureDetector(
                onTap: () {
                  openDialog();
                  // setState(() {
                  //   contactNameController.clear();
                  //   contactNumberController.clear();
                  //   contactEmailController.clear();
                  //   selectedContactType = '';
                  // });
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
              const Text(
                'Add more contacts',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline,
                ),
              ),
              const SizedBox(
                height: 60,
              ),

              // detils

              // Column(
              //   children: [
              //     const Text(
              //       'DETAILS',
              //       style: TextStyle(
              //         fontSize: 18,
              //         fontWeight: FontWeight.bold,
              //       ),
              //     ),
              //     // const SizedBox(
              //     //   height: 20,
              //     // ),
              //     Container(
              //       color: Colors.black,
              //       height: 4,
              //     ),
              //     const SizedBox(
              //       height: 20,
              //     ),
              //     Text(
              //       'Contact Name: ${contactNameController.text}',
              //       style: const TextStyle(
              //         color: Colors.black,
              //         fontSize: 16,
              //       ),
              //     ),
              //     const SizedBox(
              //       height: 20,
              //     ),
              //     Text(
              //       'Contact Number: ${contactNumberController.text}',
              //       style: const TextStyle(
              //         color: Colors.black,
              //         fontSize: 16,
              //       ),
              //     ),
              //     const SizedBox(
              //       height: 20,
              //     ),
              //     Text(
              //       'Contact Email: ${contactEmailController.text}',
              //       style: const TextStyle(
              //         fontSize: 16,
              //         color: Colors.black,
              //       ),
              //     ),
              //     const SizedBox(
              //       height: 20,
              //     ),
              //     Text(
              //       'Contact Type: $selectedContactType',
              //       style: const TextStyle(
              //         color: Colors.black,
              //         fontSize: 16,
              //       ),
              //     ),
              //     Container(
              //       color: Colors.black,
              //       height: 4,
              //     ),
              //   ],
              // )

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
                        contactNameList.length,
                        (index) => TableRow(
                          children: [
                            TableCell(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  contactNameList[index],
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
                                  contactNumberList[index],
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
                                  contactTypeList[index],
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
                                    openUpdateDialog();
                                    selectedIndex = index;
                                    contactNameController.text =
                                        contactNameList[index];

                                    contactNumberController.text =
                                        contactNumberList[index];

                                    contactEmailController.text =
                                        contactEmailList[index];

                                    selectedContactType =
                                        contactTypeList[index];
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
                                      contactNameList.removeAt(index);
                                      contactNumberList.removeAt(index);
                                      contactTypeList.removeAt(index);
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
                  final form = formKey.currentState;
                  if (form!.validate()) {
                    addItemToList();
                    selectedContactType = '';
                    Navigator.pop(context);
                  } else {}
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
                  "ADD",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            )
          ],
        ),
      );

  Text showDetils() {
    return const Text(
      'Details',
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        decoration: TextDecoration.underline,
      ),
    );
  }

  Future openUpdateDialog() => showDialog(
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
                  final form = formKey.currentState;
                  if (form!.validate()) {
                    Navigator.pop(context);
                    contactNameList[selectedIndex] = contactNameController.text;

                    contactNumberList[selectedIndex] =
                        contactNumberController.text;

                    contactEmailList[selectedIndex] =
                        contactEmailController.text;

                    contactTypeList[selectedIndex] = selectedType.toString();
                  } else {}
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
                  "UPDATE",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            )
          ],
        ),
      );

  //
}
