import 'package:blur/blur.dart';
import 'package:d_view/d_view.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:weather_forecast/api/urls.dart';
import 'package:weather_forecast/data/models/weather.dart';

class ItemLocation extends StatelessWidget {
  const ItemLocation({
    super.key,
    required this.weather,
    this.onDismissed,
    this.onTap,
  });
  final Weather weather;
  final void Function(DismissDirection direction)? onDismissed;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Dismissible(
        key: UniqueKey(),
        direction: DismissDirection.endToStart,
        dismissThresholds: const {
          DismissDirection.endToStart: 0.5,
        },
        background: Align(
          alignment: Alignment.centerRight,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            height: 50,
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.only(right: 20),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.keyboard_double_arrow_left_rounded,
                ),
                DView.width(8),
                const Text(
                  'Remove',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
        ),
        onDismissed: onDismissed,
        child: Stack(
          children: [
            Positioned.fill(
              child: Container().frosted(
                blur: 2,
                borderRadius: BorderRadius.circular(20),
                frostColor: Colors.blueGrey,
                frostOpacity: 0.5,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 10,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: left(),
                  ),
                  right(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Column left() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Hero(
          tag: 'city_name_tag_${weather.city.name}',
          child: Material(
            color: Colors.transparent,
            child: Text(
              weather.city.name ?? '',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 26,
                shadows: [
                  Shadow(
                    color: Colors.black38,
                    blurRadius: 6,
                    offset: Offset(2, 2),
                  ),
                ],
              ),
            ),
          ),
        ),
        Text(
          weather.main,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        DView.height(16),
        Row(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white70,
                borderRadius: BorderRadius.circular(30),
              ),
              width: 1.5,
              height: 30,
            ),
            DView.width(8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Humidity ',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),
                Text(
                  '${weather.humidity}%',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            DView.width(8),
            Container(
              decoration: BoxDecoration(
                color: Colors.white70,
                borderRadius: BorderRadius.circular(30),
              ),
              width: 1.5,
              height: 30,
            ),
            DView.width(8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Wind ',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),
                Text(
                  '${(weather.wind * 3.6).toStringAsFixed(2)}km/h',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Column right() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        ExtendedImage.network(
          URLs.weatherIcon(weather.icon),
          height: 60,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${(weather.temperature - 273.15).round()}',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 50,
                fontWeight: FontWeight.bold,
                shadows: [
                  Shadow(
                    color: Colors.black38,
                    blurRadius: 6,
                    offset: Offset(2, 2),
                  ),
                ],
              ),
            ),
            const Text(
              '\u2103',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                height: 2,
                fontWeight: FontWeight.bold,
                shadows: [
                  Shadow(
                    color: Colors.black38,
                    blurRadius: 6,
                    offset: Offset(2, 2),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
