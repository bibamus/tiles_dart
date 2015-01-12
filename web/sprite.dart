library Sprite;

import 'dart:html';

class Sprite {
  
  ImageElement img;
  int x;
  int y;
  int w;
  int h;
  
  Sprite(String imgpath,[this.x = 0,this.y = 0]){
    img =  new ImageElement(src: imgpath); 
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