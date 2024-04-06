void drawGrid(){
loadPixels();
  for (int i = 0; i < buffers[current_buffer].length; i = i+1){
    // Iterate over boxes
    int xpos, ypos, update;
    for (int y = 0; y < resolution+1; y = y+1){
      // Iterate up per box
         for (int x = 0; x < resolution; x = x+1) {
           //iterate across
           ypos = width*((y-1)+ (resolution*floor(i/b_width)));
           ypos = max(0,ypos);
           xpos = ((i%int(b_width))*resolution)+x;
           update = min(ypos+xpos,width*height-1);
           
           if (buffers[current_buffer][i]){
             pixels[update] = #ffffff;
           } else {
             pixels[update] = #000000;
           }
         }
      }
      if(!paused&&frameCount%step_time==0){
      if (buffers[int(!boolean(current_buffer))][i]) {
        if (count_neighbors(i) < 2 || count_neighbors(i) > 3) {
          buffers[current_buffer][i] = false;
        }
      } else {
        if (count_neighbors(i) == 3) {
          buffers[current_buffer][i] = true;
        }
      }
      }
  }
for (int i = 0; i < buffers[current_buffer].length; i = i+1){
  buffers[int(!boolean(current_buffer))][i] = buffers[current_buffer][i];
}
updatePixels();
}

int count_neighbors(int index){
  int neighbors = 0;
  for (int y = 0; y < 3; y += 1){
    for (int x = 0; x < 3; x += 1){
      
      int i = (index-floor(b_width)-1)+(floor(b_width)*y)+x;
      i = i%buffers[current_buffer].length;
      i = min(buffers[current_buffer].length-1,(max(0,i)));
      if (buffers[int(!boolean(current_buffer))][i]&&i!=index){
       neighbors += 1;
      }
  }
}
return neighbors;
}

void playPause(){
if(!paused&&frameCount%step_time==0){
    if (current_buffer==0){
      current_buffer = 1;
    } else {
      current_buffer = 0;
    }
  }
}
