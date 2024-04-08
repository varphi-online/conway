class TextBox {
  int x, y, size_x, size_y;
  String default_text, text;
  boolean render, Focused, button, hovered;
  
  TextBox(int c_x,int c_y,int c_size_x,int c_size_y, String c_default_text, boolean stat){
    x = c_x;
    y = c_y;
    size_x = c_size_x;
    size_y = c_size_y;
    default_text = c_default_text;
    text = c_default_text;
    Focused = false;
    button = stat;
  }
  void render(){
    fill(255);
    rect(x,y,size_x,size_y);
    fill(0);
    textSize(size_y);
    text(text,x+size_y/5,y+(size_y)-(0.17*size_y));
    }
    
  public float y_pos(){
    return y+(size_y)-(0.35*size_y);
  }
  
  int value(){
    return text!="" ? int(text): int(default_text);
  }
  
  void update(){
  if (mouseX>=x&&mouseX<=x+size_x&&mouseY>=y&&mouseY<=y+size_y){
      hovered = true;
    } else {
      hovered = false;
    }
    if (mousePressed){
      Focused = hovered;
      text = hovered&&!button ? "": text;
    }
  // Other
  if (Focused&&!button){
      if (keyPressed&&!keybounce){
        if (text.length()<int((size_x*2)/size_y)-1&&key != CODED && isNumeric(str(key))){
          text = text + key;
        }
      }
  } else if (Focused && button){
    m_debounce = true;
    stage = "play";
    dist = rules[0].value();
    underpop = rules[1].value();
    overpop = rules[2].value();
    birth = rules[3].value();
    resolution = rules[4].value();
    if (resolution != old_rez){
      life_setup();
      old_rez = resolution;
    }
    Focused = false;
    m_debounce = true;
  }
}
}

boolean isNumeric(String str) { 
  try {  
    Double.parseDouble(str);  
    return true;
  } catch(NumberFormatException e){  
    return false;  
  }  
}
// This mess is because i'm currently on a 16:10 4k monitor and hope the relative positions will keep it looking good.
void gui_init(){
int xoffset = width-width/2+width/3;
int yoffset = height/4+height/40;
int size = 75;
rules[0] = new TextBox(xoffset,yoffset,size,size,"1",false);
rules[1] = new TextBox(xoffset,yoffset+height/8,size,size,"2",false);
rules[2] = new TextBox(xoffset,yoffset+height/4,size,size,"3",false);
rules[3] = new TextBox(xoffset,yoffset+height/4+height/8,size,size,"3",false);
rules[4] = new TextBox(xoffset,yoffset+height/4+height/8+height/8,size,size,"2",false);
rules[5] = new TextBox(width/2-150,yoffset+height/2+height/10,300,int(size*1.2),"Start",true);
}

void gui(){
  int xoffset = width/2+width/16;
  background(0);
  for (int i = 0; i <= 5; i ++){
    rules[i].update();
    rules[i].render();
  }
  fill(255);
  textSize(150);
  textAlign(CENTER);
  text("Playing God",width/2,rules[0].y_pos()/2);
  textSize(35);
  //text("By: Aidan Fuhrmann",width/2,rules[0].y_pos()/2+rules[0].y_pos()/5);
  textAlign(LEFT);
  textSize(35);
  text("Radius to check neighbors",xoffset,rules[0].y_pos());
  text("Underpopulation amount",xoffset,rules[1].y_pos());
  text("Overpopulation amount",xoffset,rules[2].y_pos());
  text("Amount for cell to be born",xoffset,rules[3].y_pos());
  text("Cell size (In pixels)",xoffset,rules[4].y_pos());
  textSize(25);
  String description = "A cellular automaton consists of a regular grid of cells, each in one of a finite number of states, such as on and off (in contrast to a coupled map lattice). The grid can be in any finite number of dimensions. For each cell, a set of cells called its neighborhood is defined relative to the specified cell. An initial state (time t = 0) is selected by assigning a state for each cell. A new generation is created (advancing t by 1), according to some fixed rule (generally, a mathematical function)[3] that determines the new state of each cell in terms of the current state of the cell and the states of the cells in its neighborhood. Typically, the rule for updating the state of cells is the same for each cell and does not change over time, and is applied to the whole grid simultaneously,[4] though exceptions are known, such as the stochastic cellular automaton and asynchronous cellular automaton.";
  String controls = "\n\n\n\n\nSPACE   -  Play/pause\nM       -  Return to this menu\nR       -  Restart simulation\nESC     -  Exit\nMOUSE   -  Draw/Erase\nSCROLL  -  Change brush size";
  text(description+controls,width/8,rules[0].y_pos()-25,width/2-width/8-width/16,rules[3].y_pos());
}

void back_update(){
for (int i = 0; i <= 5; i ++){
    rules[i].update();
  }
}
