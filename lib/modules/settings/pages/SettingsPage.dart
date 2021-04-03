import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:parkowa_nie/modules/core/model/ContactInformation.dart';
import 'package:parkowa_nie/modules/core/services/DatabaseService.dart';
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

  String _emptyValidator(String text) {
    if (text.trim().isEmpty) {
      return "Cannot be empty";
    }
    return null;
  }

  void _saveForm() async {
    if (_formKey.currentState.validate()) {
      await Provider.of<DatabaseService>(context, listen: false)
          .updateContactInformation(
              information: ContactInformation(
                  address: _addressController.text.trim(),
                  fullName: _nameController.text.trim()));
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Info updated')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Hero(
          child:
              Text('parkowaNIE', style: Theme.of(context).textTheme.headline5),
          tag: 'bar/title',
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Contact information',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline5,
            ),
            Text(
              'This information will be attached to emails sent to city officials',
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
                    validator: _emptyValidator,
                    controller: _nameController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderSide: BorderSide(
                          width: 5.0,
                        )),
                        labelText: 'Full name'),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    validator: _emptyValidator,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    controller: _addressController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderSide: BorderSide(width: 5.0)),
                        labelText: 'Address information'),
                  ),
                ],
              ),
            )),
            ElevatedButton(onPressed: _saveForm, child: Text('Save'))
          ],
        ),
      ),
    );
  }
}
