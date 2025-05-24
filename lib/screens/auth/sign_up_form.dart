import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:un_ride/blocs/authentication/authentication.dart';
import 'package:un_ride/screens/Widgets/widgets.dart';
import 'package:un_ride/appColors.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({Key? key}) : super(key: key);

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();

  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _idNumberController = TextEditingController();
  final _phoneController = TextEditingController();

  final _licensePlateController = TextEditingController();
  final _carBrandController = TextEditingController();
  final _modelController = TextEditingController();
  final _yearController = TextEditingController();
  String _selectedVehicleType = 'Automobile';
  String _selectedVehicleColor = 'Black';
  final List<String> _vehicleTypes = [
    'Automobile',
    'Motorcycle',
    'SUV',
    'Truck',
    'Van',
  ];
  final List<String> _vehicleColors = [
    'Black',
    'White',
    'Silver',
    'Gray',
    'Red',
    'Blue',
    'Green',
    'Yellow',
    'Orange',
    'Brown',
  ];

  bool _isLoading = false;
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  bool _showVehicleRegistration = false;

  late AnimationController _formAnimationController;
  late AnimationController _vehicleAnimationController;
  late Animation<double> _formOpacity;
  late Animation<double> _vehicleOpacity;
  late Animation<double> _vehicleHeight;

  @override
  void initState() {
    super.initState();

    _formAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _formOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _formAnimationController,
        curve: const Interval(0.0, 0.8, curve: Curves.easeOut),
      ),
    );

    _vehicleAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _vehicleOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _vehicleAnimationController,
        curve: const Interval(0.3, 1.0, curve: Curves.easeOut),
      ),
    );

    _vehicleHeight = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _vehicleAnimationController,
        curve: const Interval(0.0, 0.7, curve: Curves.easeOut),
      ),
    );

    _formAnimationController.forward();
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _idNumberController.dispose();
    _phoneController.dispose();
    _licensePlateController.dispose();
    _carBrandController.dispose();
    _modelController.dispose();
    _yearController.dispose();
    _formAnimationController.dispose();
    _vehicleAnimationController.dispose();
    super.dispose();
  }

  void _toggleVehicleRegistration() {
    setState(() {
      _showVehicleRegistration = !_showVehicleRegistration;
      if (_showVehicleRegistration) {
        _vehicleAnimationController.forward();
      } else {
        _vehicleAnimationController.reverse();
      }
    });
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      bool hasVehicle = false;
      if (_showVehicleRegistration &&
          _licensePlateController.text.isNotEmpty &&
          _carBrandController.text.isNotEmpty &&
          _modelController.text.isNotEmpty &&
          _yearController.text.isNotEmpty &&
          _selectedVehicleType.isNotEmpty &&
          _selectedVehicleColor.isNotEmpty) {
        hasVehicle = true;
      }

      if (hasVehicle) {
        context.read<AuthenticationBloc>().add(
          AuthenticationUserRegister(
            identification: _idNumberController.text.trim(),
            name: _firstNameController.text.trim(),
            surname: _lastNameController.text.trim(),
            email: _emailController.text.trim(),
            phone: _phoneController.text.trim(),
            password: _passwordController.text,
            profilePictureUrl: '',
            hasVehicle: hasVehicle,
            licensePlate: _licensePlateController.text.trim(),
            make: _carBrandController.text.trim(),
            year: _yearController.text.trim(),
            color: _selectedVehicleColor,
            model: _modelController.text.trim(),
            vehicleType: _selectedVehicleType,
          ),
        );
      } else {
        context.read<AuthenticationBloc>().add(
          AuthenticationUserRegister(
            identification: _idNumberController.text.trim(),
            name: _firstNameController.text.trim(),
            surname: _lastNameController.text.trim(),
            phone: _phoneController.text.trim(),
            email: _emailController.text.trim(),
            password: _passwordController.text,
            profilePictureUrl: '',
            hasVehicle: hasVehicle,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isSmallScreen = MediaQuery.of(context).size.width < 360;

    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        if (state.status == AuthenticationStatus.authenticated) {
          setState(() {
            _isLoading = false;
          });
        } else if (state.status == AuthenticationStatus.unauthenticated) {
          setState(() {
            _isLoading = false;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Registration failed. Please try again.'),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      child: Form(
        key: _formKey,
        child: FadeTransition(
          opacity: _formOpacity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // ID Number Field
              _buildAnimatedField(
                delay: 0.0,
                child: SignUpTextField(
                  controller: _idNumberController,
                  label: 'ID Number (Cédula)',
                  keyboardType: TextInputType.number,
                  prefixIcon: const Icon(
                    Icons.badge_outlined,
                    color: Colors.white70,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'ID number is required';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 16),

              // First Name and Last Name Fields
              LayoutBuilder(
                builder: (context, constraints) {
                  if (constraints.maxWidth > 500) {
                    return _buildAnimatedField(
                      delay: 0.1,
                      child: Row(
                        children: [
                          Expanded(
                            child: SignUpTextField(
                              controller: _firstNameController,
                              label: 'First Name',
                              prefixIcon: const Icon(
                                Icons.person_outline,
                                color: Colors.white70,
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'First name is required';
                                }
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: SignUpTextField(
                              controller: _lastNameController,
                              label: 'Last Name',
                              prefixIcon: const Icon(
                                Icons.person_outline,
                                color: Colors.white70,
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Last name is required';
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                    );
                  } else {
                    return Column(
                      children: [
                        _buildAnimatedField(
                          delay: 0.1,
                          child: SignUpTextField(
                            controller: _firstNameController,
                            label: 'First Name',
                            prefixIcon: const Icon(
                              Icons.person_outline,
                              color: Colors.white70,
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'First name is required';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(height: 16),
                        _buildAnimatedField(
                          delay: 0.15,
                          child: SignUpTextField(
                            controller: _lastNameController,
                            label: 'Last Name',
                            prefixIcon: const Icon(
                              Icons.person_outline,
                              color: Colors.white70,
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Last name is required';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    );
                  }
                },
              ),
              const SizedBox(height: 16),

              // Phone Number Field
              _buildAnimatedField(
                delay: 0.2,
                child: SignUpTextField(
                  controller: _phoneController,
                  label: 'Phone Number',
                  keyboardType: TextInputType.phone,
                  prefixIcon: const Icon(
                    Icons.phone_outlined,
                    color: Colors.white70,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Phone number is required';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 16),

              // Email Address Field
              _buildAnimatedField(
                delay: 0.25,
                child: SignUpTextField(
                  controller: _emailController,
                  label: 'Email Address',
                  keyboardType: TextInputType.emailAddress,
                  prefixIcon: const Icon(
                    Icons.email_outlined,
                    color: Colors.white70,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Email is required';
                    }
                    if (!RegExp(
                      r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                    ).hasMatch(value)) {
                      return 'Enter a valid email address';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 16),

              // Password and Confirm Password Fields
              LayoutBuilder(
                builder: (context, constraints) {
                  if (constraints.maxWidth > 500) {
                    return _buildAnimatedField(
                      delay: 0.3,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: SignUpTextField(
                              controller: _passwordController,
                              label: 'Password',
                              obscureText: !_isPasswordVisible,
                              prefixIcon: const Icon(
                                Icons.lock_outline,
                                color: Colors.white70,
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _isPasswordVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Colors.white54,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _isPasswordVisible = !_isPasswordVisible;
                                  });
                                },
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Password is required';
                                }
                                if (value.length < 6) {
                                  return 'Min 6 characters';
                                }
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: SignUpTextField(
                              controller: _confirmPasswordController,
                              label: 'Confirm Password',
                              obscureText: !_isConfirmPasswordVisible,
                              prefixIcon: const Icon(
                                Icons.lock_outline,
                                color: Colors.white70,
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _isConfirmPasswordVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Colors.white54,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _isConfirmPasswordVisible =
                                        !_isConfirmPasswordVisible;
                                  });
                                },
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please confirm password';
                                }
                                if (value != _passwordController.text) {
                                  return 'Passwords do not match';
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                    );
                  } else {
                    return Column(
                      children: [
                        _buildAnimatedField(
                          delay: 0.3,
                          child: SignUpTextField(
                            controller: _passwordController,
                            label: 'Password',
                            obscureText: !_isPasswordVisible,
                            prefixIcon: const Icon(
                              Icons.lock_outline,
                              color: Colors.white70,
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _isPasswordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Colors.white54,
                              ),
                              onPressed: () {
                                setState(() {
                                  _isPasswordVisible = !_isPasswordVisible;
                                });
                              },
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Password is required';
                              }
                              if (value.length < 6) {
                                return 'Password must be at least 6 characters';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(height: 16),
                        _buildAnimatedField(
                          delay: 0.35,
                          child: SignUpTextField(
                            controller: _confirmPasswordController,
                            label: 'Confirm Password',
                            obscureText: !_isConfirmPasswordVisible,
                            prefixIcon: const Icon(
                              Icons.lock_outline,
                              color: Colors.white70,
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _isConfirmPasswordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Colors.white54,
                              ),
                              onPressed: () {
                                setState(() {
                                  _isConfirmPasswordVisible =
                                      !_isConfirmPasswordVisible;
                                });
                              },
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please confirm your password';
                              }
                              if (value != _passwordController.text) {
                                return 'Passwords do not match';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    );
                  }
                },
              ),
              const SizedBox(height: 24),

              _buildAnimatedField(
                delay: 0.4,
                child: OutlinedButton(
                  onPressed: _toggleVehicleRegistration,
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.white,
                    side: BorderSide(color: Colors.white.withOpacity(0.5)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  child: Text(
                    _showVehicleRegistration
                        ? 'Hide Vehicle Registration'
                        : 'Register a Vehicle',
                    style: const TextStyle(fontSize: 14),
                  ),
                ),
              ),

              if (_showVehicleRegistration)
                AnimatedBuilder(
                  animation: _vehicleAnimationController,
                  builder: (context, child) {
                    return Opacity(
                      opacity: _vehicleOpacity.value,
                      child: SizeTransition(
                        sizeFactor: _vehicleHeight,
                        child: Column(
                          children: [
                            const SizedBox(height: 24),
                            Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.05),
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                  color: Colors.indigo.shade200.withOpacity(
                                    0.3,
                                  ),
                                  width: 1,
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Vehicle Information',
                                    style: TextStyle(
                                      color: Colors.white.withOpacity(0.9),
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(height: 16),

                                  SignUpTextField(
                                    controller: _licensePlateController,
                                    label: 'License Plate',
                                    prefixIcon: const Icon(
                                      Icons.directions_car_outlined,
                                      color: Colors.white70,
                                    ),
                                    textCapitalization:
                                        TextCapitalization.characters,
                                  ),
                                  const SizedBox(height: 16),

                                  SignUpTextField(
                                    controller: _carBrandController,
                                    label: 'Car Brand',
                                    prefixIcon: const Icon(
                                      Icons.design_services_outlined,
                                      color: Colors.white70,
                                    ),
                                  ),
                                  const SizedBox(height: 16),

                                  SignUpTextField(
                                    controller: _modelController,
                                    label: 'Model',
                                    prefixIcon: const Icon(
                                      Icons.model_training_outlined,
                                      color: Colors.white70,
                                    ),
                                  ),
                                  const SizedBox(height: 16),

                                  SignUpTextField(
                                    controller: _yearController,
                                    label: 'Year',
                                    keyboardType: TextInputType.number,
                                    prefixIcon: const Icon(
                                      Icons.calendar_today_outlined,
                                      color: Colors.white70,
                                    ),
                                  ),
                                  const SizedBox(height: 16),

                                  DropdownButtonFormField<String>(
                                    value: _selectedVehicleColor,
                                    dropdownColor: Colors.black87,
                                    style: const TextStyle(color: Colors.white),
                                    decoration: InputDecoration(
                                      labelText: 'Vehicle Color',
                                      labelStyle: TextStyle(
                                        color: Colors.white.withOpacity(0.7),
                                      ),
                                      fillColor: Colors.white.withOpacity(0.05),
                                      filled: true,
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                            vertical: 16,
                                            horizontal: 12,
                                          ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide.none,
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide.none,
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                          color: Colors.indigo.shade200,
                                          width: 1,
                                        ),
                                      ),
                                      prefixIcon: const Icon(
                                        Icons.color_lens_outlined,
                                        color: Colors.white70,
                                      ),
                                    ),
                                    items:
                                        _vehicleColors
                                            .map<DropdownMenuItem<String>>((
                                              String value,
                                            ) {
                                              return DropdownMenuItem<String>(
                                                value: value,
                                                child: Text(value),
                                              );
                                            })
                                            .toList(),
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        _selectedVehicleColor = newValue!;
                                      });
                                    },
                                  ),
                                  const SizedBox(height: 16),

                                  DropdownButtonFormField<String>(
                                    value: _selectedVehicleType,
                                    dropdownColor: Colors.black87,
                                    style: const TextStyle(color: Colors.white),
                                    decoration: InputDecoration(
                                      labelText: 'Vehicle Type',
                                      labelStyle: TextStyle(
                                        color: Colors.white.withOpacity(0.7),
                                      ),
                                      fillColor: Colors.white.withOpacity(0.05),
                                      filled: true,
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                            vertical: 16,
                                            horizontal: 12,
                                          ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide.none,
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide.none,
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                          color: Colors.indigo.shade200,
                                          width: 1,
                                        ),
                                      ),
                                      prefixIcon: const Icon(
                                        Icons.directions_car_outlined,
                                        color: Colors.white70,
                                      ),
                                    ),
                                    items:
                                        _vehicleTypes
                                            .map<DropdownMenuItem<String>>((
                                              String value,
                                            ) {
                                              return DropdownMenuItem<String>(
                                                value: value,
                                                child: Text(value),
                                              );
                                            })
                                            .toList(),
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        _selectedVehicleType = newValue!;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),

              const SizedBox(height: 24),

              _buildAnimatedField(
                delay: 0.5,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  height: 54,
                  curve: Curves.easeInOut,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    gradient: LinearGradient(
                      colors: [
                        AppColors.primary,
                        AppColors.primary.withOpacity(0.8),
                      ],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primary.withOpacity(0.3),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _submitForm,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      disabledBackgroundColor: Colors.transparent,
                      foregroundColor: AppColors.textPrimary,
                      elevation: 0,
                      shadowColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child:
                        _isLoading
                            ? SizedBox(
                              height: 24,
                              width: 24,
                              child: CircularProgressIndicator(
                                strokeWidth: 2.5,
                                color: AppColors.textPrimary,
                              ),
                            )
                            : Text(
                              'Create Account',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0.3,
                                color: AppColors.textPrimary,
                              ),
                            ),
                  ),
                ),
              ),

              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAnimatedField({required double delay, required Widget child}) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(0, 0.1),
        end: Offset.zero,
      ).animate(
        CurvedAnimation(
          parent: _formAnimationController,
          curve: Interval(delay, delay + 0.4, curve: Curves.easeOut),
        ),
      ),
      child: FadeTransition(
        opacity: Tween<double>(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(
            parent: _formAnimationController,
            curve: Interval(delay, delay + 0.4, curve: Curves.easeOut),
          ),
        ),
        child: child,
      ),
    );
  }
}
