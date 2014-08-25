class Badguy {
  float xpos, ypos, speed;
  int xdir, ydir;
  int xsize, ysize;
  PImage img;
  float r,rdir,rlimit,rspeed;
  String filename;
  boolean visible;
  int hitcounter;

  Vector myVector;
 
  Badguy(String tempfilename, float tempSpeed) {
    filename = tempfilename;
    speed = tempSpeed;
    visible = true;
        
    //rotation    
    r=0;
    rdir=1;
    rlimit=random(10,30);
    rspeed=random(0.5,1);
    
    img = loadImage(filename);
    imageMode(CENTER);
    //size of filename
    xsize = 70;
    ysize = 92;
    
    //directions: -1 = left/up, 0 = dont move, 1 = right/down
    //has to do with xpos and ypos
    xdir=0;
    ydir=0;
    
    //initial position
    xpos = random(xsize,width-xsize);
    ypos = ysize;
    
    myVector = new Vector();

  }

  void moveX (int direction){
    xdir=direction;
  }
  
  void moveY (int direction){
    ydir=direction;
  }
 
  void move(){

    myVector.set();
    
    //detect window edge and 'bounce'
    if ( (xpos>width-xsize/2) || (xpos<xsize/2) ) { myVector.x*=-1; }
    if ( (ypos>height-ysize/2) || (ypos<ysize/2) ) { myVector.y*=-1; }
    
    /*
    if ( (xpos < mover.location.x) && (myVector.x < 0) && (myVector.chance()) ) { myVector.x*=-1; }
    if ( (ypos < mover.location.y) && (myVector.y < 0) && (myVector.chance()) ) { myVector.y*=-1; }
    if ( (xpos > mover.location.x) && (myVector.x > 0) && (myVector.chance()) ) { myVector.x*=-1; }
    if ( (ypos > mover.location.y) && (myVector.y > 0) && (myVector.chance()) ) { myVector.y*=-1; }
    */
   
    //set new position
    xpos += myVector.x;
    ypos += myVector.y;

  }

  void display(){
    image(img, xpos, ypos);
  }
  
  void rotateme(){
    
    r = r + (rdir * rspeed);
    
    if ( (r>rlimit) || (r<(rlimit*-1)) ) { rdir*=-1; }
    
    //push frame to stack so we dont alter everything on screen
    pushMatrix();
    //make 0,0 coordinates at the point where current object is currently located
    translate(xpos, ypos);
    //rotate around 0,0
    rotate(r*TWO_PI/360);
    //draw image around 0,0
    image(img, 0, 0);
    //undo translation
    translate(-xpos, -ypos);
    //pop frame from the stack
    popMatrix();
    if (debug == 1){
      strokeWeight(4);
      stroke(255,0,0);
      line(xpos, ypos, xpos+myVector.x*10, ypos+myVector.y*10);
    }
    
      
  }
  

}
