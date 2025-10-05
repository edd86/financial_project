import 'package:flutter/material.dart';

class DrawerElement {
  IconData icon;
  String title;
  String description;
  String route;
  DrawerElement(this.icon, this.title, this.description, this.route);
}

final List<DrawerElement> drawerElements = [
  DrawerElement(Icons.home, 'Inicio', 'Pantalla de inicio', '/home'),
  DrawerElement(
    Icons.business,
    'Clientes',
    'Pantalla de clientes',
    '/clients-home',
  ),
  DrawerElement(
    Icons.balance,
    'Balance',
    'Pantalla de balance',
    '/balance-home',
  ),
];
