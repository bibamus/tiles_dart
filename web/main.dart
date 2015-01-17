// Copyright (c) 2015, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.
library game;

import 'dart:html';
import 'dart:async';

import 'sprite.dart';
import 'keyboard.dart';
import 'tile.dart';

CanvasElement canvas = querySelector('#canvas');


List<Sprite> sprites = [];


Sprite hero = new Hero(5, 5);

Game game = new Game(canvas.getContext('2d'));

//Tileset tileset = new Tileset('images/tileset-advance.png', 16);

Tilemap tilemap = new Tilemap.fromJson('map1.json');

num last = 0;

int width = 800;
int height = 640;

void main() {

  Future.wait([tilemap.initialized.first, hero.img.onLoad.first]).then(init);

}

void init(var e) {
  canvas.width = width;
  canvas.height = height;
  sprites.add(new Sprite("images/red.png", 200, 150));
  sprites.add(new Sprite("images/red.png", 200, 250));
  sprites.add(new Sprite("images/red.png", 150, 200));
  game.start();
}

class Game {


  CanvasRenderingContext2D context;
  Keyboard input = new Keyboard();


  Game(this.context);

  void start() {

    window.animationFrame.then(loop);
  }

  void loop(num time) {

    update(time);

    context.fillStyle = '#ffffff';
    context.fillRect(0, 0, 800, 640);


    var ts = tilemap.tileset.tilesize;

    int h = (height ~/ ts);
    int w = (width ~/ ts);

    int l = (hero.x-w~/2);
    int u = (hero.y-h~/2);

    for (int i = 0; i < height / 16; i++) {
      for (int j = 0; j < width / 16; j++) {
        //var tile = tilemap.tileset.getTile(0);
        var tile = tilemap.getTileAt(j+l, i+u);
        context.putImageData(tile, j * 16, i * 16);
      }
    }


    /*for (var sprite in sprites) {
      if (sprite.loaded) {
        var x = sprite.x;
        var y = sprite.y;
        x = hero.x - x;
        y = hero.y - y;
        x = (width - hero.w) / 2 - x;
        y = (height - hero.h) / 2 - y;
        context.drawImage(sprite.img, x, y);
        //print('x:$x y:$y');
      }
    }
*/
    //print('x:' + ((width - hero.w) / 2).toString() + ' y: ' + ((height - hero.h) / 2).toString());
    context.drawImage(hero.img, (w/2)*ts, (h/2)*ts);
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
      print(tilemap.getEventAt(hero.x + dx, hero.y + dy));
      if(tilemap.getEventAt(hero.x + dx, hero.y + dy) != 1 ){
        hero.move(dx, dy);
      }
    }
  }
}
