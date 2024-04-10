class Synth {
  public TriOsc[] triangle;
  public SinOsc[] mouse;
  public LowPass lpf;
  Synth(){
    lpf = new LowPass(micro_conway.this);
    triangle = new TriOsc[5];
    mouse = new SinOsc[2];
    for (int i = 0; i < 5; i++) {
      triangle[i] = new TriOsc(micro_conway.this);
    }
    for (int i = 0; i < 2; i++) {
      mouse[i] = new SinOsc(micro_conway.this);
    }
    for (int i = 0; i < 5; i++) {
      triangle[i].freq(0);
      triangle[i].play();
      triangle[i].amp(0.03);
    }
    for (int i = 0; i < 2; i++) {
      mouse[i].freq(0);
      mouse[i].play();
      mouse[i].amp(0.06);
    } 
  }
  
  void halt(){
  for (int i = 0; i < 5; i++){
    primary.triangle[i].stop();
  }
  primary.mouse[0].stop();
    primary.mouse[1].stop();
  }
}

float note(int num){
    float freq = (442 * pow(2,(num-49)/12.0))%3000;
    return freq;
  }

void play_vars(){
  if (mousePressed&&stage=="play"){
    primary.mouse[0].play();
    println(note(int((mouseX/float(width))*30)));
    primary.mouse[0].freq(note(20+int((mouseX/float(width))*40)));
    primary.mouse[1].play();
    primary.mouse[1].freq(note(20+int((mouseY/float(height))*40)));
  } else {
    primary.mouse[0].stop();
    primary.mouse[1].stop();
  }
  if (!paused&&stage=="play"){
  for (int i = 0; i < 5; i++){
    primary.triangle[i].play();
  }
  int start = 30;
  if (!paused&&frameCount%step_time==0){
  alive_ratio = int(((alive_count/float(buff_size))*start/2)/3);
  }
  primary.triangle[0].freq(note(dist + start+alive_ratio));
  primary.triangle[1].freq(note(dist+underpop + start+alive_ratio));
  primary.triangle[2].freq(note(dist+underpop+overpop +start+alive_ratio));
  primary.triangle[3].freq(note(dist+underpop+overpop+birth + start+alive_ratio));
  primary.triangle[4].freq(note(int((alive_count/float(buff_size))*start+alive_ratio)));
  } else {
  for (int i = 0; i < 5; i++){
    primary.triangle[i].stop();
  }
  }
}
