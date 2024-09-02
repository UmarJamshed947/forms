
import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter/material.dart';

import 'cbcolors.dart';


class DeathForm extends StatefulWidget {
  @override
  _DeathFormState createState() => _DeathFormState();
}

class _DeathFormState extends State<DeathForm> {

  int _currentStep = 0;

  // Controllers for TextFormFields
  final TextEditingController _deceasedNameController = TextEditingController();
  final TextEditingController _cnicController = TextEditingController();
  final TextEditingController _burialContactController = TextEditingController();
  final TextEditingController _burialController = TextEditingController();
  final TextEditingController _burialCnicController = TextEditingController();
  final TextEditingController _fatherNameOfDeceasedController = TextEditingController();
  final TextEditingController _motherNameOfDeceasedController = TextEditingController();


  // Variables to store form values

  String? _relationWithDeased;
  DateTime? _dateOfBirth;
  String? _gender;
  String? _dualNationality;
  String? _natureOfDeath;
  String? _placeOfBirth;
  String? _maritalStatus;
  String? _religion;


  // List of Dropdown items
  final List<String> _yesNoOptions = ['Yes', 'No'];
  final List<String> _genderOptions = ['Male', 'Female', 'Other'];
  final List<String> _maritalStatusOptions = ['Single', 'Married', 'Widow','Divorced','Widower'];
  final List<String> _natureOfDeathTypes = ['Natural Cause','Accident','Sucide','Murder/Homicide','Other'];
   final List<String> _places = ['Place A', 'Place B', 'Place C']; // Example values
  final List<String> _religions = ['Religion A', 'Religion B', 'Religion C']; // Example values


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CBColors.lightblue,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: AppBar(
          elevation: 0,
          backgroundColor: CBColors.lightGreenBackground,
          title: Text(
            'Birth Certificate',
            style: TextStyle(
              fontFamily: 'SourceSansPro',
              color: CBColors.darkGreen,
              fontWeight: FontWeight.bold,
            ),
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: CBColors.darkGreen,),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
      ),
      body: Column(
        children: [
          EasyStepper(
            activeStep: _currentStep,
            lineLength: 90,
            direction: Axis.horizontal,
            padding: 20,
            stepRadius: 28,
           // lineType: LineType.normal,
            finishedStepBorderColor: CBColors.darkGreen,
            finishedStepTextColor: CBColors.darkGreen,
            finishedStepBackgroundColor: CBColors.darkGreen,
            activeStepTextColor: CBColors.darkGreen,
            activeStepBorderColor: CBColors.darkGreen,
            activeStepBackgroundColor: Colors.white,

            //showLoadingAnimation: false,
            onStepReached: (index) => setState(() => _currentStep = index),
            steps: [
              EasyStep(
                icon: Icon(Icons.person),
                title: 'Applicant Details',
              ),
              EasyStep(
                icon: Icon(Icons.child_care),
                title: 'Deceased Details',
              ),
              // EasyStep(
              //   icon: Icon(Icons.family_restroom),
              //   title: 'Family Details',
              // ),
            ],
          ),
          Expanded(
            child: _getStepContent(_currentStep),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomNavigation(),
    );
  }

  Widget _getStepContent(int step) {
    switch (step) {
      case 0:
        return _buildApplicantDetails();
      case 1:
        return _buildDeceasedDetails();

      default:
        return Container();
    }
  }

  Widget _buildBottomNavigation() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (_currentStep > 0)
            MaterialButton(
              onPressed: () {
                setState(() {
                  _currentStep -= 1;
                });
              },
              color: CBColors.Buttoncolor, // Set the button color to green
              textColor: Colors.white, // Set the text color to white
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0), // Rounded corners
              ),
              child: Text('Back'),
            ),

          MaterialButton(
            onPressed: _currentStep < 2
                ? () {
              setState(() {
                _currentStep += 1;
              });
            }
                : _submitForm,
            color: CBColors.Buttoncolor, // Set the button color to green
            textColor: Colors.white, // Set the text color to white
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0), // Rounded corners
            ),
            child: Text(_currentStep < 2 ? 'Next' : 'Submit'),
          ),

        ],
      ),
    );
  }

  Widget _buildApplicantDetails() {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildDropdown(
              'Relation with Deceased',
              _relationWithDeased,
              ['Mother', 'Father', 'Spouse', 'Grandfather', 'Grandmother'],
                  (value) => setState(() => _relationWithDeased = value)),
        ],
      ),
    );
  }

  Widget _buildDeceasedDetails() {
    return SingleChildScrollView(
      child: Column(
        children: [

          _buildTextField(_deceasedNameController, 'Deceased Name'),
          _buildTextField(_cnicController, 'Deceased CNIC'),
          _buildDatePicker(context, 'Date of Birth', _dateOfBirth,
                  (date) => setState(() => _dateOfBirth = date)),
          _buildDropdown('Gender', _gender, _genderOptions,
                  (value) => setState(() => _gender = value)),
          _buildDropdown('Religion', _religion, _religions,
                  (value) => setState(() => _religion = value)),
          _buildDatePicker(context, 'Date of Death', _dateOfBirth,
                  (date) => setState(() => _dateOfBirth = date)),
          _buildDropdown('Marital Status', _maritalStatus, _maritalStatusOptions,
                  (value) => setState(() => _maritalStatus = value)),
          _buildDropdown('Deceased Dual Nationality', _dualNationality, _yesNoOptions,
                  (value) => setState(() => _dualNationality = value)),
          _buildDropdown('Place of Birth', _placeOfBirth, _places,
                  (value) => setState(() => _placeOfBirth = value)),
          _buildDropdown('Nature Of Death', _natureOfDeath, _natureOfDeathTypes,
                  (value) => setState(() => _natureOfDeath = value)),
          _buildTextField(_burialController, 'Burial/Last Ritely Name'),
          _buildTextField(_burialCnicController, 'Burial/Last Ritely CNIC'),
          _buildTextField(_burialContactController, 'Burial/Last Ritely Contact No'),
          _buildTextField(_fatherNameOfDeceasedController, 'Father Name of Deceased'),
          _buildTextField(_motherNameOfDeceasedController, 'Mother Name of Deceased'),





        ],
      ),
    );
  }



  // Add the existing text field, dropdown, and date picker widgets here
  Widget _buildTextField(TextEditingController controller, String labelText) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: TextStyle(color: CBColors.darkGreen), // Custom label color
          border: OutlineInputBorder(
            borderSide: BorderSide(color:CBColors.darkGreen), // Default border color
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: CBColors.darkGreen, width: 2.0), // Focused border color
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: CBColors.darkGreen, width: 1.5), // Enabled border color
          ),
        ),
      ),
    );
  }


  Widget _buildDropdown(
      String label,
      String? selectedValue,
      List<String> items,
      ValueChanged<String?> onChanged
      ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: DropdownButtonFormField<String>(
        value: selectedValue,
        items: items.map((item) {
          return DropdownMenuItem<String>(
            value: item,
            child: Text(item),
          );
        }).toList(),
        onChanged: onChanged,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: CBColors.darkGreen), // Custom label color
          border: OutlineInputBorder(
            borderSide: BorderSide(color: CBColors.darkGreen), // Default border color
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: CBColors.darkGreen, width: 2.0), // Focused border color
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: CBColors.darkGreen, width: 1.5), // Enabled border color
          ),
        ),
      ),
    );
  }


  Widget _buildDatePicker(
      BuildContext context,
      String label,
      DateTime? selectedDate,
      ValueChanged<DateTime> onDateSelected
      ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: GestureDetector(
        onTap: () async {
          DateTime? pickedDate = await showDatePicker(
            context: context,
            initialDate: selectedDate ?? DateTime.now(),
            firstDate: DateTime(1900),
            lastDate: DateTime(2100),
          );
          if (pickedDate != null) {
            onDateSelected(pickedDate);
          }
        },
        child: InputDecorator(
          decoration: InputDecoration(
            labelText: label,
            labelStyle: TextStyle(color: CBColors.darkGreen), // Custom label color
            border: OutlineInputBorder(
              borderSide: BorderSide(color: CBColors.darkGreen), // Default border color
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: CBColors.darkGreen, width: 2.0), // Focused border color
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: CBColors.darkGreen, width: 1.5), // Enabled border color
            ),
          ),
          child: Text(
            selectedDate != null
                ? selectedDate.toLocal().toString().split(' ')[0]
                : 'Select Date',
            style: TextStyle(color: Colors.black), // You can customize this color as needed
          ),
        ),
      ),
    );
  }


  void _submitForm() {
    // Add form submission logic here
  }
}