boolean[][] buffers; //<>// //<>//
int current_buffer;
float b_width,text_scale;
boolean m_debounce = false;
boolean keybounce = false;
boolean paused = true;
int step_time = 2; //frames between update
boolean mode;
int resolution, buff_size, old_rez, brush_size;
String stage;
TextBox[] rules = new TextBox[6];
PFont mono;
int underpop, overpop, birth, dist;

void setup() {
  // Window setup
  mono = createFont("OCR A Extended", 128);
  textFont(mono);
  fullScreen();
  text_scale = width/2560.0;
  windowTitle("Space to play/pause, click to edit.");
  frameRate = 60;
  stage = "main";
  brush_size=1;
  gui_init();
}


void draw() {
  if (stage == "main") {
    gui();
  } else if (stage == "play") {
    playPause();
    drawGrid();
    liveInput();
    back_update();
  }
}
