library Resource;

import 'dart:html';


class Resource {
  
  
  static final Map<String,ImageElement> images = {};
  
  
  static ImageElement getImg(String path){
    loadImage(path);
    return images[path];
  }
  
  static loadImage(String path){
    if(!images.containsKey(path)){
      images[path] = new ImageElement(src: path);
    }
    return images[path].onLoad.first;
  }
  
}