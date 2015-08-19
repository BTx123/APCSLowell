int width = 640;
int height = 480;

size(width, height);

// Face
fill(255,255,0);
//ellipse(100,50,80,80);
ellipse(width/2,height/2,80,80);
// Mouth
arc(width/2,height/2,60,60,PI/8,7*PI/8);
// Eyes
fill(0,0,0);
ellipse(85,40,10,15);
ellipse(115,40,10,15);

