boolean[][] buffers;
int current_buffer; 
float b_width;
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

for (int i = 0; i <= b_width; i ++){
  buffers[0][i+((height/resolution)/2)*int(b_width)] = true;
  buffers[1][i] = true;
}

frameRate = 120;
}


void draw(){
  playPause(); //<>//
  drawGrid();
  liveInput();
} //<>//
