class Goodguy {
  float xpos, ypos, speed;
  int xdir, ydir;
  int xsize, ysize;
  PImage img;
  
  Goodguy(String tempFilename, float tempSpeed) {
    String filename = tempFilename;
    speed = tempSpeed;
    
    img = loadImage(filename);
    imageMode(CENTER);
    //size of filename
    xsize = 70;
    ysize = 88;
    
    //directions: -1 = left/up, 0 = dont move, 1 = right/down
    //has to do with xpos and ypos
    xdir=0;
    ydir=0;
    
    //initial position 
    xpos = width/2;
    ypos = height-ysize;
  }

  void moveX (int direction){
    xdir=direction;
  }
  
  void moveY (int direction){
    ydir=direction;
  }

  
  void display(){
    image(img, xpos, ypos);
  }
  
  void move(){
    xpos = xpos + (xdir * speed);
    ypos = ypos + (ydir * speed);
    if (xpos<xsize/2) { xdir=0; xpos=(xsize/2); }
    if (xpos>width-xsize/2) { xdir=0; xpos=width-xsize/2; }
    if (ypos<ysize/2) { ydir=0; ypos=ysize/2; }
    if (ypos>height-ysize/2) { ydir=0; ypos=height-ysize/2; }
   
  }
  
}
