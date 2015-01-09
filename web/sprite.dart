library Sprite;

import 'dart:html';

class Sprite {
  
  ImageElement img;
  int x;
  int y;
  int w;
  int h;
  
  Sprite(this.img,[this.x = 0,this.y = 0]){
    img.onLoad.listen((e) {
      w = img.width;
      h = img.height;
    });

  }
  
  
  void move(int dx, int dy) {
    x += dx;
    y += dy;
  }
}