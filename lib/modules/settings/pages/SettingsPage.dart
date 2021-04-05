import 'package:parkowa_nie/modules/core/common/i18n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:parkowa_nie/modules/core/common/empty-validator.dart';
import 'package:parkowa_nie/modules/core/model/ContactInformation.dart';
import 'package:parkowa_nie/modules/core/services/DatabaseService.dart';
import 'package:parkowa_nie/modules/core/widgets/Layout.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  TextEditingController _nameController;
  TextEditingController _addressController;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    final contact =
        Provider.of<DatabaseService>(context, listen: false).contact;

    _nameController = TextEditingController(text: contact?.fullName ?? '');
    _addressController = TextEditingController(text: contact?.address ?? '');
  }

  void _saveForm() async {
    if (_formKey.currentState.validate()) {
      await Provider.of<DatabaseService>(context, listen: false)
          .updateContactInformation(
              information: ContactInformation(
                  address: _addressController.text.trim(),
                  fullName: _nameController.text.trim()));
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Info updated'.i18n)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Layout(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Contact information'.i18n,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline5,
          ),
          Text(
            'This information will be attached to emails sent to city officials to allow them to contact you afterwars. Make sure they are accurate!'
                .i18n,
            textAlign: TextAlign.justify,
          ),
          SizedBox(height: 20),
          Expanded(
              child: Form(
            key: _formKey,
            child: ListView(
              physics: BouncingScrollPhysics(),
              children: [
                TextFormField(
                  validator: emptyValidator,
                  controller: _nameController,
                  decoration: InputDecoration(labelText: 'Full name'.i18n),
                ),
                SizedBox(height: 20),
                TextFormField(
                  validator: emptyValidator,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  controller: _addressController,
                  decoration:
                      InputDecoration(labelText: 'Address information'.i18n),
                ),
              ],
            ),
          )),
          ElevatedButton(onPressed: _saveForm, child: Text('Save'.i18n))
        ],
      ),
    );
  }
}
