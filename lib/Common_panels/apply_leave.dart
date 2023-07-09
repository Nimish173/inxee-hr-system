// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class ApplyLeave extends StatefulWidget {
  const ApplyLeave({Key? key}) : super(key: key);

  @override
  State<ApplyLeave> createState() => _ApplyLeaveState();
}

class _ApplyLeaveState extends State<ApplyLeave> {
  final TextEditingController _applicationController = TextEditingController();

  String _selectedDate = '';
  String _range = '';
  String _rangeCount = '';
  String _application = '';
  String _selectedDateInput = '';
  String _rangeInput = '';
  String _rangeCountInput = '';

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    setState(() {
      if (args.value is PickerDateRange) {
        final range = args.value as PickerDateRange;
        final selectedDates = getSelectedDates(range);

        if (selectedDates.isNotEmpty) {
          final firstSelectedDate = selectedDates.first;
          final lastSelectedDate = selectedDates.last;

          final formattedStartDate = formatDateTime(firstSelectedDate);
          final formattedEndDate = formatDateTime(lastSelectedDate);

          _range = '$formattedStartDate - $formattedEndDate';

          final formattedSelectedDates =
              selectedDates.map((date) => formatDateTime(date)).toList();
          _selectedDate = formattedSelectedDates.join(', ');

          _rangeCount = selectedDates.length.toString();
        } else {
          _selectedDate = '';
          _range = '';
          _rangeCount = '';
        }
      }
    });
  }

  List<DateTime> getSelectedDates(PickerDateRange range) {
    final DateTime? startDate = range.startDate;
    final DateTime? endDate = range.endDate ?? range.startDate;

    final selectedDates = <DateTime>[];
    DateTime? currentDate = startDate;

    while (currentDate!.isBefore(endDate!) ||
        currentDate!.isAtSameMomentAs(endDate)) {
      if (currentDate.weekday != DateTime.sunday) {
        selectedDates.add(currentDate);
      }
      currentDate = currentDate.add(const Duration(days: 1));
    }

    return selectedDates;
  }

  String formatDateTime(DateTime dateTime) {
    return DateFormat('dd/MM/yyyy').format(dateTime);
  }

// Store the initial range for resetting the calendar
  PickerDateRange _initialSelectedRange = PickerDateRange(
    DateTime.now(),
    DateTime.now(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: <Widget>[
              SizedBox(height: 15),
              Container(
                height: 400,
                child: SfDateRangePicker(
                  onSelectionChanged: _onSelectionChanged,
                  selectionMode: DateRangePickerSelectionMode.range,
                  initialSelectedRange: _initialSelectedRange,
                  startRangeSelectionColor: Colors.greenAccent[400],
                  endRangeSelectionColor: Colors.red,
                  rangeSelectionColor: Colors.blue.shade200,
                  selectionShape: DateRangePickerSelectionShape.rectangle,
                  selectionTextStyle: const TextStyle(fontSize: 18),
                  rangeTextStyle: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 17,
                  ),
                  monthCellStyle: DateRangePickerMonthCellStyle(
                    todayCellDecoration: BoxDecoration(
                      color: Colors.blue.shade400,
                      border: Border.all(color: Colors.black, width: 2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    todayTextStyle: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                    textStyle: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
                    cellDecoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.black26),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    weekendTextStyle: TextStyle(
                      color: Colors.redAccent.shade700,
                    ),
                    weekendDatesDecoration: BoxDecoration(
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  headerStyle: DateRangePickerHeaderStyle(
                    backgroundColor: Colors.black,
                    textStyle: GoogleFonts.actor(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 25),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    buildSelectedInfoContainer(
                      'Selected date: ',
                      _selectedDate,
                    ),
                    const SizedBox(height: 10),
                    buildSelectedInfoContainer(
                      'Selected range: ',
                      _range,
                    ),
                    const SizedBox(height: 10),
                    buildSelectedInfoContainer(
                      'No. of days: ',
                      _rangeCount,
                    ),
                    const SizedBox(height: 10),
                    buildLeaveApplicationForm(),
                    const SizedBox(height: 10),
                    submitandcancelButton(),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildSelectedInfoContainer(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(5),
          color: Colors.white,
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              child: Text(
                label,
                style: GoogleFonts.roboto(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                alignment: Alignment.centerLeft,
                child: Text(
                  value,
                  style: GoogleFonts.actor(
                    fontSize: 18,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildLeaveApplicationForm() {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Leave Application:',
              style: GoogleFonts.roboto(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: TextFormField(
                controller: _applicationController,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Application',
                    hintStyle: TextStyle(fontSize: 17)),
                maxLines: null,
              ),
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  Widget submitandcancelButton() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 25),
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.red.shade100,
                border: Border.all(color: Colors.red, width: 2),
                borderRadius: BorderRadius.circular(30),
              ),
              child: IconButton(
                iconSize: 35,
                onPressed: () {
                  setState(() {
                    _selectedDate = ''; // Reset selected date value
                    _range = ''; // Reset selected range value
                    _rangeCount = ''; // Reset range count value
                    _application = ''; // Reset application value
                    _selectedDateInput = ''; // Reset selected date input value
                    _rangeInput = ''; // Reset range input value
                    _rangeCountInput = ''; // Reset range count input value
                    _applicationController
                        .clear(); // Clear the application text field
                    _initialSelectedRange = PickerDateRange(
                      DateTime.now(),
                      DateTime.now(),
                    ); // Reset the initial range of the calendar.
                  });
                },
                icon: Icon(
                  Icons.close_sharp,
                  color: Colors.red,
                ),
              ),
            ),
            SizedBox(width: 10),
            Container(
              decoration: BoxDecoration(
                color: Colors.green.shade100,
                border: Border.all(color: Colors.green, width: 2),
                borderRadius: BorderRadius.circular(30),
              ),
              child: IconButton(
                iconSize: 35,
                onPressed: () {
                  setState(() {
                    _selectedDateInput =
                        _selectedDate; // Store the selected date value
                    _rangeInput = _range; // Store the selected range value
                    _rangeCountInput =
                        _rangeCount; // Store the range count value
                  });

                  // TODO: Implement leave application submission logic with the form inputs

                  // Reset the form inputs
                  _selectedDate = '';
                  _range = '';
                  _rangeCount = '';
                  _selectedDateInput = '';
                  _rangeInput = '';
                  _rangeCountInput = '';
                  _applicationController.clear();
                },
                icon: Icon(
                  Icons.check,
                  color: Colors.green,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
