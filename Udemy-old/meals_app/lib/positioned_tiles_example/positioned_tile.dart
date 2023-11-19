// import 'dart:math';

// import 'package:flutter/material.dart';

// void main() {
//   runApp(MaterialApp(
//     home: PositionedTiles(),
//   ));
// }

// class PositionedTiles extends StatefulWidget {
//   PositionedTiles({Key? key}) : super(key: key);

//   @override
//   State<PositionedTiles> createState() => _PositionedTilesState();
// }

// class _PositionedTilesState extends State<PositionedTiles> {
//   late List<Widget> tiles;

//   @override
//   void initState() {
//     super.initState();
//     tiles = [
//       Padding(
//         key: UniqueKey(),
//         padding: const EdgeInsets.all(8.0),
//         child: ColorfulTile(
//           name: 'One',
//         ),
//       ),
//       Padding(
//         key: UniqueKey(),
//         padding: const EdgeInsets.all(8.0),
//         child: ColorfulTile(
//           name: 'Two',
//         ),
//       ),
//     ];
//   }

//   void swapTiles() {
//     setState(() {
//       tiles.insert(1, tiles.removeAt(0));
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Row(
//           children: tiles,
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: swapTiles,
//         child: const Icon(Icons.sentiment_very_satisfied),
//       ),
//     );
//   }
// }

// class ColorfulTile extends StatefulWidget {
//   ColorfulTile({
//     Key? key,
//     required this.name,
//   }) : super(key: key);

//   final String name;

//   @override
//   State<ColorfulTile> createState() => _ColorfulTileState();
// }

// class _ColorfulTileState extends State<ColorfulTile> {
//   final List<Color> colors = [
//     Colors.red,
//     Colors.blue,
//     Colors.green,
//     Colors.purple,
//   ];

//   late Color myColor = colors[Random().nextInt(3)];

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 100,
//       height: 100,
//       alignment: Alignment.center,
//       color: myColor,
//       child: Text(
//         widget.name,
//         style: const TextStyle(
//           fontSize: 20,
//           color: Colors.white,
//         ),
//       ),
//     );
//   }
// }
