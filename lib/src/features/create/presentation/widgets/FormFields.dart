import 'package:flutter/material.dart';

// Your existing FormLabeledField class
class FormLabeledField extends StatelessWidget {
  final String label;
  final String? hintOrValue;
  final TextEditingController? controller;
  final VoidCallback? onTap;
  final bool readOnly;
  final TextInputType? keyboardType;
  final ValueChanged<String>? onChanged;

  const FormLabeledField({
    super.key,
    required this.label,
    this.hintOrValue,
    this.controller,
    this.onTap,
    this.readOnly = false,
    this.keyboardType,
    required bool isRequired,
    this.onChanged,
  });

  InputDecoration get _decoration => InputDecoration(
    filled: true,
    fillColor: const Color(0xFFF7F7F7),
    hintText: hintOrValue,
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(14),
      borderSide: const BorderSide(color: Color(0xFFE5E5EA)),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(14),
      borderSide: const BorderSide(color: Color(0xFF007AFF)),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w400,
              color: Colors.black87,
            ),
          ),
        ),
        onTap != null
            ? InkWell(
              borderRadius: BorderRadius.circular(14),
              onTap: onTap,
              child: IgnorePointer(
                child: TextFormField(
                  readOnly: true,
                  decoration: _decoration,
                  controller: controller,
                ),
              ),
            )
            : TextFormField(
              controller: controller,
              readOnly: readOnly,
              keyboardType: keyboardType,
              decoration: _decoration,
              onChanged: onChanged,
            ),
      ],
    );
  }
}

// Example screen with dropdown
class DropdownExampleScreen extends StatefulWidget {
  const DropdownExampleScreen({super.key});

  @override
  State<DropdownExampleScreen> createState() => _DropdownExampleScreenState();
}

class _DropdownExampleScreenState extends State<DropdownExampleScreen> {
  String selectedValue = "30 minutes"; // Default value
  final TextEditingController dropdownController = TextEditingController();

  @override
  void initState() {
    super.initState();
    dropdownController.text = selectedValue; // Set initial value
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dropdown Example'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            FormLabeledField(
              label: "Duration",
              controller: dropdownController,
              isRequired: true,
              onTap: () => _showDurationPicker(context),
            ),
            const SizedBox(height: 20),
            // Add more fields as needed
          ],
        ),
      ),
    );
  }

  void _showDurationPicker(BuildContext context) {
    final List<String> durations = [
      "15 minutes",
      "30 minutes",
      "45 minutes",
      "1 hour",
      "1.5 hours",
      "2 hours",
    ];

    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 300,
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Select Duration',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: ListView.builder(
                  itemCount: durations.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(durations[index]),
                      trailing:
                          selectedValue == durations[index]
                              ? const Icon(
                                Icons.check,
                                color: Color(0xFF007AFF),
                              )
                              : null,
                      onTap: () {
                        setState(() {
                          selectedValue = durations[index];
                          dropdownController.text = selectedValue;
                        });
                        Navigator.pop(context);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    dropdownController.dispose();
    super.dispose();
  }
}

//how did we add onChanged?
// first we added final ValueChanged<String>? onChanged; and then added it in constructor this.onchaged then in ui inside textfield

//dropdownfield
//create a string value dropdown and assign 30 minutes string into it .outside build method
// then build a scaffold and give it appbar and leading icon button an context navigator pop
//then create singlechild scroll
