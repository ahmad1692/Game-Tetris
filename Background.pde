public class Background {
    private int[][][] colors;
    private int r, g, b;
    private int w;
    private int theX, theY;
    private int score;
    private int comboMultiplier;
    private boolean gameWon = false;
    private Shape s;
    
    public Background() {
        colors = new int[12][24][3];
        w = width / 24;
        comboMultiplier = 1;
        s = new Shape(); 
    }

    // Write the method to draw a rectangle FOR every x,y using the colors RGB
    public void display() {
        for (int i = 0; i < 12; i++) {
            for (int j = 0; j < 24; j++) {
                r = colors[i][j][0];
                g = colors[i][j][1];
                b = colors[i][j][2];
                fill(r, g, b);
                rect(i * w, j * w, w, w);
            }
        }

        int totalLinesRemoved = 0;  // Track the total lines removed in a single iteration

        for (int i = 0; i < 24; i++) {
            if (checkLine(i)) {
                removeLine(i);
                totalLinesRemoved++;
            }
        }

        if (totalLinesRemoved > 0) {
            // Calculate the score based on lines removed and combo multiplier
            score += 10 * (1 << (totalLinesRemoved - 1));
            comboMultiplier *= 2;  // Double the combo multiplier
        } else {
            comboMultiplier = 1;  // Reset the combo multiplier if no lines were removed
        }
       boolean shapeReachedTop = false;
    for (int i = 0; i < 23; i++) {
        theX = s.theShape[i][0];
        theY = s.theShape[i][1];
        if (theY <= 0) {
            shapeReachedTop = true;
            break;
        }
    }
        if (shapeReachedTop && !isShapeStillFalling()) {
        // Game over! Display message
        textAlign(CENTER, CENTER);
        textSize(32);
        fill(255, 0, 0);
        text("Game Over", width / 4, height / 2);
        noLoop(); // Stop the game loop
        
    } else if (score >= 1000 && !gameWon) {
            // You win! Display congratulations message
            textAlign(CENTER, CENTER);
            textSize(32);
            fill(255, 255, 255);
            text("Congratulations! You Win!", width / 4, height / 2);
            noLoop(); // Stop the game loop when the player wins
            gameWon = true;
        }
         
    }
    private int countLinesRemoved() {
        int linesRemoved = 0;
        for (int i = 0; i < 24; i++) {
            if (checkLine(i)) {
                linesRemoved++;
            }
        }
        return linesRemoved;
    }

    public void writeShape(Shape s) {
        // get theX and theY of each block
        for (int i = 0; i < 4; i++) {
            theX = s.theShape[i][0];
            theY = s.theShape[i][1];
            // Write the colors of the shape into these x,y values
            colors[theX][theY][0] = s.r;
            colors[theX][theY][1] = s.g;
            colors[theX][theY][2] = s.b;
        }
    }

    // Periksa baris lengkap (boolean)
    public boolean checkLine(int row) {
        for (int i = 0; i < 12; i++) {
            if (colors[i][row][0] == 0 && colors[i][row][1] == 0 && colors[i][row][2] == 0) {
                return false;
            }
        }
        return true;
    }

    // Hapus Garis (jika penuh)
  public void removeLine(int row) {
    int[][][] newBackground = new int[12][24][3];

    // Check if all the blocks in the row have the same color
    boolean sameColor = true;
    for (int j = 0; j < 12; j++) {
        for (int a = 0; a < 3; a++) {
            if (colors[j][row][a] != colors[0][row][a]) {
                sameColor = false ;
                break;
            }
        }
        if (!sameColor) {
            break;
        }
    }

    // Jika semua balok memiliki warna yang sama, garis tersebut akan dihilangkan seluruhnya
    if (sameColor) {
        // Shift the values above the specified row down by one, excluding the row itself
        for (int r = row; r >= 1; r--) {
            for (int j = 0; j < 12; j++) {
                newBackground[j][r][0] = colors[j][r - 1][0];
                newBackground[j][r][1] = colors[j][r - 1][1];
                newBackground[j][r][2] = colors[j][r - 1][2];
            }
        }

        // Hapus baris atas (atur warna ke 0)
        for (int j = 0; j < 12; j++) {
            newBackground[j][0][0] = 0;
            newBackground[j][0][1] = 0;
            newBackground[j][0][2] = 0;
        }
    } else {
        //Jika warnanya tidak sama, lakukan penghapusan standar tanpa mengosongkan baris atas
        for (int i = 0; i < 12; i++) {
            for (int j = 23; j > row; j--) {
                for (int a = 0; a < 3; a++) {
                    newBackground[i][j][a] = colors[i][j][a];
                }
            }
        }

        // Geser nilai di atas baris yang ditentukan ke bawah satu per satu
        for (int r = row; r >= 1; r--) {
            for (int j = 0; j < 12; j++) {
                newBackground[j][r][0] = colors[j][r - 1][0];
                newBackground[j][r][1] = colors[j][r - 1][1];
                newBackground[j][r][2] = colors[j][r - 1][2];
            }
        }
    }

    // Assign the new array back to the original array
    colors = newBackground;
}
// Check if the current shape is still falling
private boolean isShapeStillFalling() {
    for (int i = 0; i < 2; i++) {
        theX = s.theShape[i][0];
        theY = s.theShape[i][1];
        // Check if the block below the current shape is not empty
        if (theY < 23 && (colors[theX][theY + 1][0] == 0 && colors[theX][theY + 1][1] == 0 && colors[theX][theY + 1][2] == 0)) {
            return true;
        }
    }
    return false;
}
private boolean isGameOver() {
    for (int i = 0; i < 12; i++) {
        if (colors[i][0][0] != 0 || colors[i][0][1] != 0 || colors[i][0][2] != 0) {
            return true;
        }
    }
    return false;
}
public int getScore() {
        return score;
    }

}
