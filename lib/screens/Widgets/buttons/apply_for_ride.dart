import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:un_ride/appColors.dart';

class ApplyForRideButton extends StatefulWidget {
  final String? rideId;

  const ApplyForRideButton({Key? key, required this.rideId}) : super(key: key);

  @override
  _ApplyForRideButtonState createState() => _ApplyForRideButtonState();
}

class _ApplyForRideButtonState extends State<ApplyForRideButton> {
  bool _postulado = false;

  @override
  void initState() {
    super.initState();
    _loadPostuladoStatus();
  }

  Future<void> _loadPostuladoStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'postulado_${widget.rideId ?? 'unknown'}';
    final savedState = prefs.getBool(key) ?? false;
    setState(() {
      _postulado = savedState;
    });
  }

  Future<void> _savePostuladoStatus(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'postulado_${widget.rideId ?? 'unknown'}';
    await prefs.setBool(key, value);
  }

  void _handlePress() async {
    if (_postulado) {
      showDialog(
        context: context,
        builder:
            (context) => AlertDialog(
              title: Text('Cancelar postulación'),
              content: Text(
                '¿Estás seguro de que quieres cancelar tu postulación?',
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('No'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    setState(() {
                      _postulado = false;
                    });
                    _savePostuladoStatus(false);
                  },
                  child: Text('Sí, cancelar'),
                ),
              ],
            ),
      );
    } else {
      showDialog(
        context: context,
        builder:
            (context) => AlertDialog(
              title: Text('Postulación'),
              content: Text('Te has postulado exitosamente.'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('OK'),
                ),
              ],
            ),
      );

      setState(() {
        _postulado = true;
      });

      await _savePostuladoStatus(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      child: ElevatedButton(
        onPressed: _handlePress,
        style: ElevatedButton.styleFrom(
          backgroundColor: _postulado ? Colors.green : AppColors.primary,
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          padding: EdgeInsets.symmetric(vertical: 14, horizontal: 16),
        ),
        child: Text(
          _postulado ? "Postulado" : "Postularse",
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
