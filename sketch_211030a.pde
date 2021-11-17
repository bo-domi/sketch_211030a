class Player{
  public float x;
  public float y;
  public float width;
  public float height;
  public float velocityX;
  public float velocityY;
}
PImage playerImage;
Player player;
class Input{
  public boolean space;
  public boolean left;
  public boolean right;
}
Input input;
class Block{
  public float x;
  public float y;
  public float width;
  public float height;
  public int type;
}
Block[] blocks;
class Camera{
  public float x;
  public float y;
}
Camera camera;
PImage haikei;
void setup(){
  size(600, 400);
  playerImage = loadImage("fusen2.png");
  player = new Player();
  player.width = 50;
  player.height = 50;
  player.x = 300 - 25;
  player.y = 200 - 15;
  input = new Input();
  blocks = new Block[50];
  blocks[0] = new Block();
  blocks[0].width = 100;
  blocks[0].height = 30;
  blocks[0].x = 300 - 50;
  blocks[0].y = 300 - 15;
  blocks[0].type = 1;
  blocks[1] = new Block();
  blocks[1].width = 100;
  blocks[1].height = 30;
  blocks[1].x = 100;
  blocks[1].y = 100;
  blocks[1].type = 3;
  blocks[2] = new Block();
  blocks[2].width = 150;
  blocks[2].height = 20;
  blocks[2].x = 100;
  blocks[2].y = 150;
  blocks[2].type = 2;
  blocks[3] = new Block();
  blocks[3].width = 20;
  blocks[3].height = 150;
  blocks[3].x = 350;
  blocks[3].y = 500;
  blocks[3].type = 2;
  blocks[4] = new Block();
  blocks[4].width = 300;
  blocks[4].height = 20;
  blocks[4].x = 350;
  blocks[4].y = 400;
  blocks[4].type = 2;
  blocks[5] = new Block();
  blocks[5].width = 200;
  blocks[5].height = 20;
  blocks[5].x = 500;
  blocks[5].y = 300;
  blocks[5].type = 2;
  blocks[6] = new Block();
  blocks[6].width = 20;
  blocks[6].height = 50;
  blocks[6].x = 500;
  blocks[6].y = 265;
  blocks[6].type = 2;
  blocks[7] = new Block();
  blocks[7].width = 100;
  blocks[7].height = 20;
  blocks[7].x = 700;
  blocks[7].y = 150;
  blocks[7].type = 2;
  blocks[8] = new Block();
  blocks[8].width = 20;
  blocks[8].height = 350;
  blocks[8].x = 500;
  blocks[8].y = -200;
  blocks[8].type = 2;
  blocks[9] = new Block();
  blocks[9].width = 20;
  blocks[9].height = 350;
  blocks[9].x = 580;
  blocks[9].y = -200;
  blocks[9].type = 2;
  blocks[10] = new Block();
  blocks[10].width = 20;
  blocks[10].height = 350;
  blocks[10].x = 450;
  blocks[10].y = -300;
  blocks[10].type = 2;
  camera = new Camera();
  camera.x = player.x - 200;
  camera.y = player.y - 200;
  haikei = loadImage("sora.jpeg");
  noStroke();
} 
boolean isClear = false;
void draw(){
  background(255);
  image(haikei, 0, 0, width, height);
  if(input.space){
    player.velocityY -=0.2;
  }
  if(input.left){
    player.velocityX -= 0.1;
  }
  if(input.right){
    player.velocityX += 0.1;
  }
  player.velocityY += 0.1;
  player.velocityX *= 0.98;
  float prevX = player.x;
  float prevY = player.y;
  player.y += player.velocityY;
  player.x += player.velocityX;
  for(int i = 0; i < blocks.length; i++){
    Block b = blocks[i];
    if(b != null){
      boolean isHit =
        isHit(player.x, player.y, player.width, player.height,
              b.x, b.y, b.width, b.height);
      if (b.type == 1) {
        if(isHit){
          player.x = prevX;
          player.y = prevY;
          player.velocityX = 0;
          player.velocityY = 0;
        }
        fill(0, 255, 0);
      }
      if (b.type == 2) {
        if (isHit) {
          initPlayer();
        }
        fill(255, 255, 0);
      }
      if (b.type == 3) {
        if (isHit) {
          player.x = prevX;
          player.y = prevY;
          player.velocityX = 0;
          player.velocityY = 0;
          if(player.y < b.y){
            isClear = true;
          }
        }
        fill(0, 0, 255);
      }
     rect(getDisplayX(b.x), getDisplayY(b.y), b.width, b.height);
    }
  }
  image(playerImage, getDisplayX(player.x), getDisplayY(player.y),
        player.width ,player.height);
  camera.x = player.x - 200;
  camera.y = player.y - 200;
  camera.x = clamp(camera.x, 100, 150);
  camera.y = clamp(camera.y, 100, 150);
  float dispX = getDisplayX(player.x);
  float dispY = getDisplayY(player.y);
  if(dispX < 0 - player.width || dispX > width){
    initPlayer();
  }
  if(dispY < 0 - player.height || dispY > height){
    initPlayer();
  }
  if(isClear){
    fill(0, 0, 0, 100);
    rect(0, 0, width, height);
    fill(255);
    textAlign(CENTER);
    text("GAME CLEAR", width / 2, height / 2);
  }
}
void keyPressed(){
  if(key == ' '){
    input.space = true;
  }
  if(keyCode == RIGHT){
    input.right = true;
  }
  if(keyCode == LEFT){
    input.left = true;
  }
}
void keyReleased(){
  if(key == ' '){
    input.space = false;
  }
  if(keyCode == RIGHT){
    input.right = false;
  }
  if(keyCode == LEFT){
    input.left = false;
  }
}
boolean isHit(float px, float py, float pw, float ph,
              float bx, float by, float bw, float bh){
  float centerPx = px + pw / 2;
  float centerPy = py + ph / 2;
  float centerBx = bx + bw / 2;
  float centerBy = by + bh / 2;
  if(abs(centerPx - centerBx) < pw / 2 + bw / 2){
    if(abs(centerPy - centerBy) < ph / 2 + bh / 2){
      return true;
    }
  }
  return false;
}
float getDisplayX(float x){
  return x - camera.x;
}
float getDisplayY(float y){
  return y - camera.y;
}
float clamp(float value, float min, float max){
  if(value < min){
    value = min;
  }
  if(value > max){
    value = max;
  }
  return value;
}
void initPlayer(){
  player.x = 300 - 25;
  player.y = 200 - 15;
  player.velocityX = 0;
  player.velocityY = 0;
}
