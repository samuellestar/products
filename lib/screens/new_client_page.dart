// ignore_for_file: avoid_unnecessary_containers,

import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:forms/models/contact_model.dart';
import 'package:forms/models/product_model.dart';
import 'package:forms/models/selected_product.dart';
import 'package:forms/screens/contact_page.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import '../api/fetch_product_data.dart';

class SelectedContact {
  String name;
  String number;

  SelectedContact(this.name, this.number);
}

class PageNewClient extends StatefulWidget {
  const PageNewClient({super.key});

  @override
  State<PageNewClient> createState() => _PageNewClientState();
}

class _PageNewClientState extends State<PageNewClient> {
  late Future<List<ProductModel>> productList;
  Contact? selectedContact;

  List<ContactModel> contacts = [];
  List<SelectedProductsModel> selectedProducts = [];

  String currentAddress = 'My Address';
  late Position currentPosition;

  final formKey = GlobalKey<FormState>();
  final contactNameController = TextEditingController();
  final contactNumberController = TextEditingController();
  final contactEmailController = TextEditingController();
  final updateNameController = TextEditingController();
  final locationController = TextEditingController();
  final addContactNameController = TextEditingController();
  final addContactNumberController = TextEditingController();
  final productNameController = TextEditingController();
  final productRateController = TextEditingController();
  final productQtyController = TextEditingController();
  final productTotalController = TextEditingController();
  final productTaxController = TextEditingController();
  final taxQtyController = TextEditingController();
  final totalCostIncludExcludeController = TextEditingController();

  final type = ['End User', 'one', 'two'];
  final assignedUser = ['sajith', 'samuel', 'helen'];
  final routes = ['Ekm', 'Tsr', 'Tvm'];
  final contactType = ['Home', 'Office', 'Other'];
  final taxPercentage = ['18', '5', '0', '12', '19'];
  final taxInclude = ['Yes', 'No'];

  String? selectedType = 'End User';
  String? selectedAssignedUser = 'sajith';
  String? selectedRoute = 'Ekm';
  String? selectedContactType = 'Home';
  String? selectedTaxPercentage = '0';
  String? selectedTaxInclude = 'No';

  int selectedIndex = -1;
  int selectedProductIndex = -1;
  bool isUpdating = false;

