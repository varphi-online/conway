class TextBox {
  int x, y, size_x, size_y;
  String default_text, text;
  boolean render, Focused;
  
  TextBox(int c_x,int c_y,int c_size_x,int c_size_y, String c_default_text){
    x = c_x;
    y = c_y;
    size_x = c_size_x;
    size_y = c_size_y;
    default_text = c_default_text;
    text = c_default_text;
    Focused = false;
  }
  
  /*
  if (Focused==true){
    if (keyPressed){
      if (key=="BACKSPACE"){
        text = text.substring(0,text.length-2);
      }
    }
  }
  */
  
}

void textBox(int x, int y, String default_txt){
  ;
}
