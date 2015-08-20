int width = 640;
int height = 480;

size(640, 480);

background(100, 100, 100);

// Face
fill(255, 255, 0);
int d = 400;
ellipse(width/2, height/2, d, d);
// Mouth
arc(width/2, height/2, .75*d, .75*d, PI/8, 7*PI/8);
// Eyes
fill(0,0,0);
ellipse(width/2 - .15*d, height/2 - .2*d, 0.125*d, 0.1875*d);
ellipse(width/2 + .15*d, height/2 - .2*d, 0.125*d, 0.1875*d);