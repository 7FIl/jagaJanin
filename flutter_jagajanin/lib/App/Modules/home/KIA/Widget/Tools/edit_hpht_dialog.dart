import 'package:flutter/material.dart';

class EditHPHTDialog {
  static void show(
    BuildContext context,
    dynamic data, {
    required Function(String hpht) onSave,
  }) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Ubah Hari Pertama Haid Terakhir',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF2D3142),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Icon(
                          Icons.close,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12),

                  // Custom Date Picker
                  _CustomDatePicker(
                    onDateSelected: (selectedDate) {
                      final formattedDate = _formatDate(selectedDate);
                      Navigator.pop(context);
                      onSave(formattedDate);
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  static String _formatDate(DateTime date) {
    final months = [
      '',
      'Januari',
      'Februari',
      'Maret',
      'April',
      'Mei',
      'Juni',
      'Juli',
      'Agustus',
      'September',
      'Oktober',
      'November',
      'Desember',
    ];
    return '${date.day} ${months[date.month]} ${date.year}';
  }
}

class _CustomDatePicker extends StatefulWidget {
  final Function(DateTime) onDateSelected;

  const _CustomDatePicker({required this.onDateSelected});

  @override
  State<_CustomDatePicker> createState() => _CustomDatePickerState();
}

class _CustomDatePickerState extends State<_CustomDatePicker> {
  late DateTime currentDate;

  @override
  void initState() {
    super.initState();
    currentDate = DateTime.now();
  }

  void _previousMonth() {
    setState(() {
      currentDate = DateTime(currentDate.year, currentDate.month - 1);
    });
  }

  void _nextMonth() {
    setState(() {
      currentDate = DateTime(currentDate.year, currentDate.month + 1);
    });
  }

  List<String> _getDaysOfMonth(DateTime date) {
    final firstDay = DateTime(date.year, date.month, 1);
    final lastDay = DateTime(date.year, date.month + 1, 0);
    final daysInMonth = lastDay.day;
    final weekday = firstDay.weekday;

    List<String> days = [];

    // Tambahkan hari dari bulan sebelumnya
    final previousMonthLastDay = DateTime(date.year, date.month, 0);
    for (int i = weekday - 1; i > 0; i--) {
      days.add((previousMonthLastDay.day - i + 1).toString());
    }

    // Tambahkan hari bulan ini
    for (int i = 1; i <= daysInMonth; i++) {
      days.add(i.toString());
    }

    // Tambahkan hari dari bulan berikutnya
    final remainingDays = 42 - days.length;
    for (int i = 1; i <= remainingDays; i++) {
      days.add(i.toString());
    }

    return days;
  }

  @override
  Widget build(BuildContext context) {
    final days = _getDaysOfMonth(currentDate);
    final daysInCurrentMonth = DateTime(currentDate.year, currentDate.month + 1, 0).day;
    final firstDayWeekday = DateTime(currentDate.year, currentDate.month, 1).weekday;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Header dengan Bulan dan Tahun
        Container(
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: _previousMonth,
                child: Icon(Icons.chevron_left, color: Color(0xFF2D3142), size: 22),
              ),
              Column(
                children: [
                  Text(
                    _getMonthName(currentDate.month),
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2D3142),
                    ),
                  ),
                  Text(
                    currentDate.year.toString(),
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF2D3142),
                    ),
                  ),
                ],
              ),
              GestureDetector(
                onTap: _nextMonth,
                child: Icon(Icons.chevron_right, color: Color(0xFF2D3142), size: 22),
              ),
            ],
          ),
        ),
        SizedBox(height: 8),

        // Days of week header
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0.0),
          child: Row(
            children: ['Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa', 'Su']
                .map((day) => Expanded(
                  child: Center(
                    child: Text(
                      day,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 11,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ))
                .toList(),
          ),
        ),
        SizedBox(height: 4),

        // Calendar Grid
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0.0),
          child: GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
              childAspectRatio: 0.95,
              mainAxisSpacing: 2,
              crossAxisSpacing: 2,
            ),
            itemCount: days.length,
            itemBuilder: (context, index) {
              final day = int.parse(days[index]);
              final isCurrentMonth = index >= (firstDayWeekday - 1) &&
                  index < (firstDayWeekday - 1 + daysInCurrentMonth);
              final isToday = isCurrentMonth &&
                  day == DateTime.now().day &&
                  currentDate.year == DateTime.now().year &&
                  currentDate.month == DateTime.now().month;

              return GestureDetector(
                onTap: isCurrentMonth
                    ? () {
                  final selectedDate = DateTime(currentDate.year, currentDate.month, day);
                  widget.onDateSelected(selectedDate);
                }
                    : null,
                child: Container(
                  decoration: BoxDecoration(
                    color: isToday ? Color(0xFFF06292) : Colors.transparent,
                    border: Border.all(
                      color: isToday ? Color(0xFFF06292) : Colors.transparent,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Center(
                    child: Text(
                      day.toString(),
                      style: TextStyle(
                        fontSize: 12,
                        color: isCurrentMonth
                            ? (isToday ? Colors.white : Color(0xFF2D3142))
                            : Colors.grey.shade300,
                        fontWeight: isToday ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        SizedBox(height: 12),

        // Tombol Simpan Perubahan
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFFF48FB1),
              padding: EdgeInsets.symmetric(vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text(
              'Simpan Perubahan',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ),
        ),
      ],
    );
  }

  String _getMonthName(int month) {
    const months = [
      'Januari',
      'Februari',
      'Maret',
      'April',
      'Mei',
      'Juni',
      'Juli',
      'Agustus',
      'September',
      'Oktober',
      'November',
      'Desember',
    ];
    return months[month - 1];
  }
}
