import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const StudentInfoApp());
}

class StudentInfoApp extends StatelessWidget {
  const StudentInfoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CSS3344 Lab 02',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.indigo,
      ),
      home: const StudentProfileScreen(),
    );
  }
}

class StudentProfileScreen extends StatelessWidget {
  const StudentProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CSS3344 Mobile App Dev - Lab 02'),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      body: OrientationBuilder(
        builder: (context, orientation) {
          if (orientation == Orientation.landscape) {
            return _buildLandscapeLayout(context);
          } else {
            return _buildPortraitLayout(context);
          }
        },
      ),
    );
  }

  Widget _buildProfileCard(BuildContext context) {
    final primaryColor = Theme.of(context).colorScheme.primary;

    return Card(
      elevation: 4,
      color: primaryColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/profile.jpeg'),
            ),
            const SizedBox(height: 20),
            // TODO: Replace with your Full Name
            const Text(
              'YOW KAI SHENG',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            // TODO: Replace with your Student ID
            const Text(
              'Student ID: BCS24020022',
              style: TextStyle(
                fontSize: 16,
                color: Colors.white70,
              ),
            ),
            const Divider(
              height: 32,
              thickness: 1,
              color: Colors.white30,
            ),
            const Text(
              'Personal Life Goal / Quote:',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            // TODO: Replace with your goal/quote
            const Text(
              '"Better Than Yesterday"',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
                fontStyle: FontStyle.italic,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLocationSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        const TitleSection(
          name: 'University of Technology Sarawak',
          location: 'Sibu, Sarawak',
          starCount: 30,
        ),
        const SizedBox(height: 16),
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.asset(
            'assets/loc.jpeg',
            width: double.infinity,
            height: 200,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                height: 200,
                color: Colors.indigo[50],
                child: const Icon(
                  Icons.image,
                  size: 50,
                  color: Colors.indigo,
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 24),
        const SelectionPickersSection(),
      ],
    );
  }

  Widget _buildPortraitLayout(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildProfileCard(context),
          const SizedBox(height: 24),
          _buildLocationSection(),
        ],
      ),
    );
  }

  Widget _buildLandscapeLayout(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: _buildProfileCard(context),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: _buildLocationSection(),
          ),
        ],
      ),
    );
  }
}

class TitleSection extends StatelessWidget {
  final String name;
  final String location;
  final int starCount;

  const TitleSection({
    super.key,
    required this.name,
    required this.location,
    required this.starCount,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                location,
                style: TextStyle(
                  color: Colors.indigo[400],
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
        Icon(
          Icons.star,
          color: Colors.indigo[300],
        ),
        const SizedBox(width: 4),
        Text('$starCount'),
      ],
    );
  }
}

class SelectionPickersSection extends StatefulWidget {
  const SelectionPickersSection({super.key});

  @override
  State<SelectionPickersSection> createState() =>
      _SelectionPickersSectionState();
}

class _SelectionPickersSectionState extends State<SelectionPickersSection> {
  DateTime _selectedDate = DateTime(2026, 10, 28);
  String _selectedHouse = 'Slytherin';

  final List<String> _houses = [
    'Gryffindor',
    'Slytherin',
    'Ravenclaw',
    'Hufflepuff',
  ];

  // 1. Material Date Picker
  Future<void> _selectMaterialDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(1950),
      lastDate: DateTime(2030),
    );

    if (picked != null && mounted) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  // 2. Cupertino Date Picker
  void _showCupertinoDatePicker(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      builder: (_) => Container(
        height: 240,
        color: CupertinoColors.systemBackground.resolveFrom(context),
        child: SafeArea(
          top: false,
          child: CupertinoDatePicker(
            mode: CupertinoDatePickerMode.date,
            initialDateTime: _selectedDate,
            minimumDate: DateTime(1950),
            maximumDate: DateTime(2030),
            onDateTimeChanged: (DateTime newDate) {
              setState(() {
                _selectedDate = newDate;
              });
            },
          ),
        ),
      ),
    );
  }

  // 3. Cupertino House Picker (Wheel)
  void _showCupertinoHousePicker(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      builder: (_) => Container(
        height: 200,
        color: CupertinoColors.systemBackground.resolveFrom(context),
        child: SafeArea(
          top: false,
          child: CupertinoPicker(
            itemExtent: 32,
            scrollController: FixedExtentScrollController(
              initialItem: _houses.indexOf(_selectedHouse),
            ),
            onSelectedItemChanged: (int index) {
              setState(() {
                _selectedHouse = _houses[index];
              });
            },
            children: _houses.map((house) {
              return Center(
                child: Text(house),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final String formattedDate =
        '${_selectedDate.year}-${_selectedDate.month.toString().padLeft(2, '0')}-${_selectedDate.day.toString().padLeft(2, '0')}';

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Interactive Pickers (Lab 2.2)',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Divider(height: 20),
            const SizedBox(height: 4),

            // Selected Date
            RichText(
              text: TextSpan(
                style: const TextStyle(color: Colors.black87, fontSize: 14),
                children: [
                  const TextSpan(
                    text: 'Selected Date: ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text: formattedDate,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 4),

            // Selected House
            RichText(
              text: TextSpan(
                style: TextStyle(
                  color: Colors.indigo[600],
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
                children: [
                  const TextSpan(text: 'Selected House: '),
                  TextSpan(text: _selectedHouse),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // 1. Material Date Picker Button
            OutlinedButton.icon(
              onPressed: () => _selectMaterialDate(context),
              icon: const Icon(Icons.calendar_today, size: 18),
              label: const Text('Material Date Picker'),
              style: OutlinedButton.styleFrom(
                shape: const StadiumBorder(),
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
              ),
            ),
            const SizedBox(height: 12),

            // 2. Cupertino Date Picker Button
            OutlinedButton.icon(
              onPressed: () => _showCupertinoDatePicker(context),
              icon: const Icon(Icons.calendar_month, size: 18),
              label: const Text('Cupertino Date Picker (Modal Sheet)'),
              style: OutlinedButton.styleFrom(
                shape: const StadiumBorder(),
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
              ),
            ),
            const SizedBox(height: 16),

            // 3. Material Dropdown Row
            Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                const Text(
                  'Material Dropdown: ',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Colors.black87,
                  ),
                ),
                DropdownButton<String>(
                  value: _selectedHouse,
                  underline: const SizedBox(),
                  items: _houses.map((String house) {
                    return DropdownMenuItem<String>(
                      value: house,
                      child: Text(
                        house,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      setState(() {
                        _selectedHouse = newValue;
                      });
                    }
                  },
                ),
              ],
            ),
            const SizedBox(height: 8),

            // 4. Cupertino House Wheel Picker Button
            OutlinedButton.icon(
              onPressed: () => _showCupertinoHousePicker(context),
              icon: const Icon(Icons.tune, size: 18),
              label: const Text('Cupertino House Wheel Picker'),
              style: OutlinedButton.styleFrom(
                shape: const StadiumBorder(),
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
