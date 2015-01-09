// Copyright (c) 2015, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.
library game;

import 'dart:html';
import 'sprite.dart';
import 'keyboard.dart';

CanvasElement canvas = querySelector('#canvas');



Sprite sprite;

Game game = new Game(canvas.getContext('2d'));

num last = 0;

void main() {
  sprite = new Sprite(new ImageElement(src: "s6.png"));
  sprite.img.onLoad.listen(game.start);

}

class Game {

  
  CanvasRenderingContext2D context;
  Keyboard input = new Keyboard();
  
  
  Game(this.context);
  
  void start(Event e) {

    window.animationFrame.then(loop);
  }

  void loop(num time) {

    update(time);

    context.fillStyle = '#ffffff';
    context.fillRect(0, 0, 800, 640);
    context.drawImage(sprite.img, sprite.x, sprite.y);
    window.animationFrame.then(loop);
  }


  void update(num time) {
    var dx = 0;
    var dy = 0;
    if (input.isPressed(KeyCode.W)) dy--;
    if (input.isPressed(KeyCode.S)) dy++;
    if (input.isPressed(KeyCode.D)) dx++;
    if (input.isPressed(KeyCode.A)) dx--;



    if (time - last > 1000 / 40) {
      last = time;
      print('dy: $dy dx: $dx time: $time');
      sprite.move(dx, dy);
    }
  }
}