  @override
  void initState() {
    super.initState();
    productList = fetchData();
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
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(
                            left: 10,
                            right: 10,
                          ),
                          child: TextField(
                            controller: addContactNameController,
                            decoration: const InputDecoration(),
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          selectContact();
                        },
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
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(
                            left: 10,
                            right: 10,
                          ),
                          child: TextField(
                            controller: addContactNumberController,
                            decoration: const InputDecoration(),
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

                  //follow up date/time

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
                                onTap: () {},
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
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(
                            left: 10,
                            right: 10,
                          ),
                          // child: Text(currentAddress)
                          child: TextField(
                            controller: locationController,
                            decoration: const InputDecoration(),
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          determinePosition();
                        },
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
                          ),
                        ),
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
                height: 20,
              ),

              contacts.isEmpty
                  ? Container(
                      color: Colors.transparent,
                    )
                  : Container(
                      color: Colors.white,
                      child: Expanded(
                        child: Table(
                          border: TableBorder.all(color: Colors.transparent),
                          defaultVerticalAlignment:
                              TableCellVerticalAlignment.middle,
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
                                        fontSize: 16,
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
                                        fontSize: 16,
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
                                        fontSize: 16,
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
                                        fontSize: 16,
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
                                        fontSize: 16,
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

                                          selectedContactType =
                                              contacts[index].type;
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
                            ),
                          ],
                        ),
                      ),
                    ),
              const SizedBox(
                height: 20,
              ),

              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      'Add product',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              // ignore: duplicate_ignore
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: GestureDetector(
                  onTap: () {
                    openProductDialog();
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              const Text(
                                'Search Product Name...',
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                  top: 10,
                                  left: 20,
                                  right: 20,
                                ),
                                child: Container(
                                  height: 2,
                                  color: Colors.black54,
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 20),
                          child: Icon(
                            Icons.search,
                            color: Colors.grey.shade800,
                            size: 30,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const Row(
                children: [],
              ),

              const SizedBox(
                height: 20,
              ),

              // table of add contact

              selectedProducts.isEmpty
                  ? Container(
                      color: Colors.transparent,
                    )
                  : Container(
                      color: Colors.white,
                      child: Expanded(
                        child: Table(
                          border: TableBorder.all(color: Colors.transparent),
                          defaultVerticalAlignment:
                              TableCellVerticalAlignment.middle,
                          children: [
                            const TableRow(
                              children: [
                                TableCell(
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      textAlign: TextAlign.center,
                                      'Product',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ),
                                TableCell(
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      'Qty',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                                TableCell(
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      textAlign: TextAlign.center,
                                      'Price',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            ...List.generate(
                              selectedProducts.length,
                              (index) => TableRow(
                                children: [
                                  TableCell(
                                    child: GestureDetector(
                                      onTap: () {
                                        productNameController.text =
                                            selectedProducts[index].title;
                                        productRateController.text =
                                            selectedProducts[index]
                                                .originalPrice
                                                .toString();
                                        productQtyController.text =
                                            selectedProducts[index]
                                                .qty
                                                .toString();
                                        productTotalController.text =
                                            selectedProducts[index]
                                                .price
                                                .toString();

                                        taxQtyController.text =
                                            selectedProducts[index]
                                                .qty
                                                .toString();

                                        selectedTaxInclude = 'No';
                                        selectedTaxPercentage = '0';

                                        productTaxController.text = '';
                                        totalCostIncludExcludeController.text =
                                            selectedProducts[index]
                                                .price
                                                .toString();

                                        openTaxDialog(index);
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          textAlign: TextAlign.center,
                                          selectedProducts[index].title,
                                          style: const TextStyle(
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  TableCell(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                decrementProductQuantity(index);
                                              });
                                            },
                                            //

                                            //

                                            child: Container(
                                              child: const Icon(
                                                  Icons.chevron_left),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                              right: 10,
                                              left: 10,
                                            ),
                                            child: Text(
                                              selectedProducts[index]
                                                  .qty
                                                  .toString(),
                                              style: const TextStyle(
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                incrementProductQuantity(index);
                                              });
                                            },
                                            //

                                            child: Container(
                                                child: const Icon(
                                                    Icons.chevron_right)),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  TableCell(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        textAlign: TextAlign.center,
                                        selectedProducts[index]
                                            .price
                                            .toString(),
                                        style: const TextStyle(
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

              const SizedBox(
                height: 20,
              ),

              //

              selectedProducts.isEmpty
                  ? Container(
                      color: Colors.transparent,
                    )
                  : Padding(
                      padding: const EdgeInsets.only(
                        right: 15,
                        bottom: 30,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            'Total cost: ${totalCost.toStringAsFixed(2)}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ],
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

  Future openProductDialog() => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          // ignore: sized_box_for_whitespace
          content: Container(
            width: 300,
            child: Column(
              children: [
                TextFormField(
                  // onChanged: (value) => updateList(value),
                  decoration: const InputDecoration(
                    hintText: 'Search Product Name',
                    // border: OutlineInputBorder(
                    //   borderRadius: BorderRadius.circular(0),
                    // ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: FutureBuilder<List<ProductModel>>(
                    future: productList,
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        if (snapshot.hasData) {
                          return ListView.builder(
                            itemCount: snapshot.data.length,
                            itemBuilder: (context, index) {
                              ProductModel data = snapshot.data[index];
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    copyProductContent(data);
                                    // openTaxDialog(data);
                                  });

                                  Navigator.pop(context);
                                },
                                child: Card(
                                  child: ListTile(
                                    title: Text(data.title),
                                    subtitle:
                                        Text((data.price).toStringAsFixed(2)),
                                    // leading: Text('${index + 1}'),
                                  ),
                                ),
                              );
                            },
                          );
                        } else if (snapshot.hasError) {
                          return Center(
                            child: Text('${snapshot.error}'),
                          );
                        }
                      }
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          actions: [
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: const Text(
                'Close',
              ),
            ),
          ],
        ),
      );

  void addItemToList() {
    String contactName = contactNameController.text;
    contactNameController.clear();

    String contactNumber = contactNumberController.text;
    contactNumberController.clear();

    String contactEmail = contactEmailController.text;
    contactEmailController.clear();

    selectedContactType = selectedContactType.toString();

    setState(() {
      contacts.add(ContactModel(
          contactName, contactNumber, contactEmail, selectedContactType));
    });
  }

  void copyProductContent(ProductModel product) {
    bool isExistingProduct = false;

    for (var selectedProduct in selectedProducts) {
      if (selectedProduct.title == product.title) {
        double originalPrice = product.price;
        // Product already exists in selectedProducts list
        isExistingProduct = true;
        selectedProduct.qty += 1;
        selectedProduct.price = originalPrice * selectedProduct.qty;
      }
    }

    if (!isExistingProduct) {
      // Product does not exist in selectedProducts list
      SelectedProductsModel copiedProduct = SelectedProductsModel(
        title: product.title,
        stock: product.stock,
        price: product.price,
        qty: 1,
        originalPrice: product.price,
      );
      selectedProducts.add(copiedProduct);
    }
  }

  void increseProductCount(ProductModel product) {
    for (var selectedProduct in selectedProducts) {
      if (selectedProduct.title == product.title) {
        selectedProduct.qty += 1;
        selectedProduct.price =
            selectedProduct.originalPrice * selectedProduct.qty;
      }
    }
  }

  void decrementProductQuantity(int index) {
    setState(() {
      if (selectedProducts[index].qty > 1) {
        selectedProducts[index].qty = selectedProducts[index].qty - 1;

        selectedProducts[index].price =
            selectedProducts[index].originalPrice * selectedProducts[index].qty;
      } else {
        selectedProducts.removeAt(index);
      }
    });
  }

  void incrementProductQuantity(int index) {
    setState(() {
      selectedProducts[index].qty = selectedProducts[index].qty + 1;
      selectedProducts[index].price =
          selectedProducts[index].originalPrice * selectedProducts[index].qty;
    });
  }

  double get totalCost {
    double cost = 0.0;
    for (var selectedProduct in selectedProducts) {
      cost = cost + selectedProduct.price;
    }
    return cost;
  }

  Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      Fluttertoast.showToast(msg: 'Turn on the location.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        Fluttertoast.showToast(msg: 'Permission denied.');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      Fluttertoast.showToast(msg: 'Permission denied forever.');
    }
    Position? position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    try {
      List<Placemark> placemark =
          await placemarkFromCoordinates(position.latitude, position.longitude);
      Placemark place = placemark[0];
      setState(() {
        currentPosition = position;
        currentAddress =
            "${place.street}, ${place.name}, ${place.locality}, ${place.postalCode}, ${place.country}.";
        locationController.text = currentAddress;
      });
    } catch (e) {
      Fluttertoast.showToast(msg: '');
    }
    return position;
  }

  void selectContact() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ContactsPage()),
    );

    if (result != null && result is Contact) {
      setState(() {
        selectedContact = result;
        addContactNameController.text = selectedContact!.givenName!;
        addContactNumberController.text = selectedContact!.phones![0].value!;
      });
    }
  }

  Future openTaxDialog(int index) => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          // ignore: sized_box_for_whitespace
          content: Container(
            width: 300,
            height: 400,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Product Name'),

                  TextFormField(
                    controller: productNameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),

                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text('Rate'),
                      Text('Qty'),
                      Text('Total'),
                    ],
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: productRateController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                int quantity = selectedProducts[index].qty;
                                calculateTotalRateOnDecrementInDialog(
                                    index, quantity);
                              },
                              child: Container(
                                child: const Icon(Icons.chevron_left),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  right: 10,
                                  left: 10,
                                ),
                                child: TextFormField(
                                  controller: taxQtyController,
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                calculateTotalRateOnIncrementInDialog(
                                    index, selectedProducts[index].qty);
                              },
                              child: Container(
                                  child: const Icon(Icons.chevron_right)),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: TextFormField(
                          controller: productTotalController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),

                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text('Tax (%)'),
                      Text('Tax Amount'),
                      Text('Tax Include'),
                    ],
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        child: DropdownButtonFormField(
                          value: selectedTaxPercentage,
                          items: taxPercentage
                              .map((e) => DropdownMenuItem(
                                    value: e,
                                    child: Text(e),
                                  ))
                              .toList(),
                          onChanged: (val) {
                            setState(() {
                              selectedTaxPercentage = val as String;

                              calculateTaxAmount();
                              isTaxInclude(index);
                            });
                          },
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: TextFormField(
                          controller: productTaxController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: DropdownButtonFormField(
                          value: selectedTaxInclude,
                          items: taxInclude
                              .map((e) => DropdownMenuItem(
                                    value: e,
                                    child: Text(e),
                                  ))
                              .toList(),
                          onChanged: (val) {
                            setState(() {
                              selectedTaxInclude = val as String;
                              isTaxInclude(index);
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text('Total Cost'),

                  TextFormField(
                    controller: totalCostIncludExcludeController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),

                  // Text(product.title),
                ],
              ),
            ),
          ),
          actions: [
            Align(
              alignment: Alignment.center,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    selectedProducts[index].price =
                        double.parse(totalCostIncludExcludeController.text);
                    Navigator.pop(context);
                  });
                },
                child: const Text(
                  'ADD',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
            )
          ],
        ),
      );

  void calculateTotalRateOnIncrementInDialog(int index, int qty) {
    int quantity = int.parse(taxQtyController.text);

    setState(() {
      double totalCost = selectedProducts[index].originalPrice * (quantity + 1);
      productTotalController.text = totalCost.toString();
      totalCostIncludExcludeController.text = totalCost.toString();
      taxQtyController.text = (quantity + 1).toString();
    });
  }

  void calculateTotalRateOnDecrementInDialog(int index, int qty) {
    int quantity = int.parse(taxQtyController.text);
    setState(() {
      double totalCost = selectedProducts[index].originalPrice * (quantity - 1);
      productTotalController.text = totalCost.toString();
      totalCostIncludExcludeController.text = totalCost.toString();
      taxQtyController.text = (quantity - 1).toString();
    });
  }

  void calculateTaxAmount() {
    if (selectedTaxPercentage == '0') {
      setState(() {
        productTaxController.text = '0';
      });
    }
    if (selectedTaxPercentage == '5') {
      setState(() {
        int taxPercercentage = 5;
        double productAmount = double.parse(productTotalController.text);

        double taxAmount = productAmount * (taxPercercentage / 100);
        productTaxController.text = taxAmount.toString();
      });
    }
    if (selectedTaxPercentage == '12') {
      setState(() {
        int taxPercercentage = 12;
        double productAmount = double.parse(productTotalController.text);

        double taxAmount = productAmount * (taxPercercentage / 100);
        productTaxController.text = taxAmount.toString();
      });
    }
    if (selectedTaxPercentage == '18') {
      setState(() {
        int taxPercercentage = 18;
        double productAmount = double.parse(productTotalController.text);

        double taxAmount = productAmount * (taxPercercentage / 100);
        productTaxController.text = taxAmount.toString();
      });
    }
    if (selectedTaxPercentage == '19') {
      setState(() {
        int taxPercercentage = 19;
        double productAmount = double.parse(productTotalController.text);

        double taxAmount = productAmount * (taxPercercentage / 100);
        productTaxController.text = taxAmount.toString();
      });
    }
  }

  void isTaxInclude(int index) {
    if (selectedTaxInclude == 'Yes') {
      double totalCost = double.parse(productTotalController.text) +
          double.parse(productTaxController.text);
      totalCostIncludExcludeController.text = totalCost.toString();
    } else {
      totalCostIncludExcludeController.text = productTotalController.text;
    }
  }
}
