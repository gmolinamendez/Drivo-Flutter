import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'ui.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});
  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  bool driver = true;
  bool phone = true;

  @override
  Widget build(BuildContext context) => Scaffold(
    body: SafeArea(
      child: Column(
        children: [
          const BrandBar(),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(18, 12, 18, 28),
              children: [
                const Center(
                  child: Chip(
                    avatar: Icon(
                      Icons.verified_user_outlined,
                      color: Palette.green,
                      size: 17,
                    ),
                    label: Text('Car sharing en El Salvador'),
                    backgroundColor: Palette.blue,
                    side: BorderSide.none,
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  'El Airbnb de autos en El Salvador.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30,
                    height: 1.12,
                    fontWeight: FontWeight.w900,
                    color: Palette.ink,
                  ),
                ),
                const SizedBox(height: 14),
                const Text(
                  'Alquila o comparte tu vehículo sin filas ni papeleo. Conectamos conductores y anfitriones en El Salvador, Santa Elena y Escalón con seguro incluido.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    height: 1.4,
                    color: Palette.muted,
                  ),
                ),
                const SizedBox(height: 28),
                const Text(
                  'Elige cómo deseas comenzar hoy',
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 9),
                _role(
                  true,
                  Icons.directions_car_outlined,
                  'Quiero Rentar un Auto (Driver)',
                  'Encuentra autos listos para conducir cerca de ti sin trámites engorrosos ni depósitos excesivos.',
                  'Reserva en minutos • Entrega express',
                  'Popular',
                ),
                const SizedBox(height: 12),
                _role(
                  false,
                  Icons.key_outlined,
                  'Quiero Publicar mi Auto (Host)',
                  'Convierte tu vehículo en ingresos extra seguros con cobertura contra todo riesgo.',
                  'Cobertura total asegurada por Drivo SV',
                  'Gana hasta \$800/mes',
                ),
                const SizedBox(height: 20),
                Panel(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Heading('Acceso rápido seguro'),
                      const Text(
                        'Ingresa tu número de teléfono salvadoreño o correo registrado.',
                        style: TextStyle(fontSize: 12, color: Palette.muted),
                      ),
                      const SizedBox(height: 14),
                      SegmentedButton<bool>(
                        segments: const [
                          ButtonSegment(
                            value: true,
                            label: Text('Teléfono (+503)'),
                          ),
                          ButtonSegment(
                            value: false,
                            label: Text('Correo electrónico'),
                          ),
                        ],
                        selected: {phone},
                        showSelectedIcon: false,
                        onSelectionChanged: (value) =>
                            setState(() => phone = value.first),
                      ),
                      const SizedBox(height: 14),
                      Text(
                        phone ? 'Número de Teléfono' : 'Correo electrónico',
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 5),
                      TextField(
                        keyboardType: phone
                            ? TextInputType.phone
                            : TextInputType.emailAddress,
                        decoration: InputDecoration(
                          prefixText: phone ? '+503  ' : null,
                          hintText: phone ? '7000-0000' : 'nombre@correo.com',
                        ),
                      ),
                      const SizedBox(height: 14),
                      ActionButton(
                        driver
                            ? 'Continuar como Driver'
                            : 'Continuar como Host',
                        () {
                          if (driver) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const ExploreScreen(),
                              ),
                            );
                          } else {
                            _notice(
                              'La experiencia Host no forma parte de estas seis pantallas.',
                            );
                          }
                        },
                      ),
                      const SizedBox(height: 16),
                      const Center(
                        child: Text(
                          'O CONTINÚA CON',
                          style: TextStyle(fontSize: 10, letterSpacing: 1),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton(
                              onPressed: () => _notice(
                                'Google no está conectado en esta demo.',
                              ),
                              child: const Text('Google'),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: OutlinedButton(
                              onPressed: () => _notice(
                                'Apple ID no está conectado en esta demo.',
                              ),
                              child: const Text('Apple ID'),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                const Panel(
                  child: Row(
                    children: [
                      Icon(Icons.verified_outlined, color: Palette.green),
                      SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          '100% verificado y asegurado por Drivo SV • Sin cargos sorpresa ni trámites presenciales.',
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                const Center(
                  child: Text(
                    'San Salvador  •  Santa Elena  •  Colonia Escalón',
                    style: TextStyle(fontSize: 11, color: Palette.muted),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );

  Widget _role(
    bool value,
    IconData icon,
    String title,
    String description,
    String foot,
    String badge,
  ) {
    final selected = driver == value;
    return InkWell(
      onTap: () => setState(() => driver = value),
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: selected ? Palette.green : Palette.border,
            width: selected ? 2 : 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(11),
                  decoration: BoxDecoration(
                    color: selected ? const Color(0xFFE4F2EA) : Palette.blue,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(icon, color: Palette.green),
                ),
                const Spacer(),
                Chip(
                  label: Text(badge, style: const TextStyle(fontSize: 10)),
                  backgroundColor: selected
                      ? const Color(0xFFDDF4E9)
                      : const Color(0xFFFFE6CE),
                  side: BorderSide.none,
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Icon(
                  selected
                      ? Icons.radio_button_checked
                      : Icons.radio_button_unchecked,
                  color: selected ? Palette.green : Palette.border,
                ),
              ],
            ),
            const SizedBox(height: 6),
            Text(
              description,
              style: const TextStyle(color: Palette.muted, height: 1.35),
            ),
            const Divider(height: 24),
            Text(
              foot,
              style: TextStyle(
                color: selected ? Palette.green : Palette.ink,
                fontWeight: FontWeight.w700,
                fontSize: 11,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _notice(String message) =>
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(message)));
}

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});
  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  String place = 'San Salvador, Santa Elena, Escalón';
  final filters = <String>{};

  @override
  Widget build(BuildContext context) => Scaffold(
    body: SafeArea(
      child: Column(
        children: [
          const BrandBar(),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(18, 12, 18, 22),
              children: [
                Panel(
                  child: Column(
                    children: [
                      InkWell(
                        onTap: _choosePlace,
                        child: Container(
                          padding: const EdgeInsets.all(13),
                          decoration: BoxDecoration(
                            color: Palette.blue,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.location_on_outlined,
                                color: Palette.green,
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Ubicación de entrega',
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: Palette.muted,
                                      ),
                                    ),
                                    Text(
                                      place,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const Icon(Icons.tune_rounded),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 9),
                      Row(
                        children: [
                          Expanded(
                            child: _dateCell(
                              Icons.calendar_today_outlined,
                              'Entrega',
                              'Hoy, 2:00 PM',
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: _dateCell(
                              Icons.event_repeat_outlined,
                              'Devolución',
                              'Dom, 6:00 PM',
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      for (final name in [
                        'SUV',
                        'Económico',
                        'Transmisión Automática',
                      ])
                        Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: FilterChip(
                            label: Text(name),
                            selected: filters.contains(name),
                            onSelected: (selected) => setState(
                              () => selected
                                  ? filters.add(name)
                                  : filters.remove(name),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                const SizedBox(height: 13),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE6F0FF),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.bolt_rounded, color: Palette.green, size: 28),
                      SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '3 vehículos listos para entrega hoy en tu zona',
                              style: TextStyle(fontWeight: FontWeight.w800),
                            ),
                            Text(
                              'Sin esperas • Desbloqueo digital verificado en San Salvador',
                              style: TextStyle(
                                fontSize: 11,
                                color: Palette.muted,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 22),
                const Row(
                  children: [
                    Expanded(child: Heading('Disponibles ahora')),
                    Text(
                      'Orden: Proximidad',
                      style: TextStyle(
                        fontSize: 11,
                        color: Palette.green,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                for (final car in cars)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: _carCard(car),
                  ),
              ],
            ),
          ),
        ],
      ),
    ),
    bottomNavigationBar: NavigationBar(
      selectedIndex: 0,
      onDestinationSelected: (index) {
        if (index == 1) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const ConfirmationScreen()),
          );
        }
        if (index == 2) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const ChatScreen()),
          );
        }
        if (index == 3) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Perfil no incluido en estas seis pantallas.'),
            ),
          );
        }
      },
      destinations: const [
        NavigationDestination(icon: Icon(Icons.search), label: 'Explorar'),
        NavigationDestination(icon: Icon(Icons.key_outlined), label: 'Viajes'),
        NavigationDestination(
          icon: Icon(Icons.chat_bubble_outline),
          label: 'Mensajes',
        ),
        NavigationDestination(
          icon: Icon(Icons.person_outline),
          label: 'Perfil',
        ),
      ],
    ),
  );

  Widget _dateCell(IconData icon, String label, String value) => InkWell(
    onTap: () async {
      final range = await showDateRangePicker(
        context: context,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(const Duration(days: 365)),
      );
      if (range != null && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Fechas: ${range.start.day}/${range.start.month} – ${range.end.day}/${range.end.month}',
            ),
          ),
        );
      }
    },
    child: Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Palette.blue,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(icon, color: Palette.green, size: 19),
          const SizedBox(width: 7),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(fontSize: 10, color: Palette.muted),
                ),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );

  Widget _carCard(Car car) => Panel(
    padding: 0,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 195,
          width: double.infinity,
          child: Photo(listingImage, car.crop, radius: 15),
        ),
        Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      car.name,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        color: Palette.ink,
                      ),
                    ),
                  ),
                  Text(
                    '\$${car.price}',
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w900,
                      color: Palette.green,
                    ),
                  ),
                ],
              ),
              Text(
                '⌖  ${car.place}',
                style: const TextStyle(color: Palette.muted, fontSize: 12),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 5,
                runSpacing: 5,
                children: [
                  for (final tag in car.tags)
                    Chip(
                      label: Text(tag, style: const TextStyle(fontSize: 10)),
                      backgroundColor: Palette.blue,
                      side: BorderSide.none,
                      visualDensity: VisualDensity.compact,
                    ),
                ],
              ),
              const Divider(),
              Row(
                children: [
                  const CircleAvatar(
                    backgroundColor: Palette.blue,
                    child: Icon(Icons.person, color: Palette.green),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          car.host,
                          style: const TextStyle(fontWeight: FontWeight.w700),
                        ),
                        Text(
                          '★ ${car.rating} • Host verificado',
                          style: const TextStyle(
                            fontSize: 10,
                            color: Palette.muted,
                          ),
                        ),
                      ],
                    ),
                  ),
                  FilledButton(
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => DetailScreen(car: car)),
                    ),
                    child: const Text('Ver detalles'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );

  void _choosePlace() => showModalBottomSheet<void>(
    context: context,
    builder: (sheetContext) => SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const ListTile(
            title: Text(
              'Ubicación de entrega',
              style: TextStyle(fontWeight: FontWeight.w800),
            ),
          ),
          for (final city in ['San Salvador', 'Santa Elena', 'Colonia Escalón'])
            ListTile(
              leading: const Icon(Icons.location_on_outlined),
              title: Text(city),
              onTap: () {
                setState(() => place = city);
                Navigator.pop(sheetContext);
              },
            ),
        ],
      ),
    ),
  );
}

