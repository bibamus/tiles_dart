library Sprite;


import 'dart:html';
import 'resource.dart';

part 'hero.dart';

class Sprite {
  
  ImageElement img;
  int x;
  int y;
  int w;
  int h;
  
  bool loaded = false;
  
  Sprite(String path,[this.x = 0,this.y = 0]){
    img =  Resource.getImg(path); 
    img.onLoad.listen((e) {
      w = img.width;
      h = img.height;
      loaded = true;
    });

  }
  
  
  void move(int dx, int dy) {
    x += dx;
    y += dy;
  }
}