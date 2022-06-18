import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_admin_dashboard/common/widget/app_button.dart';
import 'package:responsive_admin_dashboard/screens/company_page/controller/company_controller.dart';

class CreateCompanyDialog extends StatefulWidget {
  const CreateCompanyDialog({Key? key}) : super(key: key);

  @override
  _CreateCompanyDialogState createState() => _CreateCompanyDialogState();
}

class _CreateCompanyDialogState extends State<CreateCompanyDialog> {
  TextEditingController _companyController = TextEditingController();
  TextEditingController _companyMobileController = TextEditingController();
  TextEditingController _companyEmailController = TextEditingController();
  TextEditingController _companyAddressController = TextEditingController();
  TextEditingController _companyGstController = TextEditingController();
  TextEditingController _customerNameController = TextEditingController();
  TextEditingController _customerMobileController = TextEditingController();
  TextEditingController _customerEmailController = TextEditingController();
  final formGlobalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add customer"),
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
                    "Company Information",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: _textFormField(
                        hint: "Name",
                        controller: _companyController,
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Expanded(
                        child: _textFormField(
                      hint: "Mobile",
                      controller: _companyMobileController,
                    )),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                        child: _textFormField(
                      hint: "Email",
                      controller: _companyEmailController,
                    )),
                    SizedBox(
                      width: 20,
                    ),
                    Expanded(
                        child: _textFormField(
                      hint: "Address",
                      controller: _companyAddressController,
                    )),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                        child: _textFormField(
                      hint: "GST number",
                      controller: _companyGstController,
                    )),
                    SizedBox(
                      width: 20,
                    ),
                    Expanded(child: Container()),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 50,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Owner Information",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                        child: _textFormField(
                      hint: "Name",
                      controller: _customerNameController,
                    )),
                    SizedBox(
                      width: 20,
                    ),
                    Expanded(
                        child: _textFormField(
                      hint: "Mobile",
                      controller: _customerMobileController,
                    )),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                        child: _textFormField(
                      hint: "Email",
                      controller: _customerEmailController,
                    )),
                    SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: Container(),
                    ),
                  ],
                ),
                AppButton(
                  onTap: () {
                    if (formGlobalKey.currentState!.validate()) {
                      Provider.of<CompanyController>(context, listen: false)
                          .addCompany(context, {
                        "ACTION_KEY": "ADD_UPDATE_COMPANY",
                        "company_name": _companyController.text.trim(),
                        "company_mobile": _companyMobileController.text.trim(),
                        "company_email": _companyEmailController.text.trim(),
                        "company_address":
                            _companyAddressController.text.trim(),
                        "owner_name": _customerNameController.text.trim(),
                        "owner_mobile": _customerMobileController.text.trim(),
                        "owner_email": _customerEmailController.text.trim(),
                        "gst_no": _companyGstController.text.trim(),
                      });
                    }
                    // company_id
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
      {required String hint, TextEditingController? controller}) {
    return TextFormField(
      controller: controller,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter some text';
        }
        return null;
      },
      decoration: InputDecoration(
        hintText: hint,
      ),
    );
  }
}
