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
    Icons.person,
    'Usuarios',
    'Administración de usuarios',
    '/user-home',
  ),
  DrawerElement(
    Icons.business,
    'Clientes',
    'Administración de clientes',
    '/clients-home',
  ),
  DrawerElement(
    Icons.balance,
    'Balance',
    'Manejo de balances',
    '/balance-home',
  ),
  DrawerElement(
    Icons.blur_linear_rounded,
    'Estado de Resultados',
    'Manejo de estado de resultados',
    '/income-statement-home',
  ),
];
