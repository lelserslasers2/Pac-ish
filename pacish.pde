//TO DO:
//-fix AI one move,and do it for other 2
//-add way to restart game
//-fix easy mode

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

boolean notLock = true;
int noBreak = 0;
boolean easyMode = false;

int score = 0;

Thing pacman = new Thing(10, 10, #3cf024);

Thing coinOne = new Thing(50, 50, #DAA520);
Thing coinTwo = new Thing(coinOne.x + 10, coinOne.y, #DAA520);
Thing coinThree = new Thing(coinOne.x + 20, coinOne.y, #DAA520);
Thing coinFour = new Thing(coinOne.x, coinOne.y + 10, #DAA520);
Thing coinFive = new Thing(coinOne.x + 10, coinOne.y + 10, #DAA520);
Thing coinSix = new Thing(coinOne.x + 20, coinOne.y + 10, #DAA520);
Thing coinSeven = new Thing(coinOne.x, coinOne.y + 20, #DAA520);
Thing coinEight = new Thing(coinOne.x + 10, coinOne.y + 20, #DAA520);
Thing coinNine = new Thing(coinOne.x + 20, coinOne.y + 20, #DAA520);

Thing badGuyOne = new Thing(40, 40, #cf0000);
Thing badGuyTwo = new Thing(40, 40, #cf0000);
Thing badGuyThree = new Thing(40, 40, #cf0000);

ArrayList<Thing> stuffs = new ArrayList();

int direction = RIGHT;


//Code Starts

void setup(){
  size(500,500);
  frameRate(20);
  noStroke();
  
  int a = (int)random(10, 480/10);
  a = a * 10;
  pacman.x = a;
  a = (int)random(10, 480/10);
  a = a * 10;
  pacman.y = a;
  stuffs.add(pacman);
  
  a = (int)random(10, 460/10);
  a = a * 10;
  coinOne.x = a;
  a = (int)random(10, 460/10);
  a = a * 10;
  coinOne.y = a;
  stuffs.add(coinOne);
  
  stuffs.add(coinTwo);
  stuffs.add(coinThree);
  stuffs.add(coinFour);
  stuffs.add(coinFive);
  stuffs.add(coinSix);
  stuffs.add(coinSeven);
  stuffs.add(coinEight);
  stuffs.add(coinNine);
  
  a = (int)random(10, 480/10);
  a = a * 10;
  badGuyOne.x = a;
  a = (int)random(10, 480/10);
  a = a * 10;
  badGuyOne.y = a;
  stuffs.add(badGuyOne);
  
  a = (int)random(10, 480/10);
  a = a * 10;
  badGuyTwo.x = a;
  a = (int)random(10, 480/10);
  a = a * 10;
  badGuyTwo.y = a;
  stuffs.add(badGuyTwo);
  
  a = (int)random(10, 480/10);
  a = a * 10;
  badGuyThree.x = a;
  a = (int)random(10, 480/10);
  a = a * 10;
  badGuyThree.y = a;
  stuffs.add(badGuyThree);
}



void coinMake(){
  coinTwo.x = coinOne.x + 10;
  coinTwo.y = coinOne.y;
  coinThree.x = coinOne.x + 20;
  coinThree.y = coinOne.y;
  coinFour.x = coinOne.x;
  coinFour.y = coinOne.y + 10;
  coinFive.x = coinOne.x + 10;
  coinFive.y = coinOne.y + 10;
  coinSix.x = coinOne.x + 20;
  coinSix.y = coinOne.y + 10;
  coinSeven.x = coinOne.x;
  coinSeven.y = coinOne.y + 20;
  coinEight.x = coinOne.x + 10;
  coinEight.y = coinOne.y + 20;
  coinNine.x = coinOne.x + 20;
  coinNine.y = coinOne.y + 20;
}



void drawEdge(){
 fill(#03a1fc);
 rect(0, 0, 500, 10);
 rect(0, 0, 10, 500);
 rect(0, 490, 500, 10);
 rect(490, 0, 10, 500);
}



void move(){
  if (direction == UP){
    pacman.backY = pacman.y;
    pacman.y = pacman.y - 10;
  }
  else if (direction == DOWN){
    pacman.backY = pacman.y;
    pacman.y = pacman.y + 10;
  }
  else if (direction == RIGHT){
    pacman.backX = pacman.x;
    pacman.x = pacman.x + 10;
  }
  else if (direction == LEFT){
   pacman.backX = pacman.x;
   pacman.x = pacman.x - 10;
  }
}



void draw(){
  if (notLock){
      if (noBreak == 1){
        delay(3000);
      }
    
    background(#000000);
    text("SCORE: " + score, 30, 20);
    drawEdge();
    
    badGuyOneMove();
    logic();
    move();
    
    coinMake();
  
    for(int i = 0; i < stuffs.size(); i++){
      stuffs.get(i).drawThing();
    }  
 
    noBreak = noBreak + 1;
    }
    else {
      text("GAME OVER", 30, 30);
    }
}



void badGuyOneMove(){
  int difX = badGuyOne.x - pacman.x;
  int difY = badGuyOne.y - pacman.y;
  
  if (abs(difX) > abs(difY)){
    if (difX > 0){
      badGuyOne.x = badGuyOne.x - 10;
    }
    else {
      badGuyOne.x = badGuyOne.x + 10;
    }
  }
  else {
    if (difY > 0){
      badGuyOne.y = badGuyOne.y - 10;
    }
    else {
      badGuyOne.y = badGuyOne.y + 10;
    }
  }
}



void logic(){
  if (easyMode){
    if (pacman.x < 10){
      pacman.x = pacman.backX;
      //pacman.y = pacman.backY;
    }
    if (pacman.x > 480){
      pacman.x = pacman.backX;
      //pacman.y = pacman.backY;
    }
    if (pacman.y < 10){
      //pacman.x = pacman.backX;
      pacman.y = pacman.backY;
    }
    if (pacman.x > 480){
      //pacman.x = pacman.backX;
      pacman.y = pacman.backY;
    }
  }
  else{
    if (pacman.x < 0){
      kill();
    }
    if (pacman.x > 480){
      kill();
    }
    if (pacman.y < 10){
      kill();
    }
    if (pacman.x > 480){
      kill();
    }
  }
  
  if (pacman.x == coinOne.x && pacman.y == coinOne.y){
    score = score + 100;
    moveCoin();
  }
  else if (pacman.x == coinTwo.x && pacman.y == coinTwo.y){
    score = score + 100;
    moveCoin();
  }
  else if (pacman.x == coinThree.x && pacman.y == coinThree.y){
    score = score + 100;
    moveCoin();
  }
  else if (pacman.x == coinFour.x && pacman.y == coinFour.y){
    score = score + 100;
    moveCoin();
  }
  else if (pacman.x == coinFive.x && pacman.y == coinFive.y){
    score = score + 100;
    moveCoin();
  }
  else if (pacman.x == coinSix.x && pacman.y == coinSix.y){
    score = score + 100;
    moveCoin();
  }
  else if (pacman.x == coinSeven.x && pacman.y == coinEight.y){
    score = score + 100;
    moveCoin();
  }
  else if (pacman.x == coinNine.x && pacman.y == coinNine.y){
    score = score + 100;
    moveCoin();
  }
  
  if (pacman.x == badGuyOne.x && pacman.y == badGuyOne.y){
    kill();
  }
  if (pacman.x == badGuyTwo.x && pacman.y == badGuyTwo.y){
    kill();
  }
  if (pacman.x == badGuyThree.x && pacman.y == badGuyThree.y){
    kill();
  }
  
}



void moveCoin(){
  int a = (int)random(10, 460/10);
  a = a * 10;
  coinOne.x = a;
  a = (int)random(10, 460/10);
  a = a * 10;
  coinOne.y = a;
}



void kill(){
  text("GAME OVER", 30, 30);
  notLock = false;
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
