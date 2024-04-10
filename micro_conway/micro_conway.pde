import processing.sound.*; //<>//
boolean[][] buffers; //<>//
int current_buffer;
float b_width,text_scale;
boolean m_debounce = false;
boolean keybounce = false;
boolean paused = true;
int step_time = 2; //frames betwe`en update
boolean mode;
int resolution, buff_size, old_rez, brush_size,alive_count,alive_ratio;
String stage;
TextBox[] rules = new TextBox[6];
Synth primary;
PFont mono;
int underpop, overpop, birth, dist;

void setup() {
  // Window setup
  mono = createFont("OCR A Extended", 128);
  textFont(mono);
  fullScreen(); 
  //size(1920,1080);
  text_scale = width/2560.0;
  windowTitle("Space to play/pause, click to edit.");
  frameRate = 60;
  stage = "main";
  brush_size=1;
  gui_init();
  primary = new Synth();
  alive_ratio=0;
}


void draw() {
  play_vars();
  if (stage == "main") {
    gui();
  } else if (stage == "play") {
    playPause();
    drawGrid();
    liveInput();
    back_update();
    println(alive_ratio);
    println(alive_count);
  }
}
