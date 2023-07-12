import 'package:flutter/material.dart';
import 'package:forms/screens/home_page.dart';

class PageNewClient extends StatefulWidget {
  const PageNewClient({super.key});

  @override
  State<PageNewClient> createState() => _PageNewClientState();
}

class _PageNewClientState extends State<PageNewClient> {
  final type = ['End User', 'one', 'two'];
  final assignedUser = ['sajith', 'samuel', 'helen'];
  final routes = ['Ekm', 'Tsr', 'Tvm'];
  final contactType = ['one', 'two', 'three'];

  String? selectedType = 'End User';
  String? selectedAssignedUser = 'sajith';
  String? selectedRoute = '';
  String? selectedContactType = '';

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
              )
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
                          child: TextFormField(),
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
                          child: TextFormField(),
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
                      child: TextFormField(),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ),
          actions: [
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
                  "ADD",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            )
          ],
        ),
      );
}
