class Shape{
  //7 Tetris Shapes
  private int[][] square = {{0,0}, {1,0}, {0,1}, {1,1}};//Square Shape
  private int[][] ln = {{0,0}, {1,0}, {2,0}, {3,0}};//line
  private int[][] tri = {{0,0}, {1,0}, {1,1}, {2,1}};//Triangle
  private int[][] leftL = {{0,0}, {0,1}, {1,0}, {2,0}};//LeftL
  private int[][] rightL = {{0,0}, {1,0}, {2,0}, {2,1}};//RightL
  private int[][] theS  = {{0,0}, {1,0}, {1,1}, {2,1}};//theS
  private int[][] otherS = {{0,1}, {1,1}, {1,0}, {2,0}};//othersS
  
  //Rest of the fields
  private int[][] theShape, oS; //Originalshape
  private int counter, r,g,b;
  private boolean isActive;
  private float w;
  private int choice, rotCount;
  private int theX, theY;
  
  public Shape(){
    w = width/24;
   choice = (int)random(7);
   switch(choice){
     case 0:
       theShape = square;
       r = 255;
       break;
     case 1:
       theShape = ln;
       g = 255;
       break;
     case 2:
       theShape = tri;
       b = 255;
       break;
     case 3:
       theShape = leftL;
       r = 255;
       g = 255;
       break;
     case 4:
     theShape = rightL;
       g = 255;
       b = 255;
       break;
     case 5:
       theShape = theS;
       r = 255;
       b = 140;
       break;
     case 6:
     theShape = otherS;
       r = 155;
       g = 60;
       b = 200;
       break;
  }
counter = 1;
oS = theShape;
rotCount = 0;
 }
 
 public void display(){
   fill(r,g,b);
   for(int i = 0; i < 4; i++){
     rect(theShape[i][0]*w, theShape[i][1]*w, w, w);
   }
 }
 public void showOnDeck(){
   fill(88,255,240);
   rect(width/2, 0, width/2, height);
   fill(0);
   text("NEXT SHAPE:", width/2 + 55, 60);
   fill(255);
   text("NEXT SHAPE:", width/2 + 58, 63);
   fill(r,g,b);
   for(int i = 0; i < 4; i++){
     rect(theShape[i][0]*w + width/2 + 140, theShape[i][1]*w + 100, w, w);
   }
 }
 public void moveDown(){
   if(counter % 50 == 0){
 moveShape("DOWN");
}
  counter++;
 }
 
 public boolean checkSide(String side){
   switch(side){
    case "RIGHT":
    for(int i = 0; i < 4; i++){
     if(theShape[i][0] > 10){
      return false; 
     }
    }
    break;
    case "LEFT":
    for(int i = 0; i < 4; i++){
     if(theShape[i][0] < 1){
      return false; 
     }
    }
    break;
    case "DOWN":
    for(int i = 0; i < 4; i++){
     if(theShape[i][1] > 22){
       isActive = false;
      return false; 
     }
    }
    break;
   }
   return true;
 }

 
   public void moveShape(String dir){
   if(checkSide(dir)){
     if(dir == "RIGHT"){
       for(int i = 0; i < 4; i++){
         theShape[i][0]++;   //MOVE RIGHT
       }
     }else if(dir == "LEFT"){
       for(int i = 0; i < 4; i++){
         theShape[i][0]--;   //MOVE LEFT
       }
     }else if(dir == "DOWN"){
       for(int i = 0; i < 4; i++){
         theShape[i][1]++;   //MOVE DOWN
       }
     }
   }
  }
  
  public void rotate(){
   if(theShape != square){
   int[][] rotated = new int[4][2];
   if(rotCount % 4 == 0){
     for(int i = 0; i < 4; i++){
    rotated[i][0] = oS[i][1] - theShape[1][0];
    rotated[i][1] = -oS[i][0] - theShape[1][1];
     }
   }else if (rotCount % 4 == 1){
      for(int i = 0; i < 4; i++){
    rotated[i][0] = oS[i][0] - theShape[1][0];
    rotated[i][1] = -oS[i][1] - theShape[1][1];
      }  
   }else if (rotCount % 4 == 2){
     for(int i = 0; i < 4; i++){
    rotated[i][0] = -oS[i][1] - theShape[1][0];
    rotated[i][1] = oS[i][0] - theShape[1][1];
     }
   }else if (rotCount % 4 == 3){
      for(int i = 0; i < 4; i++){
    rotated[i][0] = -oS[i][0] - theShape[1][0];
    rotated[i][1] = oS[i][1] - theShape[1][1];
      }
     }
   theShape = rotated;
   }
  }
  public boolean checkBack(Background b){
   for(int i = 0; i < 4; i++){
     theX = theShape[i][0];
     theY = theShape[i][1];
     if(theX >= 0 && theX < 12 && theY >= 0 && theY < 23){
      for(int a = 0; a < 3; a++){
       if(b.colors[theX][theY+1][a] != 0){
        return false; 
       }
      }
     }
  } //check each block
  return true;
}
}
