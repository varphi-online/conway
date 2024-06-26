class TextBox {
  /*
  Acts as an interactive, one character user input, or is hardcoded to be a button that starts
   the simulation. Marked by a flag in the constructor.
   */
  int x, y, size_x, size_y;
  String default_text, text;
  boolean render, Focused, button, hovered;
  public boolean starting;

  TextBox(int c_x, int c_y, int c_size_x, int c_size_y, String c_default_text, boolean stat) {
    x = c_x;
    y = c_y;
    size_x = c_size_x;
    size_y = c_size_y;
    default_text = c_default_text;
    text = c_default_text;
    Focused = false;
    button = stat;
  }

  void render() {
    strokeWeight(0);
    fill(255);
    rect(x, y, size_x, size_y);
    fill(0);
    textSize(size_y);
    text(text, x+size_y/5, y+(size_y)-(0.17*size_y));
  }

  void update() {
    if (mouseX>=x&&mouseX<=x+size_x&&mouseY>=y&&mouseY<=y+size_y) {
      hovered = true;
    } else {
      hovered = false;
    }
    if (mousePressed) {
      Focused = hovered;
      text = hovered&&!button&&stage=="main" ? "": text;
    }
    // Other
    if (Focused&&!button) {
      if (keyPressed&&!keybounce) {
        if (text.length()<int((size_x*2)/size_y)-1&&key != CODED && isNumeric(str(key))) {
          text = text + key;
        }
      }
    } else if (Focused && button) {
      Start();
    }
  }

  void Start() {
    starting = true;
    stage = "play";
    dist = rules[0].value();
    underpop = rules[1].value();
    overpop = rules[2].value();
    birth = rules[3].value();
    resolution = rules[4].value();
    step_time = ceil(pow(1.6, rules[6].value()));
    if (resolution != old_rez) {
      life_setup();
      old_rez = resolution;
    }
    Focused = false;
  }

  // Getters
  public float y_pos() {
    return y+(size_y)-(0.35*size_y);
  }

  int value() {
    return text!="" ? int(text): int(default_text);
  }

  // Setters
  int set_value(int num) {
    text = str(num);
    return 0;
  }
}

class CheckBox {
  /*
  A simple interactive check box with an optional flag for being a dice Icon.
   */
  int x, y, size;
  String text;
  boolean hovered, default_state, on, die;
  int border_size = 3;

  CheckBox(int c_x, int c_y, int c_size, boolean c_default_state, String c_text, boolean ... c_die) {
    x = c_x;
    y = c_y;
    size = c_size;
    default_state = c_default_state;
    on = default_state;
    text = c_text;
    if (c_die.length>0) {
      die = c_die[0];
    }
  }


  void render() {
    int dot_size = size/7;
    if (!die) {
      strokeWeight(0);
      fill(255);
      rect(x, y, size, size);
      fill(0);
      if (on) {
        rect(x+text_scale*border_size, y+text_scale*border_size, size-text_scale*border_size*2, size-text_scale*border_size*2);
      }
      textAlign(CENTER);
      fill(255);
      textSize(size/1.5);
      text(text, x+size/2, y-30);
    } else {
      fill(255);
      rect(x, y, size, size);
      fill(0);
      rect(x+text_scale*border_size, y+text_scale*border_size, size-text_scale*border_size*2, size-text_scale*border_size*2);
      fill(255);
      println(dot_size);
      circle(x+(size/2.0), y+(size/2.0), dot_size);
      circle(x+(size/2)-(size/4), y+(size/2)-(size/4), dot_size);
      circle(x+(size/2)+(size/4), y+(size/2)-(size/4), dot_size);
      circle(x+(size/2)-(size/4), y+(size/2)+(size/4), dot_size);
      circle(x+(size/2)+(size/4), y+(size/2)+(size/4), dot_size);
    }
  }

  void update() {
    if (mouseX>=x&&mouseX<=x+size&&mouseY>=y&&mouseY<=y+size) {
      if (!m_debounce&&mousePressed&&stage=="main") {
        if (!die) {
          on = !on;
        } else {
          // Sets all values for simulation to random numbers, selected to avoid flashing iterations.
          dist = rules[0].set_value(round(random(0, 4)));
          underpop = rules[1].set_value(round(random(0, 7)));
          overpop = rules[2].set_value(round(random(4, 9)));
          birth = rules[3].set_value(round(random(1, 8)));
          rules[0].Start();
          
          // Only reset the state if all cells are dead.
          int alive = buff_size;
          for (int i = 0; i < buff_size; i++) {
            if (!buffers[0][i] && !buffers[1][i]) {
              alive-=1;
            }
          }
          if (alive<=0) {
            reset();
          }
          paused = false;
        }
        m_debounce = true;
      }
    }
  }

  // Setter
  boolean value() {
    return on;
  }
}

class Slider {
  /*
  This probably didn't need to be a class as it's not instantiated, but if it ever does...
   */
  int x, y, len;
  String text;
  boolean hovered;
  int border_size = 3;
  float default_pos, position;

  Slider(int c_x, int c_y, int c_len, float c_default_pos, String c_text) {
    x = c_x;
    y = c_y;
    len = c_len;
    default_pos = c_default_pos;
    position = default_pos;
    text = c_text;
  }

