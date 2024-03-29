float r1 = 200; // length of first pendulum
float r2 = 200; // length of second pendulum
float r3 = 200; // length of third pendulum
float m1 = 40; //  mass of first pendulum excluding weight of string
float m2 = 40; // mass of second pendulum excluding weight of string
float m3 = 40; // mass of third pendulum excluding weight of string
float a1 = PI/2; // angle formed by first pendulum and normal - angle1
float a2 = PI/2; //angle formed by second pendulum and normal - angle2
float a3 = PI/2; //angle formed by third pendulum and normal - angle2
float a1_v = 0; //angular velocity of pendulum1
float a2_v = 0; //angular velocity of pendulum2
float a3_v = 0; //angular velocity of pendulum3
float g = 1; //gravitational constant (realistic value not considered for simplicity )
float px1 = -1; // previous position of second pendulum sphere - x offset
float py1 = -1; // previos position of second pendulum sphere - y offset
float px2 = -1; // previous position of second pendulum sphere - x offset
float py2 = -1; // previos position of second pendulum sphere - y offset
float px3 = -1; // previous position of second pendulum sphere - x offset
float py3 = -1; // previos position of second pendulum sphere - y offset
float cx, cy; //centre of x and y for background

PGraphics canvas; // canvas is just a variable name DO NOT CONFUSE IT WITH P5.JS

void setup() {
  size(1500, 900); 
  cx = width/2;
  cy = 200;
  canvas = createGraphics(width, height);
  canvas.beginDraw();
  canvas.background(255);
  canvas.endDraw();
}

void draw() {
  background(255);
  imageMode(CORNER);
  image(canvas, 0, 0, width, height);
  // numerators are moduled 
  float num1 = -g * (2 * m1 + m2 + m3) * sin(a1);
  float num2 = -m2 * g * sin(a1-2*a2);
  float num3 = -2*sin(a1-a2)*m2;
  float num4 = a2_v*a2_v*r2+a1_v*a1_v*r1*cos(a1-a2);
  float den = r1 * (2*m1+m2-m2*cos(2*a1-2*a2));
  float a1_a = (num1 + num2 + num3*num4) / den;

  num1 = 2 * sin(a1-a2);
  num2 = (a1_v*a1_v*r1*(m1+m2));
  num3 = g * (m1 + m2) * cos(a1);
  num4 = a2_v*a2_v*r2*m2*cos(a1-a2);
  den = r2 * (2*m1+m2-m2*cos(2*a1-2*a2));
  float a2_a = (num1*(num2+num3+num4)) / den;
  float a3_a = (num1*(num2+num3+num4)) / den;

  translate(cx, cy);
  stroke(0);
  strokeWeight(2);

  float x1 = r1 * sin(a1);
  float y1 = r1 * cos(a1);

  float x2 = x1 + r2 * sin(a2);
  float y2 = y1 + r2 * cos(a2);

  float x3 = x1 + r2 + r3 * sin(a3);
  float y3 = y1 + r2 + r3 * cos(a3);

  line(0, 0, x1, y1);
  fill(0);
  ellipse(x1, y1, m1, m1);

  line(x1, y1, x2, y2);
  fill(0);
  ellipse(x2, y2, m2, m2);

  line(x2, y2, x3, y3);
  fill(0);
  ellipse(x3, y3, m3, m3);

  a1_v += a1_a;
  a2_v += a2_a;
  a3_v += a3_a;
  a1 += a1_v;
  a2 += a2_v;
  a3 += a3_v;
  // as momentum increases  , slowly pendulum comes to rest
  // a1_v *= 0.99; // for drag
  // a2_v *= 0.99; // for drag

  canvas.beginDraw();
  //canvas.background(0, 1);
  canvas.translate(cx, cy);
  canvas.stroke(0, 0, 255);
  if (frameCount > 1) {
    canvas.line(px1, py1, x1, y1);
  }
  
  canvas.endDraw();
  canvas.beginDraw();
  //canvas.background(0, 1);
  canvas.translate(cx, cy);
  canvas.stroke(0, 255, 0);
  if (frameCount > 1) {
    canvas.line(px2, py2, x2, y2);
  }
  canvas.endDraw();

  canvas.beginDraw();
  //canvas.background(0, 1);
  canvas.translate(cx, cy);
  canvas.stroke(255, 0, 0);
  if (frameCount > 1) {
    canvas.line(px3, py3, x3, y3);
  }
  canvas.endDraw();

  px1 = x1;
  py1 = y1;
  px2 = x2;
  py2 = y2;
  px3 = x3;
  py3 = y3;
}
