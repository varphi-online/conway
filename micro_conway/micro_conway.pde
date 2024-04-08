boolean[][] buffers;
int current_buffer; 
float b_width;
boolean m_debounce = false;
boolean keybounce = false;
boolean paused = true;
int step_time = 2; //frames between update
boolean mode;
int resolution, buff_size, old_rez;
String stage;
TextBox[] rules = new TextBox[6];
PFont mono;
int underpop,overpop,birth,dist;

void setup() {
// Window setup
mono = createFont("OCR A Extended", 128);
textFont(mono);
fullScreen();
windowTitle("Space to play/pause, click to edit.");
frameRate = 60;
stage = "main";
gui_init();
}


void draw(){
  if (stage == "main"){
    gui();
  } else if (stage == "play"){
    playPause(); //<>//
    drawGrid();
    liveInput();
    back_update();
  }
} //<>//
