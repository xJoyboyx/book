import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ImageBuilder extends StatefulWidget {
  final String imageName;
  final String themeId;
  final double? width;

  ImageBuilder({
    required this.imageName,
    required this.themeId,
    this.width,
  });

  @override
  _ImageBuilderState createState() => _ImageBuilderState();
}

class _ImageBuilderState extends State<ImageBuilder> {
  late Future<String> _imagePath;

  @override
  void initState() {
    super.initState();
    _imagePath = _getValidImagePath();
  }

  Future<bool> assetExists(String path) async {
    try {
      await rootBundle.load(path);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<String> _getValidImagePath() async {
    final gifPath =
        'assets/media/theme${widget.themeId}/${widget.imageName}.gif';
    bool gifExists = await assetExists(gifPath);
    if (gifExists) {
      return gifPath;
    } else {
      return 'assets/media/theme${widget.themeId}/${widget.imageName}.png';
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: _imagePath,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            return Image.asset(
              snapshot.data!,
              width: widget.width,
            );
          }
          return Icon(Icons.error); // O algún widget de error
        }
        return CircularProgressIndicator(); // Mientras carga
      },
    );
  }
}
