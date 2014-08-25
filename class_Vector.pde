class Vector {
  float x, y;
  float factor=0.25;
  float maxspeed=2;
  
  Vector (){
    x = 0;
    y = 0;
   
  }
  
  void set(){
    
    if (chance()) {
      int a = chance() ? 1 : -1;
      x+=a*factor;
    }
    if (chance()) {
      int b = chance() ? 1 : -1;
      y+=b*factor;
    }
   
   if (x>maxspeed) { x=maxspeed; } else if (x<=-maxspeed) { x=-maxspeed; } 
   if (y>maxspeed) { y=maxspeed; } else if (y<=-maxspeed) { y=-maxspeed; }
  }
  
  boolean chance(){
    return random(0,100) > 50; 
  }
  
}
