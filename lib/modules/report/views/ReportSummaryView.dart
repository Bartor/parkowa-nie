import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:parkowa_nie/modules/core/services/LocationService.dart';
import 'package:provider/provider.dart';

class ReportSummaryView extends StatefulWidget {
  @override
  _ReportSummaryViewState createState() => _ReportSummaryViewState();
}

class _ReportSummaryViewState extends State<ReportSummaryView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Consumer<LocationService>(builder: (context, service, widget) {
            if (service == null || service.fullLocation == null) {
              return Text('Loading...');
            } else {
              final placemark = service.fullLocation.placemarks.first;
              if (placemark == null) {
                return Text('Could not fetch correct location');
              } else {
                return Text(
                  "${placemark.street},\n${placemark.locality}",
                  style: Theme.of(context).textTheme.headline6,
                  textAlign: TextAlign.center,
                );
              }
            }
          }),
          ElevatedButton(
              onPressed: () {
                final picker = ImagePicker();
                picker.getImage(source: ImageSource.camera);
              },
              child: Text('Take a new photo')),
          ElevatedButton(
              onPressed: () {
                final picker = ImagePicker();
                picker.getImage(source: ImageSource.gallery);
              },
              child: Text('Use an existing photo'))
        ],
      ),
    );
  }
}
