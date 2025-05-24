import 'package:flutter/material.dart';
import 'package:un_ride/appColors.dart';
import 'package:un_ride/screens/Widgets/widgets.dart';

class CreateRideScreen extends StatefulWidget {
  final VoidCallback onClose;

  const CreateRideScreen({super.key, required this.onClose});

  @override
  State<CreateRideScreen> createState() => _CreateRideScreenState();
}

class _CreateRideScreenState extends State<CreateRideScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  // Form controllers
  final _formKey = GlobalKey<FormState>();
  final _originController = TextEditingController();
  final _destinationController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _passengersController = TextEditingController();
  final _priceController = TextEditingController();

  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _originController.dispose();
    _destinationController.dispose();
    _descriptionController.dispose();
    _passengersController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  void _closeScreen() async {
    await _animationController.reverse();
    widget.onClose();
  }

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.dark(
              primary: AppColors.primary,
              onPrimary: AppColors.textPrimary,
              surface: AppColors.cardBackground,
              onSurface: AppColors.textPrimary,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _selectTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.dark(
              primary: AppColors.primary,
              onPrimary: AppColors.textPrimary,
              surface: AppColors.cardBackground,
              onSurface: AppColors.textPrimary,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      if (_selectedDate == null || _selectedTime == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Por favor selecciona fecha y hora'),
            backgroundColor: AppColors.primary,
          ),
        );
        return;
      }

      //!LLAMADO DEL BLOC

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('¡Publicación creada exitosamente!'),
          backgroundColor: AppColors.primary,
        ),
      );

      _closeScreen();
    }
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  String _formatTime(TimeOfDay time) {
    return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground, // Pure black background
      body: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return FadeTransition(
            opacity: _fadeAnimation,
            child: Column(
              children: [
                AppBar(
                  backgroundColor: AppColors.primaryDark, // Dark gray AppBar
                  elevation: 0,
                  leading: IconButton(
                    icon: const Icon(Icons.close, color: AppColors.textPrimary),
                    onPressed: _closeScreen,
                  ),
                  title: const Text(
                    'Crear Publicación',
                    style: TextStyle(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.only(
                      left: 16,
                      right: 16,
                      bottom: MediaQuery.of(context).viewInsets.bottom + 16,
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const SizedBox(height: 20),
                          // Origin field
                          SignUpTextField(
                            controller: _originController,
                            label: 'Origen',
                            prefixIcon: const Icon(
                              Icons.my_location,
                              color: AppColors.textSecondary,
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Por favor ingresa el origen';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),
                          // Destination field
                          SignUpTextField(
                            controller: _destinationController,
                            label: 'Destino',
                            prefixIcon: const Icon(
                              Icons.location_on,
                              color: AppColors.textSecondary,
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Por favor ingresa el destino';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),
                          // Date and Time selection
                          Row(
                            children: [
                              Expanded(
                                child: GestureDetector(
                                  onTap: _selectDate,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 16,
                                      horizontal: 12,
                                    ),
                                    decoration: BoxDecoration(
                                      color:
                                          AppColors
                                              .cardBackground, // Card background color
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Row(
                                      children: [
                                        const Icon(
                                          Icons.calendar_today,
                                          color: AppColors.textSecondary,
                                        ),
                                        const SizedBox(width: 12),
                                        Text(
                                          _selectedDate != null
                                              ? _formatDate(_selectedDate!)
                                              : 'Fecha',
                                          style: TextStyle(
                                            color:
                                                _selectedDate != null
                                                    ? AppColors.textPrimary
                                                    : AppColors.textSecondary,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: GestureDetector(
                                  onTap: _selectTime,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 16,
                                      horizontal: 12,
                                    ),
                                    decoration: BoxDecoration(
                                      color:
                                          AppColors
                                              .cardBackground, // Card background color
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Row(
                                      children: [
                                        const Icon(
                                          Icons.access_time,
                                          color: AppColors.textSecondary,
                                        ),
                                        const SizedBox(width: 12),
                                        Text(
                                          _selectedTime != null
                                              ? _formatTime(_selectedTime!)
                                              : 'Hora',
                                          style: TextStyle(
                                            color:
                                                _selectedTime != null
                                                    ? AppColors.textPrimary
                                                    : AppColors.textSecondary,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          // Price field
                          SignUpTextField(
                            controller: _priceController,
                            label: 'Precio sugerido (\$)',
                            keyboardType: TextInputType.numberWithOptions(
                              decimal: true,
                            ),
                            prefixIcon: const Icon(
                              Icons.attach_money,
                              color: AppColors.textSecondary,
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Por favor ingresa el precio';
                              }
                              final double? price = double.tryParse(value);
                              if (price == null || price < 0) {
                                return 'Ingresa un precio válido';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),
                          // Passengers field
                          SignUpTextField(
                            controller: _passengersController,
                            label: 'Número de pasajeros',
                            keyboardType: TextInputType.number,
                            prefixIcon: const Icon(
                              Icons.people,
                              color: AppColors.textSecondary,
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Por favor ingresa el número de pasajeros';
                              }
                              final int? passengers = int.tryParse(value);
                              if (passengers == null || passengers <= 0) {
                                return 'Ingresa un número válido';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),
                          // Description field
                          SignUpTextField(
                            controller: _descriptionController,
                            label: 'Descripción (opcional)',
                            prefixIcon: const Icon(
                              Icons.description,
                              color: AppColors.textSecondary,
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 20,
                              horizontal: 12,
                            ),
                          ),
                          const SizedBox(height: 32),
                          // Submit button
                          SignInSubmitButton(
                            isLoading: _isLoading,
                            text: 'Crear Publicación',
                            onPressed: _submitForm,
                            height: 54,
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
