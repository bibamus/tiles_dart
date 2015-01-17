library Tile;

import 'dart:html';
import 'dart:async';
import 'dart:convert';

import 'resource.dart';

class Tileset {

  int tilesize;

  CanvasElement tileset;

  CanvasRenderingContext2D context;

  int rows;

  final StreamController initializeController = new StreamController.broadcast();


  Tileset(String path, this.tilesize) {
    tileset = new CanvasElement();
    context = tileset.getContext('2d');
    Resource.getImg(path).onLoad.listen(init);
  }

  void init(Event e) {

    ImageElement img = e.target;

    rows = img.width ~/ tilesize;
    tileset.width = img.width;
    tileset.height = img.height;
    context.drawImage(img, 0, 0);
    initializeController.add('initialized');
  }

  ImageData getTile(int n) {

    var x = n % rows;
    var y = n ~/ rows;
    return context.getImageData(x * tilesize, y * tilesize, tilesize, tilesize);
  }

  Stream get initialized => initializeController.stream;

}


class Tilemap {


  Tileset tileset;
  List map;
  List event;
  int height;
  int width;

  final StreamController initializeController = new StreamController.broadcast();

  Tilemap.fromJson(String path) {
    HttpRequest.getString(path).then(_parseJSON);
  }

  void _parseJSON(String json) {
    var mapdata = JSON.decode(json);
    tileset = new Tileset('images/' + mapdata['tilesets'][0]['image'], mapdata['tilesets'][0]['tileheight']);
    map = mapdata['layers'][0]['data'];
    event = mapdata['layers'][1]['data'];
    height = mapdata['layers'][0]['height'];
    width = mapdata['layers'][0]['width'];
    tileset.initialized.listen((e) => initializeController.add('initialized'));
  }


  Stream get initialized => initializeController.stream;


  ImageData getTileAt(int x, int y) {
    if (y>=0 && y < height && x >= 0 && x < width) {
      return tileset.getTile(map[width * y + x]-1);
    }
    return tileset.getTile(584);
  }
  
  int getEventAt(int x, int y) {
    if (y>=0 && y < height && x >= 0 && x < width) {
      return event[width * y + x]-7984;
    }
    return 2;
  }  
}
