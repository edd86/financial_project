enum ImageData {
  image1(
    'Analisis Financiero',
    'Balance General | Estado de Resultados',
    'assets/img/img1.jpg',
  ),
  image2('Ratios Financieros', 'Indicadores económicos', 'assets/img/img2.jpg'),
  image3('Obligaciones', 'Obligaciones tributarias', 'assets/img/img3.jpg'),
  image4('Diafanis & Cia SRL', 'Auditoria Contabilidad', 'assets/img/img4.jpg');

  const ImageData(this.title, this.subtitle, this.path);
  final String title;
  final String subtitle;
  final String path;
}
