class Missle {
  float xpos, ypos, speed;
  int xdir, ydir;
  int xsize, ysize;
  PImage img;
  boolean visible;
  
  Missle(String tempFilename, float tempXpos, float tempYpos, float tempSpeed) {
    String filename = tempFilename;
    visible = true;
    speed = tempSpeed;
    
    img = loadImage(filename);
    imageMode(CENTER);
    //size of filename
    xsize = 13;
    ysize = 14;
    
    //directions: -1 = left/up, 0 = dont move, 1 = right/down
    //has to do with xpos and ypos
    xdir=0;
    ydir=-1;
    
    //initial position 
    xpos = tempXpos;
    ypos = tempYpos;
  }

  void display(){
    image(img, xpos, ypos);
  }
  
  void move(){
    ypos = ypos + (ydir * speed);
    if (ypos<ysize/2) { visible = false; }
    if (ypos>height-ysize/2) { visible = false; }
  }
    
}
