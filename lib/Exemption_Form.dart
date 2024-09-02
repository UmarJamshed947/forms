import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter/material.dart';

import 'cbcolors.dart';

class ExemptionForm extends StatefulWidget {
  @override
  _ExemptionFormState createState() => _ExemptionFormState();
}

class _ExemptionFormState extends State<ExemptionForm> {
  int _currentStep = 0;

  // Controllers for TextFormFields
  final TextEditingController _applicantNameController =
      TextEditingController();
  final TextEditingController _applicantCnicController =
      TextEditingController();
  final TextEditingController _applicantContactController =
      TextEditingController();
  final TextEditingController _govtServantNameController =
      TextEditingController();
  final TextEditingController _govtServantCNICController =
      TextEditingController();
  final TextEditingController _govtServantContactController =
      TextEditingController();
  final TextEditingController _propertyAddressController =
      TextEditingController();

  // Variables to store form values

  String? _govtServant;
  String? _relationshipWithServant;
  String? _exemptionType;
  String? _govtOrganization;
  String? _colony;
  String? _propertyType;
  String? _ownerShipType;
  String? _occupancyStatus;

  // List of Dropdown items
  final List<String> _servantStatus = ['Serving', 'Retired'];
  final List<String> _relationshipOptions = ['Self', 'Spouse', 'Widow'];
  final List<String> _exemptionTypeOptions = ['100%', '60%'];
  final List<String> _govtOrganizationOptions = [
    'ML&C',
    'Pakistan Army',
    'Pakistan Navy',
    'Pakistan Airforce',
    'Ministry of Defence'
  ];
  final List<String> _colonyOptions = ['a', 'b', 'c', 'd'];
  final List<String> _propertyTypeOptions = ['a', 'b', 'c', 'd'];
  final List<String> _ownershipTypeOptions = [
    'Sole Ownership',
    'Joint Ownership'
  ];
  final List<String> _occupancyStatusOptions = [
    'Demolished',
    'Vacant',
    'Both',
    'Self',
    'Rented'
  ];

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
            'Property Tax Exemption Government Servant',
            style: TextStyle(
              fontFamily: 'SourceSansPro',
              color: CBColors.darkGreen,
              fontWeight: FontWeight.bold,
            ),
          ),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: CBColors.darkGreen,
            ),
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
                title: 'Exemption Details',
              ),
              EasyStep(
                icon: Icon(Icons.child_care),
                title: 'Applicant Details',
              ),
              EasyStep(
                icon: Icon(Icons.family_restroom),
                title: 'Govt Servant Details',
              ),
              EasyStep(
                icon: Icon(Icons.family_restroom),
                title: 'Exemption Details',
              ),
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
        return _buildExemptionDetails();
      case 1:
        return _buildApplicantDetails();
      case 2:
        return _govtServantDetails();
      case 3:
        return _exemptionDetails();

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

  Widget _buildExemptionDetails() {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildDropdown('Govt Servant Status', _govtServant, _servantStatus,
              (value) => setState(() => _govtServant = value)),
          _buildDropdown(
              'Relationship with Govt Servant',
              _relationshipWithServant,
              _relationshipOptions,
              (value) => setState(() => _relationshipWithServant = value)),
          _buildDropdown(
              'Exemption Type',
              _exemptionType,
              _exemptionTypeOptions,
              (value) => setState(() => _exemptionType = value)),
        ],
      ),
    );
  }

  Widget _buildApplicantDetails() {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildTextField(_applicantNameController, 'Applicant Name'),
          _buildTextField(_applicantCnicController, 'Applicant CNIC'),
          _buildTextField(_applicantContactController, 'Applicant Contact'),
        ],
      ),
    );
  }

  Widget _govtServantDetails() {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildTextField(_govtServantNameController, 'Govt Servant Name'),
          _buildTextField(_govtServantCNICController, 'Govt Servant CNIC'),
          _buildTextField(
              _govtServantContactController, 'Govt Servant Contact'),
          _buildDropdown(
              'Government Organization',
              _govtOrganization,
              _govtOrganizationOptions,
              (value) => setState(() => _govtOrganization = value)),
        ],
      ),
    );
  }

  Widget _exemptionDetails() {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildDropdown('Colony', _colony, _colonyOptions,
              (value) => setState(() => _colony = value)),
          _buildDropdown('Property', _propertyType, _propertyTypeOptions,
              (value) => setState(() => _propertyType = value)),
          _buildTextField(_propertyAddressController, 'Property Address'),
          _buildDropdown(
              'Ownership Type',
              _ownerShipType,
              _ownershipTypeOptions,
              (value) => setState(() => _ownerShipType = value)),
          _buildDropdown(
              'Occupancy Status',
              _occupancyStatus,
              _occupancyStatusOptions,
              (value) => setState(() => _occupancyStatus = value)),
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
          labelStyle:
              TextStyle(color: CBColors.darkGreen), // Custom label color
          border: OutlineInputBorder(
            borderSide:
                BorderSide(color: CBColors.darkGreen), // Default border color
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: CBColors.darkGreen, width: 2.0), // Focused border color
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: CBColors.darkGreen, width: 1.5), // Enabled border color
          ),
        ),
      ),
    );
  }

  Widget _buildDropdown(String label, String? selectedValue, List<String> items,
      ValueChanged<String?> onChanged) {
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
          labelStyle:
              TextStyle(color: CBColors.darkGreen), // Custom label color
          border: OutlineInputBorder(
            borderSide:
                BorderSide(color: CBColors.darkGreen), // Default border color
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: CBColors.darkGreen, width: 2.0), // Focused border color
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: CBColors.darkGreen, width: 1.5), // Enabled border color
          ),
        ),
      ),
    );
  }

  Widget _buildDatePicker(BuildContext context, String label,
      DateTime? selectedDate, ValueChanged<DateTime> onDateSelected) {
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
            labelStyle:
                TextStyle(color: CBColors.darkGreen), // Custom label color
            border: OutlineInputBorder(
              borderSide:
                  BorderSide(color: CBColors.darkGreen), // Default border color
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: CBColors.darkGreen,
                  width: 2.0), // Focused border color
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: CBColors.darkGreen,
                  width: 1.5), // Enabled border color
            ),
          ),
          child: Text(
            selectedDate != null
                ? selectedDate.toLocal().toString().split(' ')[0]
                : 'Select Date',
            style: TextStyle(
                color: Colors.black), // You can customize this color as needed
          ),
        ),
      ),
    );
  }

  void _submitForm() {
    // Add form submission logic here
  }
}
