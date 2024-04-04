boolean[][] buffers;
int current_buffer; 
int xpos, ypos;
float b_width;
int update;
boolean debounce = false;
boolean paused = true;
int step_time = 1; //frames between update
boolean mode;

int resolution = 1;

void setup() {
size(2300,1300);
windowTitle("Space to play/pause, click to edit.");
int buff_size = width*height/floor(pow(resolution,2));
buffers = new boolean[2][buff_size];
buffers[0] = new boolean[buff_size];
buffers[1] = new boolean[buff_size];
b_width = width/resolution;
frameRate = 120;
}

void draw(){
  if(!paused&&frameCount%step_time==0){
    if (current_buffer==0){ //<>//
      current_buffer = 1;
    } else {
      current_buffer = 0;
    }
  }
  
  drawGrid();
  liveInput();
} //<>//
