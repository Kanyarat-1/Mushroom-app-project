import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';

class MushroomImageProvider with ChangeNotifier {
  List<XFile> _images = [];

  List<XFile> get images => _images;

  void addImage(XFile image) {
    if (_images.length < 3) {
      _images.add(image);
      notifyListeners();
    }
  }

  void clearImages() {
    _images.clear();
    notifyListeners();
  }
}
