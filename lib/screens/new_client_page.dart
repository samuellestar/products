// ignore_for_file: avoid_unnecessary_containers, duplicate_ignore

import 'package:flutter/material.dart';
import 'package:forms/models/contact_model.dart';
import 'package:forms/models/product_model.dart';
import 'package:forms/models/selected_product.dart';

import '../api/fetch_product_data.dart';

class PageNewClient extends StatefulWidget {
  const PageNewClient({super.key});

  @override
  State<PageNewClient> createState() => _PageNewClientState();
}

class _PageNewClientState extends State<PageNewClient> {
  late Future<List<Product>> productList;
  // int quantity = 1;

  // void increaseQuantity() {
  //   setState(() {
  //     quantity++;
  //   });
  // }

  // void decreaseQuantity() {
  //   setState(() {
  //     if (quantity > 1) {
  //       quantity--;
  //     }
  //   });
  // }

  @override
  void initState() {
    super.initState();
    productList = fetchData();
  }

  List<Contact> contacts = [];
  List<SelectedProducts> selectedProducts = [];

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
  String? selectedRoute = 'Ekm';
  String? selectedContactType = 'Home';

  int selectedIndex = -1;
  int selectedProductIndex = -1;
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

  void copyProductContent(Product product) {
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
      SelectedProducts copiedProduct = SelectedProducts(
        title: product.title,
        stock: product.stock,
        price: product.price,
        qty: 1,
        originalPrice: product.price,
      );
      selectedProducts.add(copiedProduct);
    }
  }

  void increseProductCount(Product product) {
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
                children: [
                  // Container(
                  //   child: Column(
                  //     children: [
                  //       Text('Search Product Name...'),

                  //     ],
                  //   ),
                  // )
                  // Expanded(
                  //   child: Padding(
                  //     padding: const EdgeInsets.only(
                  //       left: 25,
                  //       right: 25,
                  //     ),
                  //     child: TextFormField(
                  //       onChanged: (value) {
                  //         // filterProducts(value);
                  //       },
                  //       decoration: InputDecoration(
                  //         suffixIcon: const Icon(Icons.search),
                  //         label: Center(
                  //           child: Text(
                  //             'Search Product Name....',
                  //             style: TextStyle(
                  //               color: Colors.grey.shade600,
                  //               fontSize: 18,
                  //               fontWeight: FontWeight.w500,
                  //             ),
                  //           ),
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                ],
              ),

              const SizedBox(
                height: 20,
              ),

              // table

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
                  child: FutureBuilder<List<Product>>(
                    future: productList,
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        if (snapshot.hasData) {
                          return ListView.builder(
                            itemCount: snapshot.data.length,
                            itemBuilder: (context, index) {
                              Product data = snapshot.data[index];
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    copyProductContent(data);
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
}
