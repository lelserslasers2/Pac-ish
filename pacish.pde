class Thing {
 
  int x;
  int y;
  int backX;
  int backY;
  int fillColor;
  
  Thing(int x, int y, int fillColor){
    this.x = x;
    this.y = y;
    this.backX = x;
    this.backY = y;
    this.fillColor = fillColor;
  }
  
  void drawThing(){
    fill(fillColor);
    rect(x, y, 10, 10);
  }
}

//VARS
boolean easyMode = false;

Thing pacman = new Thing(0, 0, #3cf024);
Thing coinOne = new Thing(50, 50, #DAA520);
Thing coinTwo = new Thing(coinOne.x + 10, coinOne.y, #DAA520);
Thing coinThree = new Thing(coinOne.x + 20, coinOne.y, #DAA520);
Thing coinFour = new Thing(coinOne.x, coinOne.y + 10, #DAA520);
Thing coinFive = new Thing(coinOne.x + 10, coinOne.y + 10, #DAA520);
Thing coinSix = new Thing(coinOne.x + 20, coinOne.y + 10, #DAA520);
Thing coinSeven = new Thing(coinOne.x, coinOne.y + 20, #DAA520);
Thing coinEight = new Thing(coinOne.x + 10, coinOne.y + 20, #DAA520);
Thing coinNine = new Thing(coinOne.x + 20, coinOne.y + 20, #DAA520);

ArrayList<Thing> stuffs = new ArrayList();

int direction = RIGHT;

//Code Starts

void setup(){
  size(500,500);
  frameRate(20);
  noStroke();
  
  stuffs.add(pacman);
  stuffs.add(coinOne);
  stuffs.add(coinTwo);
  stuffs.add(coinThree);
  stuffs.add(coinFour);
  stuffs.add(coinFive);
  stuffs.add(coinSix);
  stuffs.add(coinSeven);
  stuffs.add(coinEight);
  stuffs.add(coinNine);
}

void move(){
  if (direction == UP){
    pacman.y = pacman.y - 10;
  }
  else if (direction == DOWN){
    pacman.y = pacman.y + 10;
  }
  else if (direction == RIGHT){
    pacman.x = pacman.x + 10;
  }
  else if (direction == LEFT){
   pacman.x = pacman.x - 10;
  }
}

void draw(){
  
  background(#000000);
  
  move();
  
  for(int i = 0; i < stuffs.size(); i++){
    stuffs.get(i).drawThing();
  }
}

void logic(){
  if (pacman.x < 0){
    
  }
}

void keyPressed() {
  //Why can't I do direction = keyCode?
  if (key == CODED) {
    if (keyCode == UP) {
      direction = UP;
    }
    if (keyCode == DOWN) {
      direction = DOWN;
    }
    if (keyCode == RIGHT) {
      direction = RIGHT;
    }
    if (keyCode == LEFT) {
      direction = LEFT;
    }
  }
}
