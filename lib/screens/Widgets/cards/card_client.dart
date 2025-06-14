import 'package:flutter/material.dart';
import 'package:un_ride/appColors.dart';

class ClientPostCard extends StatefulWidget {
  final String origin;
  final String destination;
  final String? description;
  final int passengers;
  final double suggestedAmount;
  final String? travelDate;
  final String? travelTime;
  final bool allowsPets;
  final bool allowsLuggage;
  final String userName;
  final String? userAvatar;
  final bool showMenuButton;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;
  final int? postId;

  const ClientPostCard({
    super.key,
    required this.origin,
    required this.destination,
    required this.description,
    required this.passengers,
    required this.suggestedAmount,
    required this.travelDate,
    required this.travelTime,
    this.allowsPets = false,
    this.allowsLuggage = false,
    this.userName = "Usuario",
    this.userAvatar,
    this.showMenuButton = false,
    this.onEdit,
    this.onDelete,
    this.postId,
  });

  @override
  State<ClientPostCard> createState() => _ClientPostCardState();
}

class _ClientPostCardState extends State<ClientPostCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isCompact = screenWidth < 400;

    String travelDate = widget.travelDate ?? "Sin fecha";
    String description = widget.description ?? "Sin descripción";
    String travelTime = widget.travelTime ?? "Sin hora";

    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: isCompact ? 12 : 16,
        vertical: 8,
      ),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        transform: Matrix4.identity()..scale(_isHovered ? 1.02 : 1.0),
        child: Material(
          borderRadius: BorderRadius.circular(20),
          elevation: _isHovered ? 8 : 4,
          shadowColor: AppColors.primary.withOpacity(0.3),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  AppColors.cardBackground,
                  AppColors.secondaryBackground,
                ],
                stops: [0.1, 0.9],
              ),
              // Se eliminó el borde rojo
            ),
            child: MouseRegion(
              onEnter: (_) => setState(() => _isHovered = true),
              onExit: (_) => setState(() => _isHovered = false),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  padding: EdgeInsets.all(isCompact ? 16 : 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildHeader(),
                      const SizedBox(height: 16),
                      _buildRouteSection(isCompact),
                      if (description != "Sin descripción") ...[
                        const SizedBox(height: 12),
                        _buildDescription(description),
                      ],
                      const SizedBox(height: 16),
                      _buildDetailsSection(travelDate, travelTime, isCompact),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(22),
            gradient: LinearGradient(
              colors: [AppColors.primary, AppColors.accentPink],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 6,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child:
              widget.userAvatar != null
                  ? ClipRRect(
                    borderRadius: BorderRadius.circular(22),
                    child: Image.network(widget.userAvatar!, fit: BoxFit.cover),
                  )
                  : const Icon(Icons.person, color: Colors.white, size: 24),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.userName,
                style: const TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                "Conductor",
                style: TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
        if (widget.showMenuButton) ...[
          PopupMenuButton<String>(
            icon: Icon(
              Icons.more_vert,
              color: AppColors.textSecondary,
              size: 20,
            ),
            color: AppColors.cardBackground,
            onSelected: (value) {
              if (value == 'edit' && widget.onEdit != null) {
                widget.onEdit!();
              } else if (value == 'delete' && widget.onDelete != null) {
                widget.onDelete!();
              }
            },
            itemBuilder:
                (context) => [
                  PopupMenuItem(
                    value: 'edit',
                    child: Row(
                      children: [
                        Icon(Icons.edit, color: AppColors.primary, size: 18),
                        SizedBox(width: 8),
                        Text(
                          'Modificar',
                          style: TextStyle(color: AppColors.textPrimary),
                        ),
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    value: 'delete',
                    child: Row(
                      children: [
                        Icon(Icons.delete, color: Colors.red, size: 18),
                        SizedBox(width: 8),
                        Text(
                          'Eliminar',
                          style: TextStyle(color: AppColors.textPrimary),
                        ),
                      ],
                    ),
                  ),
                ],
          ),
          SizedBox(width: 8),
        ],
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(Icons.share_rounded, color: AppColors.primary, size: 20),
        ),
      ],
    );
  }

  Widget _buildRouteSection(bool isCompact) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.scaffoldBackground.withOpacity(0.3),
        borderRadius: BorderRadius.circular(16),
        // Se eliminó el borde rojo
      ),
      child: isCompact ? _buildCompactRoute() : _buildFullRoute(),
    );
  }

  Widget _buildCompactRoute() {
    return Column(
      children: [
        Row(
          children: [
            Icon(
              Icons.radio_button_checked,
              color: AppColors.primary,
              size: 16,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                widget.origin,
                style: const TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            children: [
              Container(
                width: 2,
                height: 20,
                margin: const EdgeInsets.only(left: 7),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(1),
                ),
              ),
            ],
          ),
        ),
        Row(
          children: [
            Icon(
              Icons.location_on,
              color: Colors.red,
              size: 16,
            ), // Icono de ubicación en rojo
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                widget.destination,
                style: const TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildFullRoute() {
    return Row(
      children: [
        Icon(Icons.radio_button_checked, color: AppColors.primary, size: 18),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            widget.origin,
            style: const TextStyle(
              color: AppColors.textPrimary,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          child: Icon(
            Icons.arrow_forward_rounded,
            color: AppColors.primary,
            size: 24,
          ),
        ),
        Expanded(
          child: Text(
            widget.destination,
            style: const TextStyle(
              color: AppColors.textPrimary,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.end,
          ),
        ),
        const SizedBox(width: 12),
        Icon(
          Icons.location_on,
          color: Colors.red,
          size: 18,
        ), // Icono de ubicación en rojo
      ],
    );
  }

  Widget _buildDescription(String description) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.secondaryBackground.withOpacity(0.5),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        description,
        style: TextStyle(
          color: AppColors.textSecondary,
          fontSize: 14,
          height: 1.4,
        ),
      ),
    );
  }

  Widget _buildDetailsSection(
    String travelDate,
    String travelTime,
    bool isCompact,
  ) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              flex: 2,
              child: _buildInfoGrid(travelDate, travelTime, isCompact),
            ),
            const SizedBox(width: 16),
            _buildActionSection(isCompact),
          ],
        ),
      ],
    );
  }

  Widget _buildInfoGrid(String travelDate, String travelTime, bool isCompact) {
    return Column(
      children: [
        _buildInfoItem(
          Icons.attach_money_rounded,
          "₡${widget.suggestedAmount.toStringAsFixed(0)}",
          "Precio sugerido",
        ),
        const SizedBox(height: 12),
        _buildInfoItem(Icons.calendar_today_rounded, travelDate, "Fecha"),
        const SizedBox(height: 12),
        _buildInfoItem(Icons.schedule_rounded, travelTime, "Hora"),
      ],
    );
  }

  Widget _buildInfoItem(IconData icon, String value, String label) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: AppColors.primary, size: 16),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: const TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                label,
                style: TextStyle(color: AppColors.textSecondary, fontSize: 12),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildActionSection(bool isCompact) {
    return Column(
      children: [
        Container(
          width: isCompact ? 100 : 120,
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
              padding: EdgeInsets.symmetric(
                vertical: isCompact ? 12 : 14,
                horizontal: 16,
              ),
            ),
            child: Text(
              "Postularse",
              style: TextStyle(
                fontSize: isCompact ? 12 : 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),
        _buildFeatures(isCompact),
      ],
    );
  }

  Widget _buildFeatures(bool isCompact) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.secondaryBackground.withOpacity(0.3),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildFeatureIcon(
                Icons.pets_rounded,
                widget.allowsPets,
                "Mascotas",
              ),
              SizedBox(width: 16), // Espacio adicional entre iconos
              _buildFeatureIcon(
                Icons.luggage_rounded,
                widget.allowsLuggage,
                "Equipaje",
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.person_rounded, color: AppColors.primary, size: 16),
              const SizedBox(width: 4),
              Text(
                "${widget.passengers}",
                style: const TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(width: 4),
              Text(
                "pasajeros",
                style: TextStyle(color: AppColors.textSecondary, fontSize: 12),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureIcon(IconData icon, bool isEnabled, String tooltip) {
    return Tooltip(
      message: tooltip,
      child: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color:
              isEnabled
                  ? AppColors.primary.withOpacity(0.2)
                  : AppColors.textSecondary.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          icon,
          color: isEnabled ? AppColors.primary : AppColors.textSecondary,
          size: 16,
        ),
      ),
    );
  }
}
