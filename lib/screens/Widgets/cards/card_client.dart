import 'package:flutter/material.dart';
import 'package:un_ride/appColors.dart';

class PublicationCard extends StatefulWidget {
  final String oigin;
  final String destination;
  final String description;

  const PublicationCard({
    super.key,
    required this.oigin,
    required this.destination,
    required this.description,
  });

  @override
  State<PublicationCard> createState() => _PublicationCardState();
}

class _PublicationCardState extends State<PublicationCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Card(
                color: const Color.fromARGB(255, 69, 67, 129),
                child: Card(
                  color: AppColors.iconsNavBarColor,
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
                          children: [
                            Text(
                              widget.oigin,

                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(width: 8),
                            Icon(Icons.arrow_forward_rounded),
                            SizedBox(width: 8),
                            Text(
                              // widget.oigin,
                              widget.destination,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Text(widget.description),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SizedBox(width: 8),
                            Icon(Icons.message_rounded),
                            SizedBox(width: 8),
                            Icon(Icons.favorite_rounded),
                            SizedBox(width: 8),
                            Icon(Icons.share),
                            SizedBox(width: 8),
                            Icon(Icons.pets_rounded),
                            SizedBox(width: 8),
                            Icon(Icons.chair_rounded),
                            SizedBox(width: 8),
                            Icon(Icons.luggage_rounded),
                            SizedBox(width: 8),
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
