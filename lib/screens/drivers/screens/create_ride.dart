import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:un_ride/appColors.dart';
import 'package:un_ride/blocs/authentication/bloc/authentication_bloc.dart';
import 'package:un_ride/blocs/driver_post/bloc/driver_post_bloc.dart';

import 'package:un_ride/screens/Widgets/widgets.dart';

class CreateDriverRideScreen extends StatefulWidget {
  final VoidCallback onClose;
  final bool isEditing;
  final String? postId;
  final String? initialOrigin;
  final String? initialDestination;
  final String? initialDescription;
  final double? initialPrice;
  final DateTime? initialDate;
  final TimeOfDay? initialTime;
  final int? initialPassengers;
  final bool? initialAllowPets;
  final bool? initialAllowLuggage;

  const CreateDriverRideScreen({
    super.key,
    required this.onClose,
    this.isEditing = false,
    this.postId,
    this.initialOrigin,
    this.initialDestination,
    this.initialDescription,
    this.initialPrice,
    this.initialDate,
    this.initialTime,
    this.initialPassengers,
    this.initialAllowPets,
    this.initialAllowLuggage,
  });
  @override
  State<CreateDriverRideScreen> createState() => _CreateDriverRideScreenState();
}

class _CreateDriverRideScreenState extends State<CreateDriverRideScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  // Form controllers
  final _formKey = GlobalKey<FormState>();
  final _originController = TextEditingController();
  final _destinationController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _priceController = TextEditingController();

  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  bool _isLoading = false;
  int _selectedPassengers = 1;
  bool _allowPets = false;
  bool _allowLuggage = false;

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

    if (widget.isEditing) {
      _originController.text = widget.initialOrigin ?? '';
      _destinationController.text = widget.initialDestination ?? '';
      _descriptionController.text = widget.initialDescription ?? '';
      _priceController.text = widget.initialPrice?.toString() ?? '';
      _selectedDate = widget.initialDate;
      _selectedTime = widget.initialTime;
      _selectedPassengers = widget.initialPassengers ?? 1;
      _allowPets = widget.initialAllowPets ?? false;
      _allowLuggage = widget.initialAllowLuggage ?? false;
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    _originController.dispose();
    _destinationController.dispose();
    _descriptionController.dispose();
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
      locale: const Locale('es', 'ES'),
      helpText: 'Seleccionar Fecha',
      cancelText: 'Cancelar',
      confirmText: 'Confirmar',
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.dark(
              primary: AppColors.primary,
              onPrimary: AppColors.textPrimary,
              surface: AppColors.cardBackground,
              onSurface: AppColors.textPrimary,
              background: AppColors.cardBackground,
              onBackground: AppColors.textPrimary,
            ),
            dialogTheme: DialogTheme(
              backgroundColor: AppColors.cardBackground,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              elevation: 20,
            ),
            textTheme: Theme.of(context).textTheme.copyWith(
              bodyLarge: const TextStyle(color: Colors.white),
              bodyMedium: const TextStyle(color: Colors.white),
              headlineMedium: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              labelLarge: const TextStyle(color: Colors.white),
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
      helpText: 'Seleccionar Hora',
      cancelText: 'Cancelar',
      confirmText: 'Confirmar',
      hourLabelText: 'Hora',
      minuteLabelText: 'Minuto',
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.dark(
              primary: AppColors.primary,
              onPrimary: AppColors.textPrimary,
              surface: AppColors.cardBackground,
              onSurface: AppColors.textPrimary,
              background: AppColors.cardBackground,
              onBackground: AppColors.textPrimary,
              secondary: AppColors.primary,
              onSecondary: AppColors.textPrimary,
            ),
            dialogTheme: DialogTheme(
              backgroundColor: AppColors.cardBackground,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              elevation: 20,
            ),
            textTheme: Theme.of(context).textTheme.copyWith(
              bodyLarge: const TextStyle(color: Colors.white),
              bodyMedium: const TextStyle(color: Colors.white),
              headlineMedium: const TextStyle(
                color: AppColors.primaryLight,
                fontWeight: FontWeight.bold,
              ),
              headlineSmall: const TextStyle(
                color: AppColors.primaryLight,
                fontWeight: FontWeight.bold,
              ),
              labelLarge: const TextStyle(
                color: AppColors.primaryLight,
                fontWeight: FontWeight.w600,
              ),
              displayMedium: const TextStyle(
                color: AppColors.primaryLight,
                fontWeight: FontWeight.bold,
              ),
            ),

            segmentedButtonTheme: SegmentedButtonThemeData(
              style: SegmentedButton.styleFrom(
                backgroundColor: Colors.transparent,
                selectedBackgroundColor: AppColors.primary,
                selectedForegroundColor: AppColors.textPrimary,
                foregroundColor: AppColors.textSecondary,
                side: const BorderSide(color: AppColors.primary, width: 1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
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

      if (widget.isEditing) {
        print("🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕🐕");
        await updateDriverPost();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              '¡Publicación actualizada exitosamente!',
              style: TextStyle(color: Colors.black),
            ),
            backgroundColor: AppColors.accentGreen, //!Colocar verde?
          ),
        );
      } else {
        await saveDriverPost();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              '¡Publicación creada exitosamente!',
              style: TextStyle(color: Colors.black),
            ),
            backgroundColor: AppColors.accentGreen,
          ),
        );
      }

      _closeScreen();
    }
  }

  Future<void> saveDriverPost() async {
    final user = context.read<AuthenticationBloc>().state.user;
    final formattedDate = DateFormat('dd/MM/yyyy').format(_selectedDate!);
    context.read<DriverPostBloc>().add(
      await DriverPostRegister(
        user: user,
        origin: _originController.text.trim(),
        destination: _destinationController.text.trim(),
        description: _descriptionController.text.trim(),
        passengers: _selectedPassengers,
        travelDate: formattedDate,
        travelTime: _selectedTime?.format(context),
        suggestedAmount: double.parse(_priceController.text),
        allowsPets: _allowPets,
        allowsLuggage: _allowLuggage,
      ),
    );
  }

  Future<void> updateDriverPost() async {
    final user = context.read<AuthenticationBloc>().state.user;
    final formattedDate = DateFormat('dd/MM/yyyy').format(_selectedDate!);
    print("💐💐💐💐💐");
    print(widget.postId);
    context.read<DriverPostBloc>().add(
      await UpdateDriverPost(
        postId: widget.postId!,
        user: user,
        origin: _originController.text.trim(),
        destination: _destinationController.text.trim(),
        description: _descriptionController.text.trim(),
        passengers: _selectedPassengers,
        travelDate: formattedDate,
        travelTime: _selectedTime?.format(context),
        suggestedAmount: double.parse(_priceController.text),
        allowsPets: _allowPets,
        allowsLuggage: _allowLuggage,
      ),
    );
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
                  title: Text(
                    widget.isEditing
                        ? 'Modificar Publicación'
                        : 'Crear Publicación',
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
                          // Passengers dropdown selector
                          Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 4,
                              horizontal: 12,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.cardBackground,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: DropdownButtonFormField<int>(
                              value: _selectedPassengers,
                              decoration: const InputDecoration(
                                labelText: 'Número de pasajeros',
                                labelStyle: TextStyle(
                                  color: AppColors.textSecondary,
                                ),
                                prefixIcon: Icon(
                                  Icons.people,
                                  color: AppColors.textSecondary,
                                ),
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.symmetric(
                                  vertical: 16,
                                  horizontal: 0,
                                ),
                              ),
                              style: const TextStyle(
                                color: AppColors.textPrimary,
                                fontSize: 16,
                              ),
                              dropdownColor: AppColors.cardBackground,
                              items:
                                  List.generate(8, (index) => index + 1).map((
                                    int value,
                                  ) {
                                    return DropdownMenuItem<int>(
                                      value: value,
                                      child: Text(
                                        '$value ${value == 1 ? 'pasajero' : 'pasajeros'}',
                                        style: const TextStyle(
                                          color: AppColors.textPrimary,
                                        ),
                                      ),
                                    );
                                  }).toList(),
                              onChanged: (int? newValue) {
                                setState(() {
                                  _selectedPassengers = newValue ?? 1;
                                });
                              },
                              validator: (value) {
                                if (value == null) {
                                  return 'Por favor selecciona el número de pasajeros';
                                }
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(height: 16),
                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: AppColors.cardBackground,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.pets,
                                      color: AppColors.textSecondary,
                                      size: 24,
                                    ),
                                    const SizedBox(width: 12),
                                    const Expanded(
                                      child: Text(
                                        'Mascotas',
                                        style: TextStyle(
                                          color: AppColors.textPrimary,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    Switch(
                                      value: _allowPets,
                                      onChanged: (bool value) {
                                        setState(() {
                                          _allowPets = value;
                                        });
                                      },
                                      activeColor: AppColors.primary,
                                      activeTrackColor: AppColors.primary
                                          .withOpacity(0.3),
                                      inactiveThumbColor:
                                          AppColors.textSecondary,
                                      inactiveTrackColor: AppColors
                                          .textSecondary
                                          .withOpacity(0.3),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 12),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.luggage,
                                      color: AppColors.textSecondary,
                                      size: 24,
                                    ),
                                    const SizedBox(width: 12),
                                    const Expanded(
                                      child: Text(
                                        'Equipaje',
                                        style: TextStyle(
                                          color: AppColors.textPrimary,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    Switch(
                                      value: _allowLuggage,
                                      onChanged: (bool value) {
                                        setState(() {
                                          _allowLuggage = value;
                                        });
                                      },
                                      activeColor: AppColors.primary,
                                      activeTrackColor: AppColors.primary
                                          .withOpacity(0.3),
                                      inactiveThumbColor:
                                          AppColors.textSecondary,
                                      inactiveTrackColor: AppColors
                                          .textSecondary
                                          .withOpacity(0.3),
                                    ),
                                  ],
                                ),
                              ],
                            ),
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
                            text:
                                widget.isEditing
                                    ? 'Actualizar Publicación'
                                    : 'Crear Publicación',
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