class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key, required this.car});
  final Car car;
  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  bool homeDelivery = false;

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: const Text(
        'Drivo SV',
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
      ),
    ),
    body: ListView(
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 24),
      children: [
        SizedBox(height: 235, child: Photo(listingImage, widget.car.crop)),
        const SizedBox(height: 14),
        Panel(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Heading(widget.car.name),
              Text(
                '★ ${widget.car.rating} • 42 viajes completados • Excelente estado',
                style: const TextStyle(fontSize: 11, color: Palette.muted),
              ),
              const SizedBox(height: 10),
              Text(
                '\$${widget.car.price} / día',
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w900,
                  color: Palette.green,
                ),
              ),
              const Text(
                'Sin depósitos sorpresa',
                style: TextStyle(fontSize: 11, color: Palette.muted),
              ),
            ],
          ),
        ),
        const SizedBox(height: 19),
        const Heading('Especificaciones del vehículo'),
        const SizedBox(height: 9),
        GridView.count(
          crossAxisCount: 2,
          childAspectRatio: 2.5,
          mainAxisSpacing: 7,
          crossAxisSpacing: 7,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: const [
            _Spec(Icons.settings_outlined, 'Transmisión', 'Automática'),
            _Spec(
              Icons.airline_seat_recline_normal,
              'Capacidad',
              '5 pasajeros',
            ),
            _Spec(
              Icons.local_gas_station_outlined,
              'Combustible',
              'Gasolina regular',
            ),
            _Spec(Icons.all_inclusive, 'Beneficio', 'Kilometraje ilimitado'),
            _Spec(Icons.ac_unit, 'Climatización', 'AC Dual Zone'),
            _Spec(Icons.bluetooth, 'Conectividad', 'CarPlay / BT'),
          ],
        ),
        const SizedBox(height: 16),
        Panel(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'CONOCE A TU ANFITRIÓN',
                style: TextStyle(
                  fontSize: 10,
                  letterSpacing: 1,
                  color: Palette.muted,
                ),
              ),
              const SizedBox(height: 10),
              const Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Palette.blue,
                    child: Icon(Icons.person, color: Palette.green),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Carlos Mendoza',
                          style: TextStyle(fontWeight: FontWeight.w800),
                        ),
                        Text(
                          '★ 4.98 • 42 viajes completados',
                          style: TextStyle(fontSize: 11, color: Palette.muted),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const ChatScreen()),
                  ),
                  icon: const Icon(Icons.chat_bubble_outline),
                  label: const Text('Contactar anfitrión'),
                ),
              ),
              const Text(
                'Identidad y seguro verificados por Drivo SV',
                style: TextStyle(fontSize: 11, color: Palette.muted),
              ),
            ],
          ),
        ),
        const SizedBox(height: 18),
        const Heading('Ubicación de entrega'),
        const SizedBox(height: 9),
        Panel(
          child: Column(
            children: [
              const SizedBox(
                height: 130,
                width: double.infinity,
                child: Photo(
                  confirmationImage,
                  Rect.fromLTRB(50, 1395, 532, 1590),
                ),
              ),
              const SizedBox(height: 10),
              _delivery(
                false,
                'Punto de encuentro fijo',
                'Galerías Escalón o Plaza Futura • gratis',
              ),
              _delivery(
                true,
                'Entrega a domicilio / Hotel',
                'San Salvador o Santa Tecla • +\$10',
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Panel(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Heading('Selecciona las fechas de tu viaje'),
              const Text(
                'Mínimo de reserva: 2 días',
                style: TextStyle(fontSize: 11, color: Palette.muted),
              ),
              const SizedBox(height: 10),
              OutlinedButton.icon(
                onPressed: () async {
                  final range = await showDateRangePicker(
                    context: context,
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(const Duration(days: 365)),
                  );
                  if (range != null && context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Fechas elegidas para esta demo.'),
                      ),
                    );
                  }
                },
                icon: const Icon(Icons.calendar_month_outlined),
                label: const Text('24 Oct — 27 Oct (3 días)'),
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.all(11),
                decoration: BoxDecoration(
                  color: Palette.blue,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.calendar_today_outlined,
                      color: Palette.green,
                    ),
                    const SizedBox(width: 8),
                    const Expanded(
                      child: Text(
                        '24 Oct — 27 Oct • 3 días',
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                    ),
                    Text(
                      '\$${widget.car.price * 3}',
                      style: const TextStyle(
                        color: Palette.green,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                '✓ Cancelación gratis hasta 24 horas antes de la entrega',
                style: TextStyle(fontSize: 11),
              ),
              const Text(
                '✓ Seguro contra colisión y asistencia vial 24/7',
                style: TextStyle(fontSize: 11),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        const Panel(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Reglas de uso del anfitrión',
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
              SizedBox(height: 8),
              Text(
                '• Vehículo libre de humo\n• Se aceptan mascotas con manta protectora\n• Devolver con el mismo nivel de combustible\n• Licencia de conducir vigente',
                style: TextStyle(height: 1.5, fontSize: 11),
              ),
            ],
          ),
        ),
      ],
    ),
    bottomNavigationBar: SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '\$${widget.car.price * 3}',
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const Text(
                    'Total final transparente',
                    style: TextStyle(fontSize: 10, color: Palette.muted),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ActionButton(
                'Continuar a Checkout',
                () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => CheckoutScreen(
                      car: widget.car,
                      homeDelivery: homeDelivery,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );

  Widget _delivery(bool value, String title, String subtitle) => InkWell(
    onTap: () => setState(() => homeDelivery = value),
    child: Container(
      margin: const EdgeInsets.only(bottom: 7),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(
          color: homeDelivery == value ? Palette.green : Palette.border,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Icon(
            homeDelivery == value
                ? Icons.radio_button_checked
                : Icons.radio_button_unchecked,
            color: Palette.green,
            size: 19,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  subtitle,
                  style: const TextStyle(fontSize: 10, color: Palette.muted),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

class _Spec extends StatelessWidget {
  const _Spec(this.icon, this.label, this.value);
  final IconData icon;
  final String label;
  final String value;
  @override
  Widget build(BuildContext context) => Panel(
    padding: 8,
    child: Row(
      children: [
        Icon(icon, color: Palette.green, size: 19),
        const SizedBox(width: 7),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label.toUpperCase(),
                maxLines: 1,
                style: const TextStyle(fontSize: 8, color: Palette.muted),
              ),
              Text(
                value,
                maxLines: 2,
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({
    super.key,
    required this.car,
    required this.homeDelivery,
  });
  final Car car;
  final bool homeDelivery;
  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  String payment = 'Tarjeta Crédito/Débito';
  bool terms = true;
  bool hold = true;
  double get total =>
      widget.car.price * 3 + 12.50 + 18 + (widget.homeDelivery ? 10 : 0);

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: const Text('Confirmar y Pagar'),
      actions: const [
        Padding(
          padding: EdgeInsets.only(right: 12),
          child: Chip(label: Text('Seguro')),
        ),
      ],
    ),
    body: ListView(
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 18),
      children: [
        Panel(
          child: Row(
            children: [
              SizedBox(
                width: 80,
                height: 65,
                child: Photo(listingImage, widget.car.crop, radius: 8),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'VEHÍCULO SEGURO',
                      style: TextStyle(
                        color: Palette.green,
                        fontSize: 10,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    Text(
                      widget.car.name,
                      style: const TextStyle(fontWeight: FontWeight.w800),
                    ),
                    const Text(
                      '24 – 27 Oct (3 días) • Colonia Escalón',
                      style: TextStyle(fontSize: 10, color: Palette.muted),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 15),
        Panel(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                children: [
                  Icon(Icons.person_outline, color: Palette.green),
                  SizedBox(width: 8),
                  Expanded(child: Heading('Datos del Conductor')),
                  Icon(Icons.verified, color: Palette.green),
                ],
              ),
              const SizedBox(height: 14),
              _field('Nombre completo', 'Rodrigo Antonio Méndez'),
              _field('Teléfono (+503 El Salvador)', '+503 7890-4421'),
              _field(
                'Número de Licencia de Conducir (VMT SV)',
                '0614-220994-102-3',
              ),
              const Text(
                'El vehículo solo puede ser conducido por el titular registrado ante Drivo SV.',
                style: TextStyle(fontSize: 10, color: Palette.muted),
              ),
            ],
          ),
        ),
        const SizedBox(height: 15),
        Panel(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                children: [
                  Icon(Icons.payments_outlined, color: Palette.green),
                  SizedBox(width: 8),
                  Heading('Método de Pago'),
                ],
              ),
              const SizedBox(height: 12),
              RadioGroup<String>(
                groupValue: payment,
                onChanged: (value) => setState(() => payment = value!),
                child: Column(
                  children: [
                    for (final option in [
                      'Tarjeta Crédito/Débito',
                      'Chivo Wallet / BTC',
                      'Apple Pay',
                    ])
                      RadioListTile<String>(
                        title: Text(
                          option,
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        subtitle: Text(
                          option == 'Tarjeta Crédito/Débito'
                              ? 'Visa, Mastercard'
                              : option == 'Chivo Wallet / BTC'
                              ? 'Red Lightning & On-chain'
                              : 'Pago en 1 toque',
                          style: const TextStyle(fontSize: 10),
                        ),
                        value: option,
                        contentPadding: EdgeInsets.zero,
                      ),
                  ],
                ),
              ),
              if (payment == 'Tarjeta Crédito/Débito') ...[
                const Divider(),
                const Text(
                  'Datos de ejemplo. No introduzcas una tarjeta real.',
                  style: TextStyle(fontSize: 10, color: Palette.muted),
                ),
                const SizedBox(height: 8),
                _field(
                  'Número de Tarjeta',
                  '4000 1234 5678 9100',
                  readOnly: true,
                ),
                Row(
                  children: [
                    Expanded(
                      child: _field('Vencimiento', 'MM/AA', readOnly: true),
                    ),
                    const SizedBox(width: 8),
                    Expanded(child: _field('CVC / CVV', '•••', readOnly: true)),
                  ],
                ),
                _field(
                  'Nombre en la tarjeta',
                  'RODRIGO A MENDEZ',
                  readOnly: true,
                ),
              ],
            ],
          ),
        ),
        const SizedBox(height: 15),
        Panel(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                children: [
                  Icon(Icons.receipt_long_outlined, color: Palette.green),
                  SizedBox(width: 8),
                  Heading('Desglose del precio'),
                ],
              ),
              const SizedBox(height: 12),
              _price(
                'Renta (3 días × \$${widget.car.price}.00)',
                widget.car.price * 3,
              ),
              _price('Tarifa de servicio Drivo SV', 12.50),
              _price('Seguro de cobertura total SV', 18),
              if (widget.homeDelivery) _price('Entrega a domicilio', 10),
              const Divider(),
              _price('Depósito reembolsable en garantía', 100),
              const Text(
                'Se devuelve tras la inspección.',
                style: TextStyle(fontSize: 10, color: Palette.muted),
              ),
              const Divider(height: 25),
              Row(
                children: [
                  const Expanded(
                    child: Text(
                      'Total a pagar hoy',
                      style: TextStyle(fontWeight: FontWeight.w800),
                    ),
                  ),
                  Text(
                    '\$${total.toStringAsFixed(2)}',
                    style: const TextStyle(
                      color: Palette.green,
                      fontSize: 21,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        CheckboxListTile(
          value: terms,
          onChanged: (value) => setState(() => terms = value ?? false),
          title: const Text(
            'Acepto las Políticas de Cancelación y los Términos de Servicio de Drivo SV.',
            style: TextStyle(fontSize: 11),
          ),
          controlAffinity: ListTileControlAffinity.leading,
          contentPadding: EdgeInsets.zero,
        ),
        CheckboxListTile(
          value: hold,
          onChanged: (value) => setState(() => hold = value ?? false),
          title: const Text(
            'Autorizo la retención temporal de garantía de \$100.00 USD.',
            style: TextStyle(fontSize: 11),
          ),
          controlAffinity: ListTileControlAffinity.leading,
          contentPadding: EdgeInsets.zero,
        ),
      ],
    ),
    bottomNavigationBar: SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: ActionButton(
          'Pagar \$${total.toStringAsFixed(2)} y Reservar',
          _confirm,
          icon: Icons.lock_outline,
        ),
      ),
    ),
  );

  Widget _field(String label, String value, {bool readOnly = false}) => Padding(
    padding: const EdgeInsets.only(bottom: 10),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 11),
        ),
        const SizedBox(height: 4),
        TextFormField(
          initialValue: value,
          readOnly: readOnly,
          decoration: const InputDecoration(isDense: true),
        ),
      ],
    ),
  );

  Widget _price(String label, num amount) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(
      children: [
        Expanded(child: Text(label, style: const TextStyle(fontSize: 11))),
        Text(
          '\$${amount.toStringAsFixed(2)}',
          style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 11),
        ),
      ],
    ),
  );

  void _confirm() {
    if (!terms || !hold) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Acepta ambas condiciones para continuar.'),
        ),
      );
      return;
    }
    showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Reserva de demostración'),
        content: const Text(
          'Esta app no procesa pagos ni retiene depósitos. Se mostrará una confirmación de ejemplo.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancelar'),
          ),
          FilledButton(
            onPressed: () {
              Navigator.pop(dialogContext);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ConfirmationScreen()),
              );
            },
            child: const Text('Continuar'),
          ),
        ],
      ),
    );
  }
}

