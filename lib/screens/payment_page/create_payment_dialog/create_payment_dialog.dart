import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_admin_dashboard/common/widget/app_button.dart';
import 'package:responsive_admin_dashboard/screens/company_page/controller/company_controller.dart';
import 'package:responsive_admin_dashboard/screens/company_page/model/company_response.dart';
import 'package:responsive_admin_dashboard/screens/payment_page/controller/payment_controller.dart';

class CreatePaymentDialog extends StatefulWidget {
  const CreatePaymentDialog({Key? key}) : super(key: key);

  @override
  _CreatePaymentDialogState createState() => _CreatePaymentDialogState();
}

class _CreatePaymentDialogState extends State<CreatePaymentDialog> {
  TextEditingController _companyController = TextEditingController();
  TextEditingController _typeController = TextEditingController();
  TextEditingController _dateController = TextEditingController();
  TextEditingController _amountController = TextEditingController();
  GlobalKey<AutoCompleteTextFieldState<CompanyPayload>> key = new GlobalKey();
  CompanyPayload? selectedCompany;
  final formGlobalKey = GlobalKey<FormState>();
  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      Provider.of<CompanyController>(context, listen: false)
          .getCompanyList(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add payment"),
        centerTitle: false,
      ),
      body: Container(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: Form(
            key: formGlobalKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: 50,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Consumer<CompanyController>(
                        builder: (context, data, child) {
                          return AutoCompleteTextField<CompanyPayload>(
                            decoration:  InputDecoration(
                                hintText: selectedCompany == null
                                    ? "Search Company:"
                                    : selectedCompany!.companyName),
                            itemSubmitted: (item) {
                              print("itemSubmitted ${item.id}");
                              setState(() {
                                selectedCompany = item;
                                _companyController.text = item.companyName;
                              });
                            },
                            key: new GlobalKey(),
                            controller: _companyController,
                            suggestions: data.companyList,
                            itemBuilder: (context, suggestion) => new Padding(
                                child: Text(suggestion.companyName),
                                padding: EdgeInsets.all(8.0)),
                            itemSorter: (a, b) => a.id == b.id
                                ? 0
                                : a.id > b.id
                                    ? -1
                                    : 1,
                            itemFilter: (suggestion, input) => suggestion
                                .companyName
                                .toLowerCase()
                                .startsWith(input.toLowerCase()),
                          );
                        },
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: _textFormField(
                        hint: "Payment Type",
                        controller: _typeController,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () async {
                          var result = await showDatePicker(
                              context: context,
                              initialDate: selectedDate,
                              firstDate: DateTime(1990),
                              lastDate: DateTime(2200));
                          if (result != null) {
                            selectedDate = result;
                            _dateController.text = "${selectedDate.day}:${selectedDate.month}:${selectedDate.year}";
                          }
                        },
                        child: _textFormField(
                          hint: "Date",
                          controller: _dateController,
                          isEnable: false,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Expanded(
                        child: _textFormField(
                            hint: "Amount", controller: _amountController)),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                AppButton(
                  onTap: () {
                    if (formGlobalKey.currentState!.validate()) {
                      Provider.of<PaymentController>(context, listen: false)
                          .addPayment(context, {
                        "ACTION_KEY": "ADD_UPDATE_PAYMENT",
                        "company_id": selectedCompany!.id.toString(),
                        "type": _typeController.text.trim(),
                        "date": _dateController.text.trim(),
                        "amount": _amountController.text.trim(),
                      });
                    }
                    // order_id
                  },
                  btnText: "Submit",
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _textFormField(
      {required String hint, TextEditingController? controller,bool isEnable=true}) {
    return TextFormField(
      controller: controller,
      enabled: isEnable,
      decoration: InputDecoration(
        hintText: hint,
      ),
    );
  }
}
