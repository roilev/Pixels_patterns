HScrollbar hs1;

void setup() {
  size(800, 600);
  noStroke();
  hs1 = new HScrollbar(30, 550, 740, 16, 16);
  }

void draw() {
  hs1.update();
  hs1.display();
  
  //pattern//
 fill(255,0,0,5);
 stroke(255,255,0,5);
 float size = map(hs1.getPos(),30,770,0,100);
 strokeWeight(size);
  for (int i = 0; i <= width; i = i+50){
    for (int j = 0; j <= height; j = j+50){
      ellipse(i,j,50,50);
   }
 }
}


class HScrollbar {
  int swidth, sheight;    // width and height of bar
  float xpos, ypos;       // x and y position of bar
  float spos, newspos;    // x position of slider
  float sposMin, sposMax; // max and min values of slider
  int loose;              // how loose/heavy
  boolean over;           // is the mouse over the slider?
  boolean locked;
  float ratio;

  HScrollbar (float xp, float yp, int sw, int sh, int l) {
    swidth = sw;
    sheight = sh;
    int widthtoheight = sw - sh;
    ratio = (float)sw / (float)widthtoheight;
    xpos = xp;
    ypos = yp-sheight/2;
    spos = xpos + 10 - sheight/2;
    newspos = spos;
    sposMin = xpos;
    sposMax = xpos + swidth - sheight;
    loose = l;
  }

  void update() {
    if (overEvent()) {
      over = true;
    } else {
      over = false;
    }
    if (mousePressed && over) {
      locked = true;
    }
    if (!mousePressed) {
      locked = false;
    }
    if (locked) {
      newspos = constrain(mouseX-sheight/2, sposMin, sposMax);
    }
    if (abs(newspos - spos) > 1) {
      spos = spos + (newspos-spos)/loose;
    }
  }

  float constrain(float val, float minv, float maxv) {
    return min(max(val, minv), maxv);
  }

  boolean overEvent() {
    if (mouseX > xpos && mouseX < xpos+swidth &&
       mouseY > ypos && mouseY < ypos+sheight) {
      return true;
    } else {
      return false;
    }
  }

  void display() {
    if (over || locked) {
      noStroke();
      fill(204);
      rect(xpos, ypos, swidth, sheight);
      fill(0, 0, 0);
      rect(spos, ypos, sheight, sheight);
    }
  }

  float getPos() {
    // Convert spos to be values between
    // 0 and the total width of the scrollbar
    return spos * ratio;
  }
}