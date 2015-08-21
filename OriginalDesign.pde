void setup() {
	size(640, 480);
	background(0);
}

float d = 0;
int velocity = 3;
void draw() {
	ellipse(width/2, height/2, d, d);
	d += velocity;
	if (d == 0 || d == minBounds()) {
		velocity *= -1;
	}
}

// Returns smaller size() dimension
int minBounds() {
	if (height < width) {
		return height;
	} else {
		return width;
	}
}