// Copyright (c) 2015, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.
library game;

import 'dart:html';
import 'sprite.dart';
import 'keyboard.dart';

CanvasElement canvas = querySelector('#canvas');


List<Sprite> sprites = [];


Sprite hero = new Sprite(new ImageElement(src: "s6.png"), 400, 400);

Game game = new Game(canvas.getContext('2d'));

num last = 0;

int width = 800;
int height = 640;

void main() {
  canvas.width = width;
  canvas.height = height;
  sprites.add(new Sprite(new ImageElement(src: "red.png"),400,350));
  sprites.add(new Sprite(new ImageElement(src: "red.png"),400,450));
  sprites.add(new Sprite(new ImageElement(src: "red.png"),350,400));
  hero.img.onLoad.listen(game.start);

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
    context.drawImage(hero.img
        , (width-hero.w)/2, (height-hero.h)/2);
    for (var sprite in sprites) {
      var x = sprite.x;
      var y = sprite.y;
      x = hero.x-x;
      y = hero.y-y;
      x = (width-hero.w)/2 - x;
      y = (height-hero.h)/2 - y;
      context.drawImage(sprite.img, x, y);
      print('x:$x y:$y');
    }
    window.animationFrame.then(loop);
  }


  void update(num time) {
    var dx = 0;
    var dy = 0;
    if (input.isPressed(KeyCode.W)) dy--;
    if (input.isPressed(KeyCode.S)) dy++;
    if (input.isPressed(KeyCode.D)) dx++;
    if (input.isPressed(KeyCode.A)) dx--;



    if (time - last > 1000 / 250) {
      last = time;
      //print('dy: $dy dx: $dx time: $time');
        hero.move(dx, dy);
    }
  }
}
