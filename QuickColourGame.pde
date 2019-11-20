final color RED = #D12020;
int[] colors = {RED,#515DD8,#21AF20, #F5EF74, #F59219, #B219F5,#FFFFFF};
int[] girdColours = new int[8*12];
int activeCell = -1;
int activeCol = -1;
int activeRow = -1;
PImage target;
int numMoves = 0;
String filename;

void setup(){
  size(800,800);
  String[] images = {"target0.png","target1.png","target2.png","target3.png","target4.png"};
  filename = images[(int)random(0,5)]; // create filename
  target = loadImage(filename); // load image file into off-screen buffer
  image(target, 420, 100); // display the buffer on canvas at location x, y
}
void draw(){
  background(0);
  stroke(200);
  image(target, 420, 100);
  drawColorWalls();
  drawColouringGrid();
  fill(255);
  text(numMoves,500,500);
  noFill();
}

void drawColouringGrid(){
  noFill();
  int count = 0;
  for(int i=0; i< 12; i++)
    for(int j=0; j<8; j++){
      if(girdColours[count]!=0)
        fill(girdColours[count]);
      rect(100+j*30,100+i*30,30,30);
      noFill();
      count++;
    }
  if(activeCell != -1){
    int row = activeCell/8;
    int col = activeCell%8;
    stroke(RED);
    rect(100+col*30,100+row*30,30,30);
    stroke(200);
  }
  
}

void drawColorWalls(){
  int slength = 30;
  int sSpace = 30;
  int x = 30;
  int y = 0;
  for(int i=0; i<7; i++){
    fill(colors[i]);
    rect(x+i*sSpace, y, slength, slength);
  }
}

void mouseClicked(){
  int x = mouseX;
  int y = mouseY;
  ellipse(x,y,50,50);
  if(x>=100 && x<= 340 && y>=100 && y<=460){
    activeCell = getActiveCell();
  }
  checkColourSelection();
}

void checkColourSelection(){
  int x = mouseX;
  int y = mouseY;
  if(x>=30 && x<=210 && y>=0 && y<=30){
    int index = (x-30)/30;
    int colour = colors[index];
    boolean changed = false;
    if(activeCell!=-1){
      girdColours[activeCell] = colour;
      activeCell = -1;
      changed = true;
    }
    if(activeCol!=-1){
      int startIndex = activeCol;
      for(int i=0; i<12; i++)
        girdColours[startIndex + i*8] = colour;
      activeCol = -1;
      changed = true;
    }
    if(activeRow!=-1){
      int startIndex = activeRow * 8;
      for(int i=0; i<8; i++)
        girdColours[startIndex+i] = colour;
      changed = true;
      activeRow = -1;
    }
    
    if(changed)
      numMoves++;
  }
}

int getActiveCell(){
  int x = mouseX;
  int y = mouseY;
  int selectCell = -1;
  if(x>=100 && x<= 340 && y>=100 && y<=460){
    int row = (y-100)/30;
    int col = (x-100)/30;
    selectCell = row*8 + col;
    if(activeCell == selectCell)
      selectCell = -1;
  }
  return selectCell;
}
