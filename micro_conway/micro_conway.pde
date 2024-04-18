// Requires the processing built in sound library. //<>//
import processing.sound.*; //<>//
float b_width, text_scale;
int resolution, buff_size, old_rez, alive_count, alive_ratio;
String stage;
PFont mono;
TextBox[] rules = new TextBox[7];
CheckBox[] options = new CheckBox[5];
Slider volume;
Synth primary;
SoundFile music;

void setup() {
  // Window setup
  PImage icon = loadImage("icon.tiff");
  surface.setIcon(icon);
  mono = createFont("OCR A Extended", 128);
  textFont(mono);
  fullScreen();
  background(0);
  text_scale = width/2560.0;
  windowTitle("Playing God");
  frameRate = 60;
  
  // Gui init
  stage = "main";
  gui_init();
  
  // Sound init
  music = new SoundFile(this, "temp_music.mp3");
  music.amp(0.06);
  primary = new Synth();
  alive_ratio=0;
}


void draw() {
  // Rudimentary check to make sue music and generates sound cannot play simultaneously.
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
