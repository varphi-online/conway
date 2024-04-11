float music_time;
class Synth {
  public TriOsc[] triangle;
  public SinOsc[] mouse;
  public LowPass lpf;
  public int tricount = 6;
  Synth() {
    lpf = new LowPass(micro_conway.this);
    triangle = new TriOsc[tricount+1];
    mouse = new SinOsc[2];
    for (int i = 0; i < tricount; i++) {
      triangle[i] = new TriOsc(micro_conway.this);
    } 
    for (int i = 0; i < 2; i++) {
      mouse[i] = new SinOsc(micro_conway.this);
    }
    for (int i = 0; i < tricount; i++) {
      triangle[i].freq(0);
      triangle[i].play();
      triangle[i].amp(volume.value()/10.0);
    }
    for (int i = 0; i < 2; i++) {
      mouse[i].freq(0);
      mouse[i].play();
      mouse[i].amp(volume.value()/5.0);
    }
  }

  void halt() {
    for (int i = 0; i < tricount; i++) {
      primary.triangle[i].stop();
    }
    primary.mouse[0].stop();
    primary.mouse[1].stop();
  }

  void volume(float vol) {
    for (int i = 0; i < tricount; i++) {
      triangle[i].amp(vol/10.0);
    }
    for (int i = 0; i < 2; i++) {
      mouse[i].amp(vol/5.0);
    }
  }
}

float note(int num) {
  float freq = (442 * pow(2, ((num%400)-49)/12.0))%3000;
  return freq;
}

void play_vars() { 
  if (mousePressed&&stage=="play") {
    primary.mouse[0].play();
    primary.mouse[0].freq(note(20+int((mouseX/float(width))*40)));
    primary.mouse[1].play();
    primary.mouse[1].freq(note(20+int((mouseY/float(height))*40)));
  } else {
    primary.mouse[0].stop();
    primary.mouse[1].stop();
  }
  if (!paused&&stage=="play") {
    for (int i = 0; i < primary.tricount; i++) {
      primary.triangle[i].play();
    }
    int start = 30;
    if (!paused&&frameCount%step_time==0) {
      alive_ratio = int(((alive_count/float(buff_size))*start/2)/3);
    }
    primary.triangle[0].freq(note(dist + start+alive_ratio));
    primary.triangle[1].freq(note(dist+underpop + start+alive_ratio));
    primary.triangle[2].freq(note(dist+underpop+overpop +start+alive_ratio));
    primary.triangle[3].freq(note(dist+underpop+overpop+birth + start+alive_ratio));
    primary.triangle[4].freq(note(int((alive_count/float(buff_size))*start+alive_ratio)));
    primary.triangle[5].freq(note(int(alive_ratio)));
  } else {
    for (int i = 0; i < primary.tricount; i++) {
      primary.triangle[i].stop();
    }
  }
}

void music_handle() {
  float vol = 1.3*volume.value();
  if (music.position()>=music.duration()-0.1) {
    music.cue(0);
  }
  if (!options[1].value()&&options[2].value()) {
    if (!music.isPlaying()) {
      music.play();
      for (float i = 0.0; i<=vol; i+= 0.0005*vol/0.3) {
        music.amp(i);
        delay(1);
      }
    }
  } else if (music.isPlaying()) {
    for (float i = vol; i>=0.0; i-=0.001*vol/0.3) {
      music.amp(i);
      delay(1);
    }
    music.pause();
  }
}
