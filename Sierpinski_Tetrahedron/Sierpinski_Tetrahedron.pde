//Franciszek Mirecki 2018
//I'm aware it's a 'bit' spaghetti code ;> feel free to refactor this!

import peasy.*;

PeasyCam cam;
int distance = 350;

PVector[] p;
float x0, y0, a, h, H;

ArrayList<PVector> c1Points, c2Points, c3Points, c4Points;

PVector drawer;

final int n = 4;

color c1, c2, c3, c4;

void setup() {
  size(1200, 800, P3D);  

  cam = new PeasyCam(this, distance);
  cam.setMinimumDistance(100);
  cam.setMaximumDistance(4 * distance);

  c1 = color(204, 102, 0);
  c4 = color(0, 102, 153);
  c2 = lerpColor(c1, c4, .33);
  c3 = lerpColor(c1, c4, .66);

  c1Points = new ArrayList<PVector>();
  c2Points = new ArrayList<PVector>();
  c3Points = new ArrayList<PVector>();
  c4Points = new ArrayList<PVector>();

  drawer = new PVector(random(width), random(height), random(-height, 0));

  p = new PVector[n];

  a = 400;

  h = a * sqrt(3) / 2;
  H = a * sqrt(6) / 3;

  p[0] = new PVector(-a/2, h/3, H/4);
  p[1] = new PVector(a/2, h/3, H/4);
  p[2] = new PVector(0, -2*h/3, H/4);
  p[3] = new PVector(0, 0, -3*H/4);

  //for (int i = 0; i < n - 1; i++) {
  //  if (i < n - 2) p[i] = new PVector(random(width), random(height), 0);
  //  else p[n-2] = new PVector(random(width/2), random(height/2), depth);
  //  point(p[i].x, p[i].y, p[i].z);
  //}
}

void draw() {
  background(51);

  if (frameCount < 500) {
    for (int k = 0; k < 10; k++) {
      int r = floor(random(4));
      if (r == 0) {
        drawer = PVector.lerp(drawer, p[0], 0.5);
        c1Points.add(drawer);
      } else if (r == 1) {
        drawer = PVector.lerp(drawer, p[1], 0.5);
        c2Points.add(drawer);
      } else if (r == 2) {
        drawer = PVector.lerp(drawer, p[2], 0.5);
        c3Points.add(drawer);
      } else if (r == 3) {
        drawer = PVector.lerp(drawer, p[3], 0.5);
        c4Points.add(drawer);
      }
    }
  } else if (frameCount == 500) {
    //frameCount = -1;
    print("Adding points have ended");
  }
  
  strokeWeight(12);
  drawVertices();
  
  strokeWeight(6);
  drawPoints(c1Points, c1);
  drawPoints(c2Points, c2);
  drawPoints(c3Points, c3);
  drawPoints(c4Points, c4);
}

void drawVertices() {
  stroke(c1, 100);
  point(p[0].x, p[0].y, p[0].z);

  stroke(c2, 100);
  point(p[1].x, p[1].y, p[1].z);

  stroke(c3, 100);
  point(p[2].x, p[2].y, p[2].z);

  stroke(c4, 100);
  point(p[3].x, p[3].y, p[3].z);
}

void drawPoints(ArrayList<PVector> points, color c) {
  for (PVector p : points) {
    stroke(c);
    point(p.x, p.y, p.z);
  }
}
