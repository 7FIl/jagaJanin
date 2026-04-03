import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PilihJadwalKonsultasiDialog extends StatefulWidget {
  final String nama;
  final String spesialis;
  final String tarif;
  final String hari1;
  final String waktu1;
  final String kondisi1;
  final String? hari2;
  final String? waktu2;
  final String? kondisi2;
  final String? hari3;
  final String? waktu3;
  final String? kondisi3;
  final Function(String, String) onConfirm;

  const PilihJadwalKonsultasiDialog({
    super.key,
    required this.nama,
    required this.spesialis,
    required this.tarif,
    required this.hari1,
    required this.waktu1,
    required this.kondisi1,
    this.hari2,
    this.waktu2,
    this.kondisi2,
    this.hari3,
    this.waktu3,
    this.kondisi3,
    required this.onConfirm,
  });

  @override
  State<PilihJadwalKonsultasiDialog> createState() =>
      _PilihJadwalKonsultasiDialogState();
}

class _PilihJadwalKonsultasiDialogState
    extends State<PilihJadwalKonsultasiDialog> {
  DateTime? selectedDate;
  String? selectedTime;
  late List<DateTime> availableDates;

  final Color primaryPink = const Color(0xFFE594AB);
  final Color lightPinkBg = const Color(0xFFFCE4EC);
  final Color borderColor = const Color(0xFFFFD1DC);

  @override
  void initState() {
    super.initState();
    // Generate available dates (next 30 days)
    availableDates = [];
    final today = DateTime.now();
    for (int i = 0; i < 30; i++) {
      availableDates.add(today.add(Duration(days: i)));
    }
  }

  /// Check if a day name matches doctor's schedule
  bool isDoctorAvailable(String dayName) {
    final doctorDays = [widget.hari1, widget.hari2, widget.hari3]
        .where((day) => day != null)
        .map((day) => day!.toLowerCase())
        .toList();

    return doctorDays.contains(dayName.toLowerCase());
  }

  /// Get available time slots for a selected day
  String getTimeSlot(String dayName) {
    final dayLower = dayName.toLowerCase();

    if (dayLower == widget.hari1.toLowerCase()) {
      return '${widget.waktu1}\n${widget.kondisi1}';
    }
    if (widget.hari2 != null && dayLower == widget.hari2!.toLowerCase()) {
      return '${widget.waktu2 ?? ''}\n${widget.kondisi2 ?? ''}';
    }
    if (widget.hari3 != null && dayLower == widget.hari3!.toLowerCase()) {
      return '${widget.waktu3 ?? ''}\n${widget.kondisi3 ?? ''}';
    }

    return 'Tidak ada jadwal dokter';
  }

  /// Get day name from datetime
  String getDayName(DateTime date) {
    const days = ['Minggu', 'Senin', 'Selasa', 'Rabu', 'Kamis', 'Jumat', 'Sabtu'];
    return days[date.weekday % 7];
  }

  /// Format selected date for display
  String getFormattedSelectedDate() {
    if (selectedDate == null) return '';
    final dayName = getDayName(selectedDate!);
    try {
      final formatter = DateFormat('d MMMM yyyy', 'id_ID');
      return '$dayName, ${formatter.format(selectedDate!)}';
    } catch (e) {
      // Fallback if locale not initialized
      final months = ['', 'Januari', 'Februari', 'Maret', 'April', 'Mei', 'Juni', 
                     'Juli', 'Agustus', 'September', 'Oktober', 'November', 'Desember'];
      return '$dayName, ${selectedDate!.day} ${months[selectedDate!.month]} ${selectedDate!.year}';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Text(
                'Pilih Jadwal Konsultasi',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 16),

              // Pilih Tanggal Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Pilih Tanggal',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF2D3142),
                    ),
                  ),
                  Text(
                    _getMonthYearDisplay(),
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: primaryPink,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              // Date picker - Horizontal scroll with 5 days + calendar button
              Row(
                children: [
                  // Horizontal scroll untuk 5 hari
                  Expanded(
                    child: SizedBox(
                      height: 75,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 5, // Show 5 days
                        itemBuilder: (context, index) {
                          final date = availableDates[index];
                          final dayName = getDayName(date);
                          final isSelected = selectedDate == date;

                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedDate = date;
                                // Auto-select time if available
                                if (isDoctorAvailable(dayName)) {
                                  selectedTime = getTimeSlot(dayName);
                                } else {
                                  selectedTime = null;
                                }
                              });
                            },
                            child: Container(
                              width: 64,
                              margin: const EdgeInsets.only(right: 8),
                              decoration: BoxDecoration(
                                color: isSelected ? primaryPink : Colors.white,
                                border: Border.all(
                                  color: isSelected ? primaryPink : Colors.grey[300]!,
                                  width: 1.5,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    dayName.substring(0, 3),
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w500,
                                      color: isSelected ? Colors.white : Color(0xFF7E8CA0),
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    '${date.day}',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: isSelected ? Colors.white : Color(0xFF2D3142),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  // Calendar button untuk pilih tanggal lanjutan
                  GestureDetector(
                    onTap: () => _showMoreDates(context),
                    child: Container(
                      width: 52,
                      height: 52,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(
                        Icons.calendar_month_rounded,
                        color: Colors.grey[600],
                        size: 22,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Pilih Jam
              Text(
                'Pilih Jam',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF2D3142),
                ),
              ),
              const SizedBox(height: 12),
              // Time slots grid
              if (selectedDate != null)
                Column(
                  children: [
                    if (isDoctorAvailable(getDayName(selectedDate!)))
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: _buildTimeSlots(),
                      )
                    else
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                            vertical: 16, horizontal: 12),
                        decoration: BoxDecoration(
                          color: lightPinkBg,
                          border: Border.all(color: borderColor),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          'Tidak ada jadwal dokter',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            color: primaryPink,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                  ],
                )
              else
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                      vertical: 16, horizontal: 12),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    border: Border.all(color: Colors.grey[300]!),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    'Pilih tanggal terlebih dahulu',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                ),
              const SizedBox(height: 20),

              // Jadwal Terpilih
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: lightPinkBg,
                  border: Border.all(color: borderColor, width: 1.5),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildScheduleRow(
                      icon: Icons.calendar_month_rounded,
                      title: 'Jadwal Terpilih',
                      value: selectedDate != null
                          ? getFormattedSelectedDate()
                          : 'Belum dipilih',
                    ),
                    const SizedBox(height: 12),
                    _buildScheduleRow(
                      icon: Icons.access_time_rounded,
                      title: 'Waktu Konsultasi',
                      value: selectedTime != null
                          ? selectedTime!.split('\n').first
                          : 'Belum dipilih',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Tombol Konfirmasi
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: (selectedDate != null && selectedTime != null)
                      ? () {
                          // Call onConfirm - which will handle closing the dialog
                          widget.onConfirm(
                            getFormattedSelectedDate(),
                            selectedTime!.split('\n').first,
                          );
                          // Don't pop here - let DokterCard.onConfirm handle it
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryPink,
                    disabledBackgroundColor: Colors.grey[300],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    'Konfirmasi Jadwal',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: (selectedDate != null && selectedTime != null)
                          ? Colors.white
                          : Colors.grey[600],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTimeSlot(String time) {
    final isSelected = selectedTime?.split('\n').first == time;
    return GestureDetector(
      onTap: selectedDate != null ? () {
        setState(() {
          selectedTime = '$time\n${getTimeSlot(getDayName(selectedDate!))}';
        });
      } : null,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        decoration: BoxDecoration(
          color: isSelected ? primaryPink : Colors.white,
          border: Border.all(
            color: isSelected ? primaryPink : borderColor,
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          time,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: isSelected ? Colors.white : primaryPink,
          ),
        ),
      ),
    );
  }

  /// Generate time slots based on doctor's working hours
  List<Widget> _buildTimeSlots() {
    final dayName = getDayName(selectedDate!);
    List<String> timeSlots = [];

    // Get time range from doctor's schedule
    String timeRange = getTimeSlot(dayName).split('\n').first;

    // Parse time range (e.g., "09.00 - 12.00")
    final parts = timeRange.split(' - ');
    if (parts.length == 2) {
      final startTime = parts[0].trim();
      final endTime = parts[1].trim();

      // Parse hours
      final startHour = int.tryParse(startTime.split('.')[0]) ?? 9;
      final endHour = int.tryParse(endTime.split('.')[0]) ?? 12;

      // Generate slots every hour
      for (int hour = startHour; hour < endHour; hour++) {
        timeSlots.add('${hour.toString().padLeft(2, '0')}.00');
      }
    }

    // Fallback if parsing fails
    if (timeSlots.isEmpty) {
      timeSlots = ['09.00', '10.00', '11.00', '13.00', '14.00', '15.00'];
    }

    return timeSlots.map((time) => _buildTimeSlot(time)).toList();
  }

  Widget _buildScheduleRow({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            color: primaryPink,
            size: 20,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF2D3142),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// Get month year display (e.g., "April 2026")
  String _getMonthYearDisplay() {
    try {
      final formatter = DateFormat('MMMM yyyy', 'id_ID');
      return formatter.format(DateTime.now());
    } catch (e) {
      // Fallback if locale not initialized
      final months = ['', 'Januari', 'Februari', 'Maret', 'April', 'Mei', 'Juni', 
                     'Juli', 'Agustus', 'September', 'Oktober', 'November', 'Desember'];
      final now = DateTime.now();
      return '${months[now.month]} ${now.year}';
    }
  }

  /// Show date picker for selecting dates beyond the first 5 days
  void _showMoreDates(BuildContext context) {
    showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 90)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: primaryPink,
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: Colors.black87,
            ),
          ),
          child: child!,
        );
      },
    ).then((date) {
      if (date != null) {
        setState(() {
          selectedDate = date;
          final dayName = getDayName(date);
          if (isDoctorAvailable(dayName)) {
            selectedTime = getTimeSlot(dayName);
          } else {
            selectedTime = null;
          }
        });
      }
    });
  }
}
