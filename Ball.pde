class Ball {
    float ballX;
    float ballY;
    float ballDiameter;
    float ballSpeed;
    
    // Takes initializing variables for diameter and speed
    Ball(float tempDiameter, float tempSpeed) {
        ballDiameter = tempDiameter;
        ballSpeed = tempSpeed;
        //ballX = (float) (Math.random() * (0.9*width) + 10);
        //ballY = (float) (Math.random() * (0.9*height) + 10);
        ballX = mouseX;
        ballY = mouseY;
    }
    
    // Draw ellipse
    void display() {
        noStroke();
        fill(0);
        ellipse(ballX, ballY, ballDiameter, ballDiameter);
    }
    
    // Update position and direction
    void update() {
        // change balls y pos
        ballY += ballSpeed;
        // bounce off bottom of screen
        if (ballY >= height - ballDiameter/2)
            ballSpeed *= -1;
        // bounce off top of screen
        else if (ballY < ballDiameter/2)
            ballSpeed *= -1;
    }
}