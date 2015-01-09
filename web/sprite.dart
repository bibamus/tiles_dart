library Sprite;

import 'dart:html';

class Sprite {
  
  ImageElement img;
  int x;
  int y;
  
  Sprite(this.img,[this.x = 0,this.y = 0]);
  
  
  void move(int dx, int dy) {
    x += dx;
    y += dy;
  }
}