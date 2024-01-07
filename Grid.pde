public class Grid{
  
 
  //Create a private variable (w) type float for the width of ea
  private float w;
  
  //Create a constructor that will calculate how big variable (w) is
  public Grid(){
    w = width/24;
  }
  
  /*Write the private void display method that will draw a series of lines
  *that will act as a grid for our blocks.
  *USE:  line(x,y,x2,y2);
  */
  public void display(){
    stroke(155);
    for(int i = 0; i < 13; i++){
      line(0,i*w, width/2, i*w);
      line(0, (i+12)*w, width/2, (i+12)*w);
      line(i*w, 0, i*w, height);
    }
  }
}
