import 'package:flutter/material.dart';

class MushroomAttributesPage extends StatefulWidget {
  @override
  _MushroomAttributesPageState createState() => _MushroomAttributesPageState();
}

class _MushroomAttributesPageState extends State<MushroomAttributesPage> {
  String? selectedMushroomCap;
  String? selectedMushroomSurface;
  String? selectedMushroomGill;
  String? selectedMushroomStalk;
  String? selectedMushroomRing;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('กรุณากรอกคุณลักษณะเห็ดเพิ่มเติม'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildSectionTitle('หมวกเห็ด'),
            _buildRadioButton('กลม', selectedMushroomCap, 'cap'),
            _buildRadioButton('หมวกแบน', selectedMushroomCap, 'cap'),
            _buildRadioButton('หมวกคว่ำ', selectedMushroomCap, 'cap'),
            _buildRadioButton('หมวกพัด', selectedMushroomCap, 'cap'),
            _buildRadioButton('หมวกกรวย', selectedMushroomCap, 'cap'),
            _buildRadioButton('รูปอานม้า', selectedMushroomCap, 'cap'),
             _buildRadioButton('ครึ่งวงกลม', selectedMushroomCap, 'cap'),
              _buildRadioButton('ปากแตร', selectedMushroomCap, 'cap'),

            SizedBox(height: 16),

            _buildSectionTitle('ผิวของหมวกเห็ด'),
            _buildRadioButton('เรียบ', selectedMushroomSurface, 'surface'),
            _buildRadioButton('ขรุขระ', selectedMushroomSurface, 'surface'),
            _buildRadioButton('มีเกล็ด', selectedMushroomSurface, 'surface'),
            _buildRadioButton('ร่อง', selectedMushroomSurface, 'surface'),
            _buildRadioButton('เส้นใย', selectedMushroomSurface, 'surface'),
            _buildRadioButton('ลอน', selectedMushroomSurface, 'surface'),

            SizedBox(height: 16),

            _buildSectionTitle('ครีบเห็ด'),
            _buildRadioButton('ไม่มี', selectedMushroomGill, 'gill'),
            _buildRadioButton('สีขาว', selectedMushroomGill, 'gill'),
            _buildRadioButton('สีน้ำตาล', selectedMushroomGill, 'gill'),
            _buildRadioButton('สีดำ', selectedMushroomGill, 'gill'),
            _buildRadioButton('สีเทา', selectedMushroomGill, 'gill'),
            _buildRadioButton('สีเหลือง', selectedMushroomGill, 'gill'),
            _buildRadioButton('สีม่วง', selectedMushroomGill, 'gill'),

            SizedBox(height: 16),

            _buildSectionTitle('ก้านเห็ด'),
            _buildRadioButton('ทรงกระบอก', selectedMushroomStalk, 'stalk'),
            _buildRadioButton('ป้อม', selectedMushroomStalk, 'stalk'),

            SizedBox(height: 16),

            _buildSectionTitle('วงแหวน'),
            _buildRadioButton('มี', selectedMushroomRing, 'ring'),
            _buildRadioButton('ไม่มี', selectedMushroomRing, 'ring'),

            SizedBox(height: 30),

            ElevatedButton(
              onPressed: () {
                List<String?> features = [
                  selectedMushroomCap,
                  selectedMushroomSurface,
                  selectedMushroomGill,
                  selectedMushroomStalk,
                  selectedMushroomRing
                ];

                if (features.contains(null)) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('กรุณากรอกข้อมูลให้ครบถ้วน')),
                  );
                  return;
                }

                // Your logic after collecting the data goes here
              },
              child: const Text(
                'ค้นหา',
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  color: Colors.blue
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 8),
      child: Text(
        title,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
    );
  }

  Widget _buildRadioButton(String title, String? groupValue, String group) {
    return RadioListTile<String>(
      title: Text(title),
      value: title,
      groupValue: groupValue,
      onChanged: (value) {
        setState(() {
          switch (group) {
            case 'cap':
              selectedMushroomCap = value;
              break;
            case 'surface':
              selectedMushroomSurface = value;
              break;
            case 'gill':
              selectedMushroomGill = value;
              break;
            case 'stalk':
              selectedMushroomStalk = value;
              break;
            case 'ring':
              selectedMushroomRing = value;
              break;
          }
        });
      },
    );
  }
}
