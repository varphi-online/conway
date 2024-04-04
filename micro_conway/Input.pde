void liveInput(){
  if(mousePressed){
    int clicked_index = floor(mouseX / resolution) + floor(mouseY / resolution) * int(b_width);
    clicked_index = min(buffers[current_buffer].length-1,(max(0,clicked_index)));
    if (!debounce){
      mode = buffers[current_buffer][clicked_index];
    }
    if (paused){
      debounce = true;
      buffers[current_buffer][clicked_index] = !mode;
      buffers[int(!boolean(current_buffer))][clicked_index] = !mode;
    } else {
      buffers[current_buffer][clicked_index] = !buffers[current_buffer][clicked_index];
      buffers[int(!boolean(current_buffer))][clicked_index] = !buffers[int(!boolean(current_buffer))][clicked_index];
    }
  }
}

void keyPressed() 
  {
  if (key == ' ')
    {
    paused = !paused;
    } else if (keyCode == 82){
      println("reset");
    buffers[0] = new boolean[width*height/floor(pow(resolution,2))];
    buffers[1] = new boolean[width*height/floor(pow(resolution,2))];
    }
  }

void mouseReleased() {
  debounce = false;
}
