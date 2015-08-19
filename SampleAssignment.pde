int width = 640;
int height = 480;

size(width, height);

// Face
fill(255,255,0);
//ellipse(100,50,80,80);
int d = 80;
ellipse(width/2,height/2,d,d);
// Mouth
arc(width/2,height/2,60,60,PI/8,7*PI/8);
// Eyes
fill(0,0,0);
ellipse(width/2 - .15*d/2,height/2 - .2*d/2,10,15);
ellipse(width/2 + .15*d/2,height/2 + .2*d/2,10,15);

