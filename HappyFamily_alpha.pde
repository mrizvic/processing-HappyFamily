//9. februar 2013
//Patrik sprica z vodo
//arrow keys + spacebar
//1 to 9 keys to spawn new badguy ( depends on imgBadguys.size() )

//debug mode
int debug = -1;

//window size
int windowX = 1024;
int windowY = 768;

//max missles on screen
int maxGranitk = 200;
//missle counter
int countGranitk = 0;
//missle speed
float speedGranitka = 10;
//if fire button is on
boolean fire;
//fire counter
int fireCounter;
//fire every N frames
int fireStep=40;
int fireStepMin=5;

float goodguySpeed=7;
int maxBadguys = 50;

//unused at the moment
float badguySpeed=2;

//one goodguy
Goodguy patrik;

//movement helper
Vector Vector1;

//many missles
ArrayList waterdrops;

//many badguys
ArrayList family;

//images of badguys
ArrayList imgBadguys;

//follower helper - unused at the moment
Mover mover;

//init
void setup() {
  
  //this is for JavaScript mode
  //size(1024,768);

  size(windowX, windowY);
  frameRate(100);


  //stora badguys images to ArrayList for later retrieval
  imgBadguys = new ArrayList();
  imgBadguys.add("maja_small2.gif");
  imgBadguys.add("julija_small.gif");
  imgBadguys.add("marko_small2.gif");
  imgBadguys.add("sanda_small2.gif");
  imgBadguys.add("zlatko_small2.gif");
  imgBadguys.add("marinka_small.gif");
  imgBadguys.add("dusan_small.gif");
  
  //shooter
  patrik = new Goodguy("patrik_small.gif", goodguySpeed);
  
  //unused follower at the moment
  mover = new Mover();
  
  //waterdrops
  waterdrops = new ArrayList();
  
  family = new ArrayList();
  
  //spawn each badguy at least once
  for (int j = 0; j<imgBadguys.size(); j++) {
    family.add(new Badguy((String) imgBadguys.get(j), badguySpeed)); 
  }

  //spawn more random badguys
  for (int i = family.size(); i<maxBadguys; i++) {
    int r = (int) random(0,imgBadguys.size()-1);
    family.add(new Badguy((String) imgBadguys.get(r), badguySpeed));
  }
  
}

//loop
void draw() {

  background(0);            //clear screen
  
  //badguys movement and collision detection
  for (int i=family.size()-1; i>=0; i--) {
    Badguy member = (Badguy) family.get(i);
    member.move();
    member.rotateme();
    
     //collision detection logic - spawn new badguy when existing badyug collides with goodguy
     if (family.size()<maxBadguys) {
        float factor=0.6;
        if ( (patrik.xpos >= member.xpos - member.xsize*factor) && 
             (patrik.xpos <= member.xpos + member.xsize*factor) && 
             (patrik.ypos >= member.ypos - member.ysize*factor) &&
             (patrik.ypos <= member.ypos + member.ysize*factor)  )
        {
          int r = (int) random(0,imgBadguys.size()-1);
          family.add(new Badguy((String) imgBadguys.get(r), badguySpeed));
         
          if (debug == 1) {
            println("collision goodguy and badguy " + i + " " + member.filename);
          }
 
        }
     }
          
     //remove 'invisible' members               
     if (member.visible == false) { family.remove(i); }
   
  }
  
  //goodguy movement
  patrik.move();
  patrik.display();

  
  // Call functions on Mover object.
  //mover.update();
  //mover.checkEdges();
  //mover.display(); 


  //if missles are launched
  if (waterdrops.size()>0) {
    for (int i=waterdrops.size()-1; i>=0; i--) {
      Missle waterdrop = (Missle) waterdrops.get(i);
      
      //if missle is visible
      if (waterdrop.visible == true) {
        
        //check if missle collides with members
        for (int j=family.size()-1; j>=0; j--) {
          //multiply factor with badguy xsize/ysize to achieve better approximation when detecting collision
          float factor=0.6;
          Badguy member = (Badguy) family.get(j);
          
          //collision detection logic
          if (  (waterdrop.xpos >= member.xpos - member.xsize*factor) && 
                (waterdrop.xpos <= member.xpos + member.xsize*factor) && 
                (waterdrop.ypos >= member.ypos - member.ysize*factor) &&
                (waterdrop.ypos <= member.ypos + member.ysize*factor)
              ) {
                
            if (debug == 1) {
              println("collision waterdrop" + i + " and badguy " + j + " " + member.filename);
            }
            waterdrop.visible = false;
            member.visible = false;
            if (fireStep>fireStepMin) { fireStep--; }
          }
        }

        //missle movement
        waterdrop.move();
        waterdrop.display();
        
        
      } else {
        waterdrops.remove(i);
      }
    }
  }
  
  //if fire button is pressed
  if (fire) {
    //if fireCounter catches fireStep and number of missles on screen < max missles then spawn another missle
    if ( (fireCounter++ % fireStep == 0) && (waterdrops.size()<maxGranitk) ) {
        //spawn Missle at coordinates on top of Goodguy
        waterdrops.add(new Missle("waterdrop_small.gif", patrik.xpos, patrik.ypos - patrik.ysize/2, speedGranitka));
        
    //else if fire button is pressed and there are no missles on screen then spawn new missle
    } else if ( waterdrops.size() < 1 ) {
      waterdrops.add(new Missle("waterdrop_small.gif", patrik.xpos, patrik.ypos - patrik.ysize/2, speedGranitka));
      fireCounter = 1;
    }
  }
}

//key events
void keyPressed()
{
  
  if (debug == 1) {
    println("keyPressed event, keyCode = " + keyCode);
  }
 
  //on keyboard event change goodguy movement direction
  switch (keyCode) {
    case UP: patrik.moveY(-1); break;
    case DOWN: patrik.moveY(1); break;
    case LEFT: patrik.moveX(-1); break;
    case RIGHT: patrik.moveX(1); break;
    case ' ': fire=true; break;
    case 68 : debug*=-1; println("debug = "+debug); break;
    default: {
      if ( (keyCode >= '1') && (keyCode <= '9') && (family.size()<=maxBadguys) ) {
        //calculate index for imgBadguys.get(index)
        int index = keyCode-1 - '0';
        if (imgBadguys.size()-1>=index) {
          family.add(new Badguy((String) imgBadguys.get(index), badguySpeed)); 
        }
      }
      break;  
    }
    
  }
}
 
void keyReleased()
{ 
  //on keyboard event change goodguy movement direction
  switch (keyCode) {
    case UP: patrik.moveY(0); break;
    case DOWN: patrik.moveY(0); break;
    case LEFT: patrik.moveX(0); break;
    case RIGHT: patrik.moveX(0); break;
    case ' ': fire=false; break;
    default: break;
  }
}
