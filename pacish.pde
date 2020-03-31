//VARS TO BE CHANGED (game preferences)
boolean easyMode = true;
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

//MAIN VARS

boolean notLock = true;
int noBreak = 0;
int chance = 0;
int chanceTwo = 0;
int boosted = 0;
int score = 0;

//the object that the player controls
Thing pacman = new Thing(10, 10, #3cf024);

//the coin is 3x3, so I needed 9 objects, 8 of them are all relative to the first's position
Thing coinOne = new Thing(50, 50, #DAA520);
Thing coinTwo = new Thing(coinOne.x + 10, coinOne.y, #DAA520);
Thing coinThree = new Thing(coinOne.x + 20, coinOne.y, #DAA520);
Thing coinFour = new Thing(coinOne.x, coinOne.y + 10, #DAA520);
Thing coinFive = new Thing(coinOne.x + 10, coinOne.y + 10, #DAA520);
Thing coinSix = new Thing(coinOne.x + 20, coinOne.y + 10, #DAA520);
Thing coinSeven = new Thing(coinOne.x, coinOne.y + 20, #DAA520);
Thing coinEight = new Thing(coinOne.x + 10, coinOne.y + 20, #DAA520);
Thing coinNine = new Thing(coinOne.x + 20, coinOne.y + 20, #DAA520);

//the ghosts, 1 and 2 chase the pacman, the 3rd plays 'guard'
Thing badGuyOne = new Thing(40, 40, #cf0000);
Thing badGuyTwo = new Thing(40, 40, #cf0000);
Thing badGuyThree = new Thing(40, 40, #cf0000);

//more modular, could easlily add more AI/ghosts b/c it's 'list-based-drawing' (TM)
ArrayList<Thing> stuffs = new ArrayList(); 

int direction = RIGHT;

//Code Starts

void setup(){
  size(500,500);
  frameRate(20);
  noStroke();
  
  //randomizing starting positions, and adding each object to the list
  
  int a = (int)random(1, 480/10); //just a random number, 10 times smaller, then mulitply so I only have multiples of 10
  a = a * 10;
  pacman.x = a;
  a = (int)random(1, 480/10);
  a = a * 10;
  pacman.y = a;
  stuffs.add(pacman);
  
  a = (int)random(1, 460/10);
  a = a * 10;
  coinOne.x = a;
  a = (int)random(1, 460/10);
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
  
  println("Starting in 3...");
}

//make sure the rest of the coin is attached to the 'head' of the coin
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
  if (notLock){ //if game ends, wait for 3 seconds, so player can see how they died
      if (noBreak == 1){//causes 3 second delay so player can see the starting positions of things
        delay(3000);
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
    }
}

//resets all the vars, so after you die, you can play again
void restart(){
  
  println("Restarting in 3...");
  
  score = 0;
  noBreak = 0;
  notLock = true;
  direction = RIGHT;
  chance = 0;
  
  int a = (int)random(10, 480/10);
  a = a * 10;
  pacman.x = a;
  a = (int)random(1, 480/10);
  a = a * 10;
  pacman.y = a;
  
  a = (int)random(1, 460/10);
  a = a * 10;
  coinOne.x = a;
  a = (int)random(1, 460/10);
  a = a * 10;
  coinOne.y = a;
  
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

//controls the first ghost's movement
void badGuyOneMove(){
  //gets the differences in the x and y values
  int difX = badGuyOne.x - pacman.x; 
  int difY = badGuyOne.y - pacman.y;
  
  if (abs(difX) > abs(difY)){ //sees which gap is bigger, so cuts down the farthest dif
    if (difX > 0){ //if the dif is neg, has to go back, if pos, will keep going, tries to get both difs to 0
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
//same as ghost 1, just with the word 'Two' instead of 'One'
void badGuyTwoMove(){
  int difX = badGuyTwo.x - pacman.x;
  int difY = badGuyTwo.y - pacman.y;
  
  if (abs(difX) > abs(difY)){
    if (difX > 0){
      badGuyTwo.x = badGuyTwo.x - 10;
    }
    else {
      badGuyTwo.x = badGuyTwo.x + 10;
    }
  }
  else {
    if (difY > 0){
      badGuyTwo.y = badGuyTwo.y - 10;
    }
    else {
      badGuyTwo.y = badGuyTwo.y + 10;
    }
  }
}
//play's 'guard', if close runs at pacman, otherwise, runs inbetween pacman and coin
void badGuyThreeMove(){
  //these difs will be used to find the hypotenuse
  int difX = badGuyThree.x - pacman.x;
  int difY = badGuyThree.y - pacman.y;
  
  float hypo = sqrt(sq(abs(difX)) + sq(abs(difY))); //the calc that finds the hypotenuse
    
  if (hypo <= 60){ //if we are close, do same thing as before and chase
    difX = badGuyThree.x - pacman.x;
    difY = badGuyThree.y - pacman.y;
  }
  else{//if we are sort of far away, play 'guard', tries to get into space between the pacman and the coin
    //same as before, execpt for the 'target' or the position after the '-' sign
    difX = badGuyThree.x - (pacman.x + coinFive.x)/2; 
    difY = badGuyThree.y - (pacman.y + coinFive.y)/2;
  }
  
  if (abs(difX) > abs(difY)){
    if (difX > 0){
      badGuyThree.x = badGuyThree.x - 10;
    }
    else {
      badGuyThree.x = badGuyThree.x + 10;
    }
  }
  else {
    if (difY > 0){
      badGuyThree.y = badGuyThree.y - 10;
    }
    else {
      badGuyThree.y = badGuyThree.y + 10;
    }
  }
}

//the logic function, only called once per draw, but I find it nicer to put it in it's own function, does the basic 'hitbox' checking
void logic(){
  //if you go out of bounds
  if (easyMode){ //is easy mode, just stop when running into a wall, otherwise die
    if (pacman.x < 0){
      pacman.x = pacman.backX;
      //pacman.y = pacman.backY;
    }
    if (pacman.x > 490){
      pacman.x = pacman.backX;
      //pacman.y = pacman.backY;
    }
    if (pacman.y < 0){
      //pacman.x = pacman.backX;
      pacman.y = pacman.backY;
    }
    if (pacman.y > 490){
      //pacman.x = pacman.backX;
      pacman.y = pacman.backY;
    }
  }
  else{
    if (pacman.x < 0){
      kill();
    }
    if (pacman.x > 490){
      kill();
    }
    if (pacman.y < 0){
      kill();
    }
    if (pacman.y > 490){
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
  if (pacman.x == badGuyTwo.x && pacman.y == badGuyTwo.y){
    kill();
  }
  if (pacman.x == badGuyThree.x && pacman.y == badGuyThree.y){
    kill();
  }
}

//had to use this multiple times, so... put it in a fucntion, just moves the coin, only need to move the 'head' coin b/c rest will follow
void moveCoin(){
  int a = (int)random(1, 460/10);
  a = a * 10;
  coinOne.x = a;
  a = (int)random(1, 460/10);
  a = a * 10;
  coinOne.y = a;
}

//just needed to use this multiple times
void kill(){
  fill(#03a1fc);
  text("GAME OVER", 20, 40);
  notLock = false;
  println("OOF! You died!");
}

//the controls, can use arrow keys or wasd
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
  else{
    if (key == 'w') {
      direction = UP;
    }
    if (key == 's') {
      direction = DOWN;
    }
    if (key == 'd') {
      direction = RIGHT;
    }
    if (key == 'a') {
      direction = LEFT;
    }
  }
}
