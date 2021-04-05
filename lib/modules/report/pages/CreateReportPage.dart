import 'dart:io';

import 'package:parkowa_nie/modules/core/common/format-date.dart';
import 'package:parkowa_nie/modules/core/common/i18n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:parkowa_nie/modules/core/common/empty-validator.dart';
import 'package:parkowa_nie/modules/core/model/Offence.dart';
import 'package:parkowa_nie/modules/core/model/Report.dart';
import 'package:parkowa_nie/modules/core/services/DatabaseService.dart';
import 'package:parkowa_nie/modules/core/services/LocationService.dart';
import 'package:parkowa_nie/modules/core/widgets/Layout.dart';
import 'package:parkowa_nie/modules/core/widgets/ImageButton.dart';
import 'package:parkowa_nie/modules/report/model/ReportPhoto.dart';
import 'package:parkowa_nie/modules/report/pages/ReportDetailsPage.dart';
import 'package:provider/provider.dart';

class CreateReportPage extends StatefulWidget {
  final Report report;
  final int reportId;
  CreateReportPage({this.report, this.reportId});

  @override
  _CreateReportPageState createState() => _CreateReportPageState();
}

class _CreateReportPageState extends State<CreateReportPage> {
  List<ReportPhoto> _photos = [];

  Map<String, bool> _offences = {for (var offence in OFFENCES) offence: false};
  DateTime _dateTime = DateTime.now();

  bool _automaticLocation = true;
  final _formKey = GlobalKey<FormState>();
  final _cityController = TextEditingController();
  final _streetController = TextEditingController();
  final _licensePlateController = TextEditingController();
  final _dateTimeController =
      TextEditingController(text: formatDate(DateTime.now()));

  @override
  void initState() {
    super.initState();

    if (widget.report != null) {
      _automaticLocation = false;
      _cityController.text = widget.report.city;
      _streetController.text = widget.report.address;
      _licensePlateController.text = widget.report.licensePlate;
      _cityController.text = widget.report.city;
      _dateTimeController.text = formatDate(widget.report.dateTime);

      for (var offence in widget.report.offences) {
        _offences[offence] = true;
      }

      _dateTime = widget.report.dateTime;

      _photos = widget.report.photoUris
          .map((e) => ReportPhoto(source: ImageSource.gallery, file: File(e)))
          .toList();
    }
  }

  Future<void> _addPhotoDialog() async {
    final picker = ImagePicker();
    final result = await showDialog<ReportPhoto>(
        context: context,
        builder: (_) =>
            SimpleDialog(title: Text('Select photo source'.i18n), children: [
              SimpleDialogOption(
                child: Row(
                  children: [
                    Icon(Icons.camera_alt_rounded),
                    SizedBox(
                      width: 10,
                    ),
                    Text('Camera'.i18n)
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
                    Text('Gallery'.i18n)
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
          children: [
            Text('Add a photo'.i18n, textAlign: TextAlign.center),
            Icon(Icons.add)
          ],
        ));
  }

  Widget _imageButton(ReportPhoto photo) {
    return ImageButton(
      photoFile: photo.file,
      onTap: () {
        print('Photo preview');
      },
      onLongPress: () {
        setState(() {
          _photos.remove(photo);
        });
      },
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

  Future<void> _getDateTime() async {
    final dateTime = await showDatePicker(
        context: context,
        initialDate: _dateTime,
        firstDate: DateTime.now().subtract(Duration(days: 365 * 5)),
        lastDate: DateTime.now());
    if (dateTime != null) {
      final time = await showTimePicker(
          context: context, initialTime: TimeOfDay.fromDateTime(_dateTime));
      if (time != null) {
        setState(() {
          _dateTime = DateTime(dateTime.year, dateTime.month, dateTime.day,
              time.hour, time.minute);
          _dateTimeController.text = formatDate(_dateTime);
        });
      }
    }
  }

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
                  decoration: InputDecoration(labelText: 'City'.i18n),
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
                  decoration: InputDecoration(labelText: 'Street name'.i18n),
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
          Row(children: [
            Expanded(
                child: TextFormField(
              validator: emptyValidator,
              controller: _licensePlateController,
              decoration: InputDecoration(labelText: 'License plate'.i18n),
            )),
            SizedBox(
              width: 20,
            ),
            Expanded(
                child: TextFormField(
              readOnly: true,
              validator: emptyValidator,
              controller: _dateTimeController,
              decoration: InputDecoration(labelText: 'Date & time'.i18n),
              onTap: () {
                _getDateTime();
              },
            )),
          ]),
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
                  title: Text(e.i18n),
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
              'Add new report'.i18n,
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
                          .toList(),
                      photoUris: _photos.map((e) => e.file.path).toList());

                  if (widget.report == null) {
                    // We are creating a report
                    final id = await Provider.of<DatabaseService>(context,
                            listen: false)
                        .addReport(report: report);
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (_) => ReportDetails(
                              reportId: id,
                              report: report,
                            )));
                  } else {
                    // We are updating a report
                    await Provider.of<DatabaseService>(context, listen: false)
                        .updateReport(report: report, id: widget.reportId);
                    Navigator.of(context).pop(report);
                  }
                }
              },
              child: Text('Save'.i18n))
        ],
      ),
    );
  }
}
