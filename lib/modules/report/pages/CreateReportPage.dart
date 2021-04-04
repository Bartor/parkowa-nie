import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:parkowa_nie/modules/core/common/empty-validator.dart';
import 'package:parkowa_nie/modules/core/model/Offence.dart';
import 'package:parkowa_nie/modules/core/model/Report.dart';
import 'package:parkowa_nie/modules/core/services/DatabaseService.dart';
import 'package:parkowa_nie/modules/core/services/LocationService.dart';
import 'package:parkowa_nie/modules/core/widgets/Layout.dart';
import 'package:parkowa_nie/modules/report/model/ReportPhoto.dart';
import 'package:parkowa_nie/modules/report/pages/ReportDetailsPage.dart';
import 'package:provider/provider.dart';

class CreateReportPage extends StatefulWidget {
  @override
  _CreateReportPageState createState() => _CreateReportPageState();
}

class _CreateReportPageState extends State<CreateReportPage> {
  List<ReportPhoto> _photos = [];

  Map<String, bool> _offences = {for (var offence in OFFENCES) offence: false};

  bool _automaticLocation = true;
  final _formKey = GlobalKey<FormState>();
  final _cityController = TextEditingController();
  final _streetController = TextEditingController();
  final _licensePlateController = TextEditingController();

  Future<void> _addPhotoDialog() async {
    final picker = ImagePicker();
    final result = await showDialog<ReportPhoto>(
        context: context,
        builder: (_) =>
            SimpleDialog(title: Text('Select photo source'), children: [
              SimpleDialogOption(
                child: Row(
                  children: [
                    Icon(Icons.camera_alt_rounded),
                    SizedBox(
                      width: 10,
                    ),
                    Text('Camera')
                  ],
                ),
                onPressed: () async {
                  final image =
                      await picker.getImage(source: ImageSource.camera);
                  if (image == null) {
                    Navigator.of(context).pop(null);
                  } else {
                    Navigator.of(context).pop(ReportPhoto(
                        file: File(image.path), source: ImageSource.camera));
                  }
                },
              ),
              SimpleDialogOption(
                child: Row(
                  children: [
                    Icon(Icons.photo_size_select_actual_rounded),
                    SizedBox(
                      width: 10,
                    ),
                    Text('Gallery')
                  ],
                ),
                onPressed: () async {
                  final image =
                      await picker.getImage(source: ImageSource.gallery);
                  if (image == null) {
                    Navigator.of(context).pop(null);
                  } else {
                    Navigator.of(context).pop(ReportPhoto(
                        file: File(image.path), source: ImageSource.gallery));
                  }
                },
              )
            ]));

    if (result != null) {
      setState(() {
        _photos.add(result);
      });
    }
  }

  Widget _addNewPhotoButton() {
    return ElevatedButton(
        onPressed: _addPhotoDialog,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Text('Add a photo'), Icon(Icons.add)],
        ));
  }

  Widget _imageButton(ReportPhoto photo) {
    return Material(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      clipBehavior: Clip.hardEdge,
      color: Colors.transparent,
      child: Ink.image(
        image: FileImage(
          photo.file,
        ),
        fit: BoxFit.cover,
        child: InkWell(
          splashColor: Colors.white60,
          onTap: () {
            print('Photo preview');
          },
          onLongPress: () {
            setState(() {
              _photos.remove(photo);
            });
          },
        ),
      ),
    );
  }

  Widget _buildImages() => GridView.count(
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        physics: BouncingScrollPhysics(),
        shrinkWrap: true,
        crossAxisCount: 3,
        children: [
          ..._photos.map((photo) => _imageButton(photo)),
          _addNewPhotoButton()
        ],
      );

  Widget _buildForm() => Form(
      key: _formKey,
      child: Column(
        children: [
          Consumer<LocationService>(builder: (context, location, widget) {
            if (_automaticLocation &&
                location != null &&
                location.fullLocation != null) {
              _cityController.text =
                  location.fullLocation.placemarks.first.locality;
              _streetController.text =
                  location.fullLocation.placemarks.first.street;
            }
            return Row(
              children: [
                Expanded(
                    child: TextFormField(
                  validator: emptyValidator,
                  onTap: () {
                    setState(() {
                      _automaticLocation = false;
                    });
                  },
                  controller: _cityController,
                  decoration: InputDecoration(labelText: 'City'),
                )),
                SizedBox(
                  width: 20,
                ),
                Expanded(
                    child: TextFormField(
                  validator: emptyValidator,
                  onTap: () {
                    setState(() {
                      _automaticLocation = false;
                    });
                  },
                  controller: _streetController,
                  decoration: InputDecoration(labelText: 'Street name'),
                )),
                SizedBox(
                  width: 10,
                ),
                IconButton(
                    onPressed: () {
                      FocusScope.of(context).requestFocus(new FocusNode());
                      setState(() {
                        _automaticLocation = true;
                      });
                    },
                    iconSize: 24,
                    color: Colors.indigo.shade200,
                    icon: Icon(
                      _automaticLocation
                          ? Icons.location_on_rounded
                          : Icons.location_off_rounded,
                    ))
              ],
            );
          }),
          SizedBox(
            height: 20,
          ),
          TextFormField(
            validator: emptyValidator,
            controller: _licensePlateController,
            decoration: InputDecoration(labelText: 'License plate'),
          ),
        ],
      ));

  Widget _buildOffenceList() => ListView(
        physics: BouncingScrollPhysics(),
        children: OFFENCES
            .map((e) => CheckboxListTile(
                  activeColor: Colors.indigo.shade200,
                  value: _offences[e],
                  onChanged: (value) {
                    setState(() {
                      _offences[e] = value;
                    });
                  },
                  title: Text(e),
                ))
            .toList(),
      );

  @override
  Widget build(BuildContext context) {
    return Layout(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Hero(
            child: Text(
              'Add new report',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline6,
            ),
            tag: 'text/addNewReport',
          ),
          SizedBox(
            height: 20,
          ),
          _buildImages(),
          SizedBox(
            height: 20,
          ),
          _buildForm(),
          SizedBox(
            height: 20,
          ),
          Expanded(child: _buildOffenceList()),
          ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState.validate()) {
                  final report = Report(
                      licensePlate: _licensePlateController.text.trim(),
                      address: _streetController.text.trim(),
                      city: _cityController.text.trim(),
                      dateTime: DateTime.now(),
                      offences: _offences.entries
                          .where((element) => element.value)
                          .map((e) => e.key)
                          .toList());
                  final id =
                      await Provider.of<DatabaseService>(context, listen: false)
                          .addReport(report: report);
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (_) => ReportDetails(
                            reportId: id,
                            report: report,
                          )));
                }
              },
              child: Text('Save'))
        ],
      ),
    );
  }
}
