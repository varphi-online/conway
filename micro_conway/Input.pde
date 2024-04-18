boolean m_debounce = false;
boolean keybounce = false;
boolean mode;

void liveInput() {
  if (mousePressed&&!rules[0].starting) {
    // Returns a position in the 1d grid of where the pointer is located
    int clicked_index = floor(mouseX / resolution) + floor(mouseY / resolution) * int(b_width);
    clicked_index = min(buffers[current_buffer].length-1, (max(0, clicked_index)));
    if (!m_debounce) {
      // Paint mode when clicking on a dead cell, erase mode when clicking on an alive cell.
      mode = !buffers[current_buffer][clicked_index];
    }
    if (paused) {
      // If it's paused, act as expected for a drawing tool
      m_debounce = true;
      buffers[current_buffer][clicked_index] = mode;
      buffers[int(!boolean(current_buffer))][clicked_index] = mode;
    } else {
      // Unpaused flashes the current cell for that "hand of god" like behavior.
      buffers[current_buffer][clicked_index] = !buffers[current_buffer][clicked_index];
      buffers[int(!boolean(current_buffer))][clicked_index] = !buffers[int(!boolean(current_buffer))][clicked_index];
    }
  }
}

void keyPressed()
{
  if (!keybounce) {
    if (key == ' ') {
      if (!paused) {
        // Destroying and reinitializing the synth fixes some bug
        primary.halt();
        primary = null;
        primary = new Synth();
      }
      keybounce=true;
      paused = !paused;
    } else if (keyCode == 82) {
      reset();
      keybounce=true;
    } else if (key == 'm'||key == 'e') {
      paused = true;
      stage = stage == "main" ? "play": "main";
    } else if (key == 's'&&stage=="play"){
      // Screenshot
      keybounce=true;
      String extension = options[3].value() ? "tif": "png";
      saveFrame("Screenshots/"+str(dist)+"-"+str(underpop)+"-"+str(overpop)+"-"+str(birth)+"-##."+extension);
    }
  }
}

void keyReleased() {
  keybounce=false;
}
void mouseReleased() {
  m_debounce = false;
  volume.stopped_interaction();
  
  rules[0].starting=false;
}
