import ddf.minim.*;

Minim minim;
AudioPlayer player;

Grid grid;
Shape shape, onDeck;
Background bg;
PImage Logo;

void setup() {
  size(720, 720);
  minim = new Minim(this);
  player = minim.loadFile("Backsound.mp3");
  
  if (player != null) {
    player.loop();  // Use loop() to make the audio loop continuously
    println("File audio dimuat dan diputar.");
  } else {
    println("Kesalahan saat memuat file audio.");
  }

  Logo = loadImage("Logo.png");
  grid = new Grid();
  shape = new Shape();
  shape.isActive = true;
  onDeck = new Shape();
  bg = new Background();
  textSize(44);
}

void drawShapes() {
  shape.display();
  onDeck.showOnDeck();

  if (shape.checkBack(bg)) {
    shape.moveDown();
  } else {
    shape.isActive = false;
  }

  if (!shape.isActive) {
    bg.writeShape(shape);
    shape = onDeck;
    shape.isActive = true;
    onDeck = new Shape();
  }
}

void draw() {
  bg.display();
  grid.display();
  drawShapes();
  image(Logo, 460, height - 230);
  fill(0);
  text("Score: " + bg.score, width/2 + 100, height - 350);
if (bg.isGameOver() || bg.gameWon) {
    player.close(); // Stop the music when the game is over or when the player wins
  }
}

void keyPressed() {
  if (keyCode == RIGHT) {
    shape.moveShape("RIGHT");
  } else if (keyCode == LEFT) {
    shape.moveShape("LEFT");
  } else if (keyCode == DOWN) {
    shape.moveShape("DOWN");
  }
  
}

void keyReleased() {
  if (keyCode == UP) {
    shape.rotate();
    shape.rotate();
  }
  shape.rotCount++;
}
