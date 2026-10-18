import 'package:flutter/material.dart';

String formatDateTime(
  BuildContext context,
  DateTime? d, {
  String emptyText = 'No date',
}) {
  if (d == null) return emptyText;

  final now = DateTime.now();
  final isToday =
      d.year == now.year && d.month == now.month && d.day == now.day;

  final date = isToday
      ? 'Today'
      : MaterialLocalizations.of(context).formatMediumDate(d);
  final time = TimeOfDay.fromDateTime(d).format(context);

  return '$date, $time';
}