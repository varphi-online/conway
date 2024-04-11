import processing.sound.*; //<>// //<>//
float b_width, text_scale;
int resolution, buff_size, old_rez, brush_size, alive_count, alive_ratio;
String stage;
PFont mono;
TextBox[] rules = new TextBox[6];
CheckBox[] options = new CheckBox[4];
Slider volume;
Synth primary;
SoundFile music;

void setup() {
  // Window setup
  background(0);
  mono = createFont("OCR A Extended", 128);
  textFont(mono);
  fullScreen();
  //size(1920,1080);
  text_scale = width/2560.0;
  windowTitle("Playing God");
  frameRate = 60;
  stage = "main";
  brush_size=1;
  gui_init();
  primary = new Synth();
  alive_ratio=0;
  music = new SoundFile(this, "temp_music.mp3");
  music.amp(0.06);
}


void draw() {
  music_handle();
  if (!options[1].value()&&!options[2].value()) {
    play_vars();
  } else {
    primary.halt();
  }

  if (stage == "main") {
    gui();
  } else if (stage == "play") {
    playPause();
    drawGrid();
    liveInput();
    back_update();
  }
}
