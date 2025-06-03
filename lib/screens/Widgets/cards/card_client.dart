import 'package:flutter/material.dart';
import 'package:un_ride/appColors.dart';
import 'package:intl/intl.dart';

class ClientPostCard extends StatefulWidget {
  final String origin;
  final String destination;
  final String? description;
  final int passengers;
  final double suggestedAmount;
  final String? travelDate;
  final String? travelTime;

  const ClientPostCard({
    super.key,
    required this.origin,
    required this.destination,
    required this.description,
    required this.passengers,
    required this.suggestedAmount,
    required this.travelDate,
    required this.travelTime,
  });

  @override
  State<ClientPostCard> createState() => _ClientPostCardState();
}

class _ClientPostCardState extends State<ClientPostCard> {
  @override
  Widget build(BuildContext context) {
    String travelDate = "Sin fecha";
    String description = "Sin descripcion";
    String travelTime = "Sin Hora";

    if (widget.description != null) {
      description = widget.description!;
    }

    if (widget.travelDate != null) {
      travelDate = widget.travelDate!;
    }

    if (widget.travelTime != null) {
      travelTime = widget.travelTime!;
    }

    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Card(
                color: AppColors.cardBackground,
                child: Card(
                  color: AppColors.primaryLight,
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text("😏"), //!Aqui Va la foto
                                SizedBox(width: 8),
                                Text("Jorge Rojas"), //!nombre del vato/vata
                              ],
                            ),
                            Icon(Icons.share, color: AppColors.primary),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text(
                                  //!Origen
                                  widget.origin,

                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(width: 8),
                                Icon(
                                  Icons.arrow_forward_rounded,
                                  color: AppColors.primary,
                                ),
                                SizedBox(width: 8),
                                Text(
                                  //!Destino
                                  widget.destination,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),

                        SizedBox(height: 10),
                        Text(description),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                //!Hacer un widget pa esto luego
                                Row(
                                  children: [
                                    Icon(Icons.monetization_on_rounded),
                                    SizedBox(width: 4),
                                    Text(widget.suggestedAmount.toString()),
                                  ],
                                ),
                                SizedBox(height: 8),
                                Row(
                                  children: [
                                    Icon(Icons.calendar_month_rounded),
                                    SizedBox(width: 4),
                                    Text(travelDate),
                                  ],
                                ),
                                SizedBox(height: 8),
                                Row(
                                  children: [
                                    Icon(Icons.access_time_rounded),
                                    SizedBox(width: 4),
                                    Text(travelTime),
                                    Row(children: [
                                        
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                OutlinedButton(
                                  style: OutlinedButton.styleFrom(
                                    foregroundColor: Colors.black,
                                    side: BorderSide(
                                      color: AppColors.primary,
                                      width: 1,
                                    ),
                                  ),
                                  onPressed: () {},
                                  child: Text(
                                    "Postularse",
                                    style: TextStyle(color: AppColors.primary),
                                  ),
                                ),
                                SizedBox(height: 10),
                                Row(
                                  children: [
                                    SizedBox(width: 10),
                                    (true) //!Aqui la variable que contrle esto
                                        ? Icon(
                                          Icons.pets_rounded,
                                          color: const Color.fromARGB(
                                            //!eSTA ASI EN LO QUE SE DICEDE EL COLOR DE ESTO
                                            255,
                                            13,
                                            181,
                                            24,
                                          ),
                                        )
                                        : Icon(Icons.pets_rounded),

                                    SizedBox(width: 10),
                                    (true) //!Aqui la variable que contrle esto
                                        ? Icon(
                                          Icons.luggage_rounded,
                                          color: AppColors.primary,
                                        )
                                        : Icon(Icons.luggage_rounded),
                                    SizedBox(width: 10),
                                    Icon(
                                      Icons.person_rounded,
                                      color: const Color.fromARGB(
                                        255,
                                        13,
                                        181,
                                        24,
                                      ),
                                    ),
                                    Text(widget.passengers.toString()),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
