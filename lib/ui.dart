import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Palette {
  static const green = Color(0xFF006C46);
  static const ink = Color(0xFF17263A);
  static const muted = Color(0xFF64716F);
  static const background = Color(0xFFF7F8FD);
  static const field = Color(0xFFF4F6FB);
  static const blue = Color(0xFFEAF0FF);
  static const border = Color(0xFFD7E3DC);
}

const listingImage = 'reference_images/image2.png';
const confirmationImage = 'reference_images/image5.png';
const chatImage = 'reference_images/image6.png';

class Photo extends StatefulWidget {
  const Photo(this.asset, this.crop, {super.key, this.radius = 12});
  final String asset;
  final Rect crop;
  final double radius;

  @override
  State<Photo> createState() => _PhotoState();
}

class _PhotoState extends State<Photo> {
  static final Map<String, Future<ui.Image>> cache = {};

  Future<ui.Image> get image => cache.putIfAbsent(widget.asset, () async {
    final data = await rootBundle.load(widget.asset);
    final codec = await ui.instantiateImageCodec(data.buffer.asUint8List());
    return (await codec.getNextFrame()).image;
  });

  @override
  Widget build(BuildContext context) => ClipRRect(
    borderRadius: BorderRadius.circular(widget.radius),
    child: FutureBuilder<ui.Image>(
      future: image,
      builder: (context, snapshot) => snapshot.hasData
          ? CustomPaint(
              painter: _PhotoPainter(snapshot.data!, widget.crop),
              child: const SizedBox.expand(),
            )
          : const ColoredBox(color: Palette.blue),
    ),
  );
}

class _PhotoPainter extends CustomPainter {
  const _PhotoPainter(this.image, this.crop);
  final ui.Image image;
  final Rect crop;

  @override
  void paint(Canvas canvas, Size size) => canvas.drawImageRect(
    image,
    crop,
    Offset.zero & size,
    Paint()..filterQuality = FilterQuality.high,
  );

  @override
  bool shouldRepaint(_PhotoPainter old) =>
      image != old.image || crop != old.crop;
}

class Panel extends StatelessWidget {
  const Panel({super.key, required this.child, this.padding = 16});
  final Widget child;
  final double padding;

  @override
  Widget build(BuildContext context) => Container(
    padding: EdgeInsets.all(padding),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: Palette.border),
    ),
    child: child,
  );
}

class Heading extends StatelessWidget {
  const Heading(this.text, {super.key});
  final String text;
  @override
  Widget build(BuildContext context) => Text(
    text,
    style: const TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w800,
      color: Palette.ink,
    ),
  );
}

class ActionButton extends StatelessWidget {
  const ActionButton(
    this.text,
    this.onPressed, {
    super.key,
    this.icon = Icons.arrow_forward_rounded,
  });
  final String text;
  final VoidCallback onPressed;
  final IconData icon;
  @override
  Widget build(BuildContext context) => SizedBox(
    width: double.infinity,
    height: 52,
    child: FilledButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, size: 18),
      label: Text(text, textAlign: TextAlign.center),
      style: FilledButton.styleFrom(
        backgroundColor: Palette.green,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        textStyle: const TextStyle(fontWeight: FontWeight.w700),
      ),
    ),
  );
}

class BrandBar extends StatelessWidget {
  const BrandBar({super.key});
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 7),
    child: Row(
      children: [
        const Icon(Icons.directions_car_filled_outlined, color: Palette.green),
        const SizedBox(width: 8),
        const Text(
          'Drivo SV',
          style: TextStyle(
            color: Palette.green,
            fontSize: 20,
            fontWeight: FontWeight.w800,
          ),
        ),
        const Spacer(),
        IconButton(
          tooltip: 'Notificaciones',
          onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('No tienes notificaciones nuevas.')),
          ),
          icon: const Icon(Icons.notifications_none_rounded),
        ),
      ],
    ),
  );
}

class Car {
  const Car(
    this.name,
    this.price,
    this.place,
    this.host,
    this.rating,
    this.crop,
    this.tags,
  );
  final String name;
  final int price;
  final String place;
  final String host;
  final String rating;
  final Rect crop;
  final List<String> tags;
}

const cars = [
  Car(
    'Toyota RAV4 2023 4×4',
    48,
    'Colonia Escalón, San Salvador',
    'Carlos M.',
    '4.98',
    Rect.fromLTRB(24, 680, 558, 1015),
    ['Automática', '5 asientos', 'AC Climatizado'],
  ),
  Car(
    'Kia Picanto 2024 Hatchback',
    29,
    'Santa Elena, Antiguo Cuscatlán',
    'Andrea R.',
    '4.90',
    Rect.fromLTRB(24, 1400, 558, 1738),
    ['5.8L/100km', 'Económico', 'Gasolina'],
  ),
  Car(
    'Mazda CX-5 2022 Grand Touring',
    55,
    'San Benito / Zona Rosa',
    'Roberto',
    '4.96',
    Rect.fromLTRB(24, 2070, 558, 2340),
    ['Premium', 'Cuero', 'Sunroof'],
  ),
];
