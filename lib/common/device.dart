
import 'dart:ui';
double hcScreenWidth() {
  return window.physicalSize.width/window.devicePixelRatio;
}

double hcScreenHeight(){
  return window.physicalSize.height/window.devicePixelRatio;
}

double hcFitWidth(double width) {
  return hcScreenWidth()/375.0 *width;
}

double hcFitHeight(double height) {
  return hcScreenHeight()/667.0 *height;
}