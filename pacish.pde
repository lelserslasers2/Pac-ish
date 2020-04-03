//VARS TO BE CHANGED (game preferences)
boolean easyMode = true;
int fps = 20;

//CLASSES

//main class for all the drawn objects/things
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


class Coin extends Thing { //class with functions for the coin
  
  ArrayList<Thing> coinParts;
  
  Coin(int x, int y, int fillColor){
    super(x, y, fillColor);
    this.coinParts = new ArrayList<Thing>();
  }
  
  void addPart(Thing newPart) {
    coinParts.add(newPart);
  }
  
  void makeCoin(){
    for (int i = 0; i < coinParts.size(); i = i + 1){ //NOTE: 0 is where old 2 is!
      if (i == 0){
        coinParts.get(i).x = x + 10;
        coinParts.get(i).y = y;
      }
      else if (i == 1){
        coinParts.get(i).x = x + 20;
        coinParts.get(i).y = y;
      }
      else if (i == 2){
        coinParts.get(i).x = x;
        coinParts.get(i).y = y + 10;
      }
      else if (i == 3){
        coinParts.get(i).x = x + 10;
        coinParts.get(i).y = y + 10;
      }
      else if (i == 4){
        coinParts.get(i).x = x + 20;
        coinParts.get(i).y = y + 10;
      }
      else if (i == 5){
        coinParts.get(i).x = x;
        coinParts.get(i).y = y + 20;
      }
      else if (i == 6){
        coinParts.get(i).x = x + 10;
        coinParts.get(i).y = y + 20;
      }
      else if (i == 7){
        coinParts.get(i).x = x + 20;
        coinParts.get(i).y = y + 20;
      }
    }
  }
  
  void moveCoin(){
    int a = (int)random(1, 460/10);
    a = a * 10;
    x = a;
    a = (int)random(1, 460/10);
    a = a * 10;
    y = a;
  }
  
}


class Ghost extends Thing { //the ghost class with bonus functions to control their movement
  
  Ghost(int x, int y, int fillColor){
    super(x, y, fillColor);
  }
  
  void attackMove(){
    //gets the differences in the x and y values
    int difX = x - pacman.x; 
    int difY = y - pacman.y;
    
    if (abs(difX) > abs(difY)){ //sees which gap is bigger, so cuts down the farthest dif
      if (difX > 0){ //if the dif is neg, has to go back, if pos, will keep going, tries to get both difs to 0
        x = x - 10;
      }
      else {
        x = x + 10;
      }
    }
    else {
      if (difY > 0){
        y = y - 10;
      }
      else {
        y = y + 10;
      }
    }
  }
  
  void guardMove(){
    //these difs will be used to find the hypotenuse
    int difX = x - pacman.x;
    int difY = y - pacman.y;
  
    float hypo = sqrt(sq(abs(difX)) + sq(abs(difY))); //the calc that finds the hypotenuse
    
    if (hypo <= 60){ //if we are close, do same thing as before and chase
      difX = x - pacman.x; //too lazy to make new names...
      difY = y - pacman.y;
    }
    else{//if we are sort of far away, play 'guard', tries to get into space between the pacman and the coin
      //same as before, execpt for the 'target' or the position after the '-' sign
      difX = x - (pacman.x + coinFive.x)/2; 
      difY = y - (pacman.y + coinFive.y)/2;
    }
    
    if (abs(difX) > abs(difY)){
      if (difX > 0){
        x = x - 10;
      }
      else {
        x = x + 10;
      }
    }
    else {
      if (difY > 0){
        y = y - 10;
      }
      else {
        y = y + 10;
      }
    }
  }
  
}

//MAIN VARS

boolean notLock = true;
int noBreak = 0;
int chance = 0;
int chanceTwo = 0;
int boosted = 0;
int score = 0;
boolean showStart = true;
boolean firstTime = true;

//the object that the player controls
Thing pacman = new Thing(10, 10, #3cf024);

//the coin is 3x3, so I needed 9 objects, 8 of them are all relative to the first's position
Coin coinOne = new Coin(50, 50, #DAA520);
Thing coinTwo = new Thing(coinOne.x + 10, coinOne.y, #DAA520);
Thing coinThree = new Thing(coinOne.x + 20, coinOne.y, #DAA520);
Thing coinFour = new Thing(coinOne.x, coinOne.y + 10, #DAA520);
Thing coinFive = new Thing(coinOne.x + 10, coinOne.y + 10, #DAA520);
Thing coinSix = new Thing(coinOne.x + 20, coinOne.y + 10, #DAA520);
Thing coinSeven = new Thing(coinOne.x, coinOne.y + 20, #DAA520);
Thing coinEight = new Thing(coinOne.x + 10, coinOne.y + 20, #DAA520);
Thing coinNine = new Thing(coinOne.x + 20, coinOne.y + 20, #DAA520);

//the ghosts, 1 and 2 chase the pacman, the 3rd plays 'guard'
Ghost badGuyOne = new Ghost(40, 40, #cf0000);
Ghost badGuyTwo = new Ghost(40, 40, #cf0000);
Ghost badGuyThree = new Ghost(40, 40, #cf0000);

//more modular, could easlily add more AI/ghosts b/c it's 'list-based-drawing' (TM)
ArrayList<Thing> stuffs = new ArrayList(); 

int direction = RIGHT;

//Code Starts

void setup(){
  size(500,500);
  frameRate(fps);
  noStroke();
  
  //randomizing starting positions, and adding each object to the list
  
  int a = (int)random(1, 480/10); //just a random number, 10 times smaller, then mulitply so I only have multiples of 10
  a = a * 10;
  pacman.x = a;
  a = (int)random(1, 480/10);
  a = a * 10;
  pacman.y = a;
  stuffs.add(pacman);
  
  moveCoin();
  stuffs.add(coinOne);
  
  stuffs.add(coinTwo);
  coinOne.addPart(coinTwo);
  stuffs.add(coinThree);
  coinOne.addPart(coinThree);
  stuffs.add(coinFour);
  coinOne.addPart(coinFour);
  stuffs.add(coinFive);
  coinOne.addPart(coinFive);
  stuffs.add(coinSix);
  coinOne.addPart(coinSix);
  stuffs.add(coinSeven);
  coinOne.addPart(coinSeven);
  stuffs.add(coinEight);
  coinOne.addPart(coinEight);
  stuffs.add(coinNine);
  coinOne.addPart(coinNine);
  
  a = (int)random(1, 480/10);
  a = a * 10;
  badGuyOne.x = a;
  a = (int)random(1, 480/10);
  a = a * 10;
  badGuyOne.y = a;
  stuffs.add(badGuyOne);
  
  a = (int)random(1, 480/10);
  a = a * 10;
  badGuyTwo.x = a;
  a = (int)random(1, 480/10);
  a = a * 10;
  badGuyTwo.y = a;
  stuffs.add(badGuyTwo);
  
  a = (int)random(1, 480/10);
  a = a * 10;
  badGuyThree.x = a;
  a = (int)random(1, 480/10);
  a = a * 10;
  badGuyThree.y = a;
  stuffs.add(badGuyThree);
}

//make sure the rest of the coin is attached to the 'head' of the coin
void coinMake(){
  coinOne.makeCoin();
}

//moves the pacman, like this so you are always moving, never stopping
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

//the function that runs every frame
void draw(){
  if (showStart){//shows the instuctions once
    startScreen(!firstTime);
  }
  else {
  if (notLock){ //if game ends, wait for 3 seconds, so player can see how they died
      if (noBreak == 1){//causes 3 second delay so player can see the starting positions of things
        delay(3000);
        firstTime = false;
      }
    //prints current score
    background(#000000);
    fill(#03a1fc);
    textSize(20);
    text("SCORE: " + score, 20, 20);
    
    move(); //moves teh pacman
    
    //the way the game increases in hardness as you get more points
    chance = (int)random(0, score/100); //random number, more points = better chance it will be higher
    
    if (noBreak % 2 == 0){ //every other, otherwise pacman can't turn without being caught
      badGuyOneMove();
      badGuyThreeMove();
    }
    else{ //alternates so ghost 1 and 2 can't be in the same square
      badGuyTwoMove(); 
    }
    
    for (int i = 0; i < chance; i = i + 1){ //create's 1/100 chance for every go, so if it goes 20 times, then 20/100 chance, causes the ghost's to 'boost' or move again
      chanceTwo = (int)random(0, 100);
      if (chanceTwo == 49){ 
        boosted = boosted + 1;
        badGuyOneMove();
        badGuyThreeMove();
        badGuyTwoMove(); 
        println("It's getting harder...Chance was about " + chance + "/100...Times boosted: " + boosted + "...");
      }
    }
    
    logic(); //does basic collision checking
    
    coinMake(); //makes sure the coin is together
  
    for(int i = 0; i < stuffs.size(); i++){ //draws it, probaly faster ways to do it, but this was easy
      stuffs.get(i).drawThing();
    }  
 
    noBreak = noBreak + 1; //game counter, used so that the pacman can be faster, but other things still run
    }
    else { //if game ends, wait for 3 seconds, so player can see how they died
      fill(#03a1fc);
      text("GAME OVER", 20, 40);
      delay(3000);
      restart(); //restart function
      showStart = true;
    }
  }
}

//the instuction screen
void startScreen(boolean showScore){
  background(#000000);
  fill(#03a1fc);
  textSize(100);
  text("PAC-ISH", 50, 100);
  textSize(40);
  text("you are the green.", 75, 150);
  text("use wasd, the arrow keys, ", 10, 185);
  text("or hjkl to move.", 85, 220);
  text("the goal is to get", 75, 255);
  text("the coin (Gold square).", 40, 290);
  text("avoid the bad guys", 75, 325);
  text("(the red squares).", 75, 360);
  textSize(20);
  text("Press 'Enter' to start.", 135, 400);
  text("Game will start in 3 seconds after 'Enter' is pressed", 3, 425);
  text("Press 'ESC' to close.", 140, 450);
  if (showScore){
    text("Score: " + score, 185, 475);
  }
}

//resets all the vars, so after you die, you can play again
void restart(){
  
  println("Restarting in 3...");
  
  noBreak = 0;
  notLock = true;
  direction = RIGHT;
  chance = 0;
  boosted = 0;
  
  int a = (int)random(10, 480/10);
  a = a * 10;
  pacman.x = a;
  a = (int)random(1, 480/10);
  a = a * 10;
  pacman.y = a;
  
  moveCoin();
  
  a = (int)random(1, 480/10);
  a = a * 10;
  badGuyOne.x = a;
  a = (int)random(1, 480/10);
  a = a * 10;
  badGuyOne.y = a;
  
  a = (int)random(1, 480/10);
  a = a * 10;
  badGuyTwo.x = a;
  a = (int)random(1, 480/10);
  a = a * 10;
  badGuyTwo.y = a;
  
  a = (int)random(1, 480/10);
  a = a * 10;
  badGuyThree.x = a;
  a = (int)random(1, 480/10);
  a = a * 10;
  badGuyThree.y = a;
}
//Even tho it runs 1 line, it is it's own function so I can quickly change the way they move in 1 place
//controls the first ghost's movement
void badGuyOneMove(){
  badGuyOne.attackMove();
}
//same as ghost 1
void badGuyTwoMove(){
  badGuyTwo.attackMove();
}
//play's 'guard', if close runs at pacman, otherwise, runs inbetween pacman and coin
void badGuyThreeMove(){
  badGuyThree.guardMove();
}

//the logic function, only called once per draw, but I find it nicer to put it in it's own function, does the basic 'hitbox' checking
void logic(){
  //if you go out of bounds
  if (easyMode){ //is easy mode, just stop when running into a wall, otherwise die
    if (pacman.x < 0){
      pacman.x = pacman.backX;
    }
    else if (pacman.x > 490){
      pacman.x = pacman.backX;
    }
    else if (pacman.y < 0){
      pacman.y = pacman.backY;
    }
    else if (pacman.y > 490){
      pacman.y = pacman.backY;
    }
  }
  else{
    if (pacman.x < 0){
      kill();
    }
    else if (pacman.x > 490){
      kill();
    }
    else if (pacman.y < 0){
      kill();
    }
    else if (pacman.y > 490){
      kill();
    }
  }
  
  //getting the coin
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
  
  //dying to ghost
  if (pacman.x == badGuyOne.x && pacman.y == badGuyOne.y){
    kill();
  }
  else if (pacman.x == badGuyTwo.x && pacman.y == badGuyTwo.y){
    kill();
  }
  else if (pacman.x == badGuyThree.x && pacman.y == badGuyThree.y){
    kill();
  }
}

//own function even tho it's one line so I could make changes in one place
void moveCoin(){
  coinOne.moveCoin();
}

//just needed to use this multiple times
void kill(){
  fill(#03a1fc);
  text("GAME OVER", 20, 40);
  notLock = false;
  println("OOF! You died!");
}

//the controls, can use arrow keys or wasd, or hjkl
void keyPressed() {
  //Why can't I do direction = keyCode?
  if (key == CODED) {
    if (keyCode == UP) {
      direction = UP;
    }
    else if (keyCode == DOWN) {
      direction = DOWN;
    }
    else if (keyCode == RIGHT) {
      direction = RIGHT;
    }
    else if (keyCode == LEFT) {
      direction = LEFT;
    }
  }
  else{
    if (key == 'w') {
      direction = UP;
    }
    else if (key == 's') {
      direction = DOWN;
    }
    else if (key == 'd') {
      direction = RIGHT;
    }
    else if (key == 'a') {
      direction = LEFT;
    }
    
    else if (key == 'k') {
      direction = UP;
    }
    else if (key == 'j') {
      direction = DOWN;
    }
    else if (key == 'l') {
      direction = RIGHT;
    }
    else if (key == 'h') {
      direction = LEFT;
    }
    
    else if (key == 'r'){ //was for testing
      showStart = false;
      println("Starting in 3...");
      score = 0;
    }
  }
  
  if (keyCode == ENTER){ // start the game
    showStart = false;
    println("Starting in 3...");
    score = 0;
  }
}
