void liveInput() {
  if (mousePressed) {
    int clicked_index = floor(mouseX / resolution) + floor(mouseY / resolution) * int(b_width);
    clicked_index = min(buffers[current_buffer].length-1, (max(0, clicked_index)));
    if (!m_debounce) {
      mode = buffers[current_buffer][clicked_index];
    }
    if (paused) {
      m_debounce = true;
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
  if (!keybounce) {
    if (key == ' ') {
      keybounce=true;
      paused = !paused;
    } else if (keyCode == 82) {
      reset();
      keybounce=true;
    } else if (key == 'm') {
      paused = true;
      stage = stage == "main" ? "play": "main";
    }
  }
}

void keyReleased() {
  keybounce=false;
}
void mouseReleased() {
  m_debounce = false;
}