class ConfirmationScreen extends StatelessWidget {
  const ConfirmationScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: const Text(
        'Drivo SV',
        style: TextStyle(color: Palette.green, fontWeight: FontWeight.w800),
      ),
    ),
    body: ListView(
      padding: const EdgeInsets.fromLTRB(18, 10, 18, 22),
      children: [
        const Center(
          child: Icon(
            Icons.check_circle_rounded,
            color: Color(0xFF7DE0B8),
            size: 82,
          ),
        ),
        const SizedBox(height: 8),
        const Center(
          child: Chip(
            label: Text('Confirmación Inmediata'),
            backgroundColor: Color(0xFF87F4BE),
            side: BorderSide.none,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          '¡Reserva Confirmada!',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w900,
            color: Palette.ink,
          ),
        ),
        const Text(
          'Tu vehículo está reservado y garantizado. Todo el proceso de entrega está coordinado.',
          textAlign: TextAlign.center,
          style: TextStyle(color: Palette.muted),
        ),
        const SizedBox(height: 17),
        Panel(
          child: Row(
            children: [
              const Text(
                'Código de reserva: ',
                style: TextStyle(color: Palette.muted, fontSize: 12),
              ),
              const Expanded(
                child: Text(
                  'DRV-SV-84920',
                  style: TextStyle(fontWeight: FontWeight.w900, fontSize: 15),
                ),
              ),
              IconButton(
                tooltip: 'Copiar código',
                onPressed: () {
                  Clipboard.setData(const ClipboardData(text: 'DRV-SV-84920'));
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Código copiado.')),
                  );
                },
                icon: const Icon(Icons.copy_outlined, color: Palette.green),
              ),
            ],
          ),
        ),
        const SizedBox(height: 17),
        Panel(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Heading('¡Todo listo para tu viaje!'),
              const Divider(height: 22),
              const Row(
                children: [
                  SizedBox(
                    width: 100,
                    height: 74,
                    child: Photo(
                      listingImage,
                      Rect.fromLTRB(24, 680, 558, 1015),
                      radius: 9,
                    ),
                  ),
                  SizedBox(width: 11),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Toyota RAV4 Limited',
                          style: TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 15,
                          ),
                        ),
                        Text(
                          'SUV Familiar • Gasolina • Automática',
                          style: TextStyle(fontSize: 11, color: Palette.muted),
                        ),
                        Text(
                          '5 plazas • Seguro Total',
                          style: TextStyle(fontSize: 11, color: Palette.green),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 17),
        Panel(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Heading('Detalles de Entrega y Devolución'),
              const SizedBox(height: 11),
              _dateBox(
                'RECOGIDA DEL VEHÍCULO',
                'Jueves 24 de Octubre',
                '2:00 PM',
              ),
              const SizedBox(height: 8),
              _dateBox('DEVOLUCIÓN', 'Domingo 27 de Octubre', '6:00 PM'),
              const Divider(height: 26),
              const Text(
                'Punto de Entrega Acordado',
                style: TextStyle(
                  color: Palette.green,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const Text(
                'Estacionamiento Centro Comercial Galerías Escalón',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
              ),
              const Text(
                'Nivel 1 (Frente a Starbucks Coffee) • San Salvador',
                style: TextStyle(fontSize: 11, color: Palette.muted),
              ),
              const SizedBox(height: 9),
              const SizedBox(
                height: 170,
                width: double.infinity,
                child: Photo(
                  confirmationImage,
                  Rect.fromLTRB(50, 1395, 532, 1590),
                ),
              ),
              const SizedBox(height: 8),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: () => showDialog<void>(
                    context: context,
                    builder: (dialogContext) => AlertDialog(
                      title: const Text('Punto de entrega'),
                      content: const Text(
                        'Galerías Escalón, nivel 1, frente a Starbucks Coffee, San Salvador.',
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(dialogContext),
                          child: const Text('Cerrar'),
                        ),
                      ],
                    ),
                  ),
                  icon: const Icon(Icons.navigation_outlined),
                  label: const Text('Abrir en Waze / Google Maps'),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 17),
        const Panel(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'TU ANFITRIÓN DRIVO',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: Palette.muted,
                ),
              ),
              SizedBox(height: 9),
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Palette.blue,
                    child: Icon(Icons.person, color: Palette.green),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Carlos Mendoza',
                          style: TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          '★ 4.98 • 64 viajes completados',
                          style: TextStyle(color: Palette.muted, fontSize: 11),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 11),
              Text(
                '“¡Hola! Tu vehículo estará limpio y con tanque lleno para que tu viaje comience sin ninguna demora.”',
                style: TextStyle(
                  fontStyle: FontStyle.italic,
                  color: Palette.muted,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 17),
        const Panel(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Heading('Recomendaciones para el retiro del auto'),
              SizedBox(height: 10),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Icon(Icons.camera_alt_outlined, color: Palette.green),
                title: Text('Inspección fotográfica'),
                subtitle: Text(
                  'Toma fotos de los 4 ángulos del auto y odómetro antes de encenderlo.',
                ),
              ),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Icon(Icons.badge_outlined, color: Palette.green),
                title: Text('Licencia física obligatoria'),
                subtitle: Text(
                  'Presenta tu licencia vigente al recibir la llave.',
                ),
              ),
            ],
          ),
        ),
      ],
    ),
    bottomNavigationBar: SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ActionButton(
              'Contactar al Dueño por Chat',
              () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ChatScreen()),
              ),
              icon: Icons.chat_bubble_outline,
            ),
            const SizedBox(height: 5),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () => showModalBottomSheet<void>(
                  context: context,
                  builder: (context) => const SafeArea(
                    child: Padding(
                      padding: EdgeInsets.all(24),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Heading('Comprobante Digital'),
                          SizedBox(height: 10),
                          Text('Reserva DRV-SV-84920'),
                          Text('Toyota RAV4 2023 • 24–27 de octubre'),
                          Text('Total de ejemplo: \$174.50'),
                          SizedBox(height: 10),
                          Text(
                            'Documento de demostración; no constituye contrato real.',
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                icon: const Icon(Icons.description_outlined),
                label: const Text('Ver Comprobante Digital & Contrato'),
              ),
            ),
          ],
        ),
      ),
    ),
  );

  Widget _dateBox(String label, String date, String time) => Container(
    width: double.infinity,
    padding: const EdgeInsets.all(13),
    decoration: BoxDecoration(
      color: Palette.blue,
      borderRadius: BorderRadius.circular(12),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Palette.green,
            fontWeight: FontWeight.w800,
            fontSize: 11,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          date,
          style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
        ),
        Text(time, style: const TextStyle(color: Palette.muted)),
      ],
    ),
  );
}

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});
  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final controller = TextEditingController();
  final scroll = ScrollController();
  final messages = <String>[];

  @override
  void dispose() {
    controller.dispose();
    scroll.dispose();
    super.dispose();
  }

  void send([String? quick]) {
    final text = (quick ?? controller.text).trim();
    if (text.isEmpty) return;
    setState(() {
      messages.add(text);
      controller.clear();
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (scroll.hasClients) {
        scroll.animateTo(
          scroll.position.maxScrollExtent,
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      titleSpacing: 0,
      title: const Row(
        children: [
          CircleAvatar(
            backgroundColor: Palette.blue,
            child: Icon(Icons.person, color: Palette.green),
          ),
          SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Carlos Mendoza',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
                ),
                Text(
                  'Toyota RAV4 • P-829144',
                  style: TextStyle(fontSize: 11, color: Palette.muted),
                ),
              ],
            ),
          ),
        ],
      ),
      actions: [
        IconButton(
          onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Llamadas no conectadas en esta demo.'),
            ),
          ),
          icon: const Icon(Icons.call_outlined),
        ),
      ],
    ),
    body: SafeArea(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
            color: Palette.blue,
            child: Row(
              children: [
                const Icon(Icons.access_time_filled, color: Palette.green),
                const SizedBox(width: 9),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Entrega hoy 2:00 PM',
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                      Text(
                        'Galerías Escalón',
                        style: TextStyle(color: Palette.muted),
                      ),
                    ],
                  ),
                ),
                OutlinedButton(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const ConfirmationScreen(),
                    ),
                  ),
                  child: const Text('Ver reserva'),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              controller: scroll,
              padding: const EdgeInsets.all(16),
              children: [
                const Center(
                  child: Chip(
                    label: Text('Hoy, 18 de Octubre'),
                    backgroundColor: Palette.blue,
                    side: BorderSide.none,
                  ),
                ),
                const SizedBox(height: 12),
                const Panel(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Drivo SV Protección',
                        style: TextStyle(
                          color: Palette.green,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      SizedBox(height: 6),
                      Text(
                        'Reserva confirmada #DRV-SV-84920. El seguro Drivo SV ya está activo para este viaje.',
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                const _Bubble(
                  '¡Hola Rodrigo! Bienvenido a El Salvador. Ya tengo la Toyota RAV4 lavada, tanque lleno y lista para entregártela hoy a las 2:00 PM.',
                  '1:28 PM',
                ),
                const SizedBox(height: 12),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    width: 300,
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Palette.border),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 180,
                          width: double.infinity,
                          child: Photo(
                            chatImage,
                            Rect.fromLTRB(86, 590, 435, 835),
                          ),
                        ),
                        SizedBox(height: 7),
                        Text('Vehículo listo e inspeccionado'),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                const _Bubble(
                  'Te espero en el sótano 1, justo frente al acceso de Starbucks. Si llegas antes me avisas por acá 👍',
                  '1:31 PM',
                ),
                const SizedBox(height: 12),
                const _Bubble(
                  '¡Excelente Carlos, muchas gracias! Voy en camino, calculo llegar a la 1:50 PM.',
                  '1:35 PM',
                  sent: true,
                ),
                const SizedBox(height: 12),
                const _Bubble(
                  'Perfecto, aquí te espero con las llaves y la hoja de inspección lista en la app.',
                  '1:36 PM',
                ),
                for (final message in messages)
                  Padding(
                    padding: const EdgeInsets.only(top: 12),
                    child: _Bubble(message, 'Ahora', sent: true),
                  ),
                const SizedBox(height: 14),
                OutlinedButton.icon(
                  onPressed: () => showModalBottomSheet<void>(
                    context: context,
                    builder: (context) => const SafeArea(
                      child: Padding(
                        padding: EdgeInsets.all(24),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Heading('Hoja de Entrega Digital'),
                            SizedBox(height: 10),
                            Text(
                              'Inspección fotográfica de los 4 ángulos, odómetro y nivel de combustible.',
                            ),
                            Text(
                              'Disponible cuando el anfitrión registre la entrega.',
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  icon: const Icon(Icons.fact_check_outlined),
                  label: const Text('Revisar Hoja de Entrega Digital'),
                ),
              ],
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              children: [
                for (final reply in [
                  'Ya estoy aquí',
                  'Retraso de 5 min',
                  'Listo para inspección',
                ])
                  Padding(
                    padding: const EdgeInsets.only(right: 6),
                    child: ActionChip(
                      label: Text(reply),
                      onPressed: () => send(reply),
                    ),
                  ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 2, 12, 10),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller,
                    onSubmitted: (_) => send(),
                    decoration: const InputDecoration(
                      hintText: 'Escribe un mensaje a Carlos…',
                      isDense: true,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton.filled(
                  onPressed: send,
                  tooltip: 'Enviar mensaje',
                  icon: const Icon(Icons.send_rounded),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

class _Bubble extends StatelessWidget {
  const _Bubble(this.message, this.time, {this.sent = false});
  final String message;
  final String time;
  final bool sent;
  @override
  Widget build(BuildContext context) => Align(
    alignment: sent ? Alignment.centerRight : Alignment.centerLeft,
    child: Container(
      constraints: BoxConstraints(
        maxWidth: MediaQuery.sizeOf(context).width * .8,
      ),
      padding: const EdgeInsets.all(13),
      decoration: BoxDecoration(
        color: sent ? Palette.green : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: sent ? null : Border.all(color: Palette.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            message,
            style: TextStyle(
              color: sent ? Colors.white : Palette.ink,
              height: 1.35,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            time,
            style: TextStyle(
              color: sent ? Colors.white70 : Palette.muted,
              fontSize: 10,
            ),
          ),
        ],
      ),
    ),
  );
}