  void render() {
    stroke(255);
    strokeWeight(4);
    line(x, y, x+len, y);
    strokeWeight(0);
    circle(x+position*len, y, 15*text_scale);
    fill(0);
    circle(x+position*len, y, 10*text_scale);
    textAlign(CENTER);
    fill(255);
    textSize(30/1.5);
    text(text, x+len/2, y-30);
  }

  float value() {
    return position;
  }

  boolean dragging = false;

  void stopped_interaction() {
    dragging = false;
  }

  void update() {
    if (dist(mouseX, mouseY, x+position*len, y)<30||dragging) {
      if (mousePressed&&stage=="main") {
        dragging = true;
        position = max(0, min(1, (mouseX-x)/float(len)));
        primary.volume(position);
        music.amp(position);
      }
    }
  }
}

boolean isNumeric(String str) {
  try {
    Double.parseDouble(str);
    return true;
  }
  catch(NumberFormatException e) {
    return false;
  }
}

// This mess is because i'm currently on a 16:10 4k monitor and hope the relative positions will keep it looking good.
void gui_init() {
  int xoffset = width-width/2+width/3;
  int yoffset = height/5+height/50;
  int size = 75;
  rules[0] = new TextBox(xoffset, yoffset, size, size, "1", false);
  rules[1] = new TextBox(xoffset, yoffset+height/8, size, size, "2", false);
  rules[2] = new TextBox(xoffset, yoffset+height/4, size, size, "3", false);
  rules[3] = new TextBox(xoffset, yoffset+height/4+height/8, size, size, "3", false);
  rules[4] = new TextBox(xoffset, yoffset+height/4+height/8+height/8, size, size, "2", false);
  rules[5] = new TextBox(int(width/2-(text_scale*290/2)), yoffset+height/2+height/7, int(text_scale*290), int(text_scale*size*1.15), "Start", true);
  rules[6] = new TextBox(xoffset-width/6, yoffset+height/4+height/8+height/8, size, size, "1", false);

  int ypos = int(rules[5].y_pos()-height/256);
  options[0] = new CheckBox(width/2+width/8, ypos, 30, true, "Line Init");
  options[1] = new CheckBox(width/2+width/8+width/16, ypos, 30, false, "Mute");
  options[2] = new CheckBox(width/2+width/8+width/8, ypos, 30, false, "Music");
  options[3] = new CheckBox(width/2+width/8+width/8+width/16, ypos, 30, false, "HQ Images");
  options[4] = new CheckBox(width/2-int(text_scale*25), int(rules[5].y_pos())-height/11, int(text_scale*50), true, "Randomize", true);

  volume = new Slider(width/2-width/8-width/5, ypos, int(500*text_scale), 0.3, "volume");
}

void gui() {
  int xoffset = width/2+width/16;
  background(0);
  for (int i = 0; i < rules.length; i ++) {
    rules[i].update();
    rules[i].render();
  }
  for (int i = 0; i < options.length; i ++) {
    options[i].update();
    options[i].render();
  }
  volume.update();
  volume.render();

  // Title
  fill(255);
  textSize(text_scale*150);
  textAlign(CENTER);
  text("Playing God", width/2, rules[0].y_pos()/2);
  textSize(text_scale*35);
  //text("By: ______",width/2,rules[0].y_pos()/2+rules[0].y_pos()/5);

  // Vars
  textAlign(LEFT);
  textSize(text_scale*35);
  text("Radius to check neighbors", xoffset, rules[0].y_pos());
  text("Underpopulation amount", xoffset, rules[1].y_pos());
  text("Overpopulation amount", xoffset, rules[2].y_pos());
  text("Amount for cell to be born", xoffset, rules[3].y_pos());
  text("Cell size", xoffset+width/6, rules[4].y_pos());
  text("Gen Time", xoffset, rules[4].y_pos());

  // Info
  textSize(text_scale*22);
  String description ="A cellular automaton consists of a regular grid of cells, each in one of a finite number of states, such as on and off.  For each cell, a set of cells called its neighborhood is defined relative to the specified cell. An initial state is selected by assigning a state for each cell. A new generation is created, according to some fixed rule that determines the new state of each cell in terms of the current state of the cell and the states of the cells in its neighborhood.\n\nThis program allows you to change these rules during runtime, giving the ability to drastically change the automaton's output. There is also an auditory aspect, where pitch is determined by the ratio of alive to dead cells, as well as how many cells are alive for any given generation. You can use the mouse cursor to interact live with the simulation, changing how it may have played out without your input. Enjoy!";
  String examples = "\n\n--------------------------------\n\nSome examples:\n\nWood Grain: 4-2-9-2 | Will work with almost any initial state.\n\nPitri Dish: 1-4-9-3 | Must start from a noisy initial state to degenerate into small starting patches of cells.";
  String controls = "\n\n--------------------------------\n\nControls:\n\nSPACE   -  Play/pause\nE/M     -  Return to this menu\nR       -  Restart simulation\nS       -  Save image\nESC     -  Exit\nMOUSE   -  Draw/Erase\n";
  text(description+examples+controls, width/8, rules[0].y_pos()-25, width/2-width/8-width/16, rules[3].y_pos());
}

void back_update() {
  // This fixes a bug where the start button resumes it's update function after coming back to the start menu and causing problems.
  for (int i = 0; i <= 5; i ++) {
    rules[i].update();
  }
}
