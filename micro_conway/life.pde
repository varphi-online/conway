boolean[][] buffers;
int current_buffer;
boolean paused = true;
int step_time = 2; //frames between update
int underpop, overpop, birth, dist;

void life_setup() {
  buff_size = width*height/floor(pow(resolution, 2));
  buffers = new boolean[2][buff_size];
  buffers[0] = new boolean[buff_size];
  buffers[1] = new boolean[buff_size];
  b_width = width/resolution;

  reset();
}

void drawGrid() {
  loadPixels();
  for (int i = 0; i < buffers[current_buffer].length; i = i+1) {
    // Iterate over boxes
    int xpos, ypos, update;
    for (int y = 0; y < resolution+1; y = y+1) {
      // Iterate up per box
      for (int x = 0; x < resolution; x = x+1) {
        //iterate across
        ypos = width*((y-1)+ (resolution*floor(i/b_width)));
        ypos = max(0, ypos);
        xpos = ((i%int(b_width))*resolution)+x;
        update = min(ypos+xpos, width*height-1);

        if (buffers[current_buffer][i]) {
          pixels[update] = #ffffff;
          alive_count ++;
        } else {
          pixels[update] = #000000;
        }
      }
    }
    if (!paused&&frameCount%step_time==0) {
      int neighbors = count_neighbors(i);
      if (buffers[int(!boolean(current_buffer))][i]) {
        if (neighbors < underpop || neighbors > overpop) {
          buffers[current_buffer][i] = false;
        }
      } else {
        if (neighbors == birth) {
          buffers[current_buffer][i] = true;
        }
      }
    }
  }
  for (int i = 0; i < buffers[current_buffer].length; i = i+1) {
    buffers[int(!boolean(current_buffer))][i] = buffers[current_buffer][i];
  }
  updatePixels();
}

int count_neighbors(int index) {
  int neighbors = 0;
  for (int y = 0; y < 2*dist+1; y += 1) {
    for (int x = 0; x < 2*dist+1; x += 1) {

      int i = (index-floor(b_width)-1)+(floor(b_width)*y)+x;
      i = i%buffers[current_buffer].length;
      i = min(buffers[current_buffer].length-1, (max(0, i)));
      if (buffers[int(!boolean(current_buffer))][i]&&i!=index) {
        neighbors += 1;
      }
    }
  }
  return neighbors;
}

void playPause() {
  if (!paused&&frameCount%step_time==0) {
    if (current_buffer==0) {
      current_buffer = 1;
      alive_count = 0;
    } else {
      current_buffer = 0;
      alive_count = 0;
    }
  }
}

void reset() {
  for (int i = 0; i < buff_size; i++) {
    buffers[0][i] = false;
    buffers[1][i] = false;
  }
  if (options[0].value()) {
    for (int i = 0; i < b_width; i ++) {
      buffers[0][i+((height/resolution)/2)*int(b_width)] = true;
      buffers[1][i+((height/resolution)/2)*int(b_width)] = true;
    }
  }
}
