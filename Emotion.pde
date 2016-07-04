import processing.video.*;
import processing.sound.*;

/**
  * Sons 
  */
SoundFile gravacaoPT1;
SoundFile gravacaoPT2;
SoundFile gravacaoPT3;
SoundFile gravacaoRespDir;
SoundFile gravacaoRespEsq;
SoundFile gravacaoMoneyPerg;
SoundFile gravacaoMoneySim;
SoundFile gravacaoMoneyNao;
SoundFile gravacaoFamilyPerg;
SoundFile gravacaoFamilySim;
SoundFile gravacaoFamilyNao;
SoundFile gravacaoMorte;
SoundFile gravacaoMuitoBom;
SoundFile gravacaoNao;
SoundFile gravacaoSim;
SoundFile relax;

/**
  * Videos 
  */
Movie familyFilme;
Movie familyFilme2;
Movie money;
Movie money2;
Movie deathFilme;

void setup(){
  size(1200, 800);
  frameRate(30);
  background(255);
  
  relax = new SoundFile(this, "sons/relax.mp3");
  gravacaoPT1 = new SoundFile(this, "sons/1_apresentacao_PT1.mp3");
  gravacaoPT2 = new SoundFile(this, "sons/1_apresentacao_PT2.mp3");
  gravacaoPT3 = new SoundFile(this, "sons/1_apresentacao_PT3.mp3");
  gravacaoRespDir = new SoundFile(this, "sons/1_resposta_dir.mp3");
  gravacaoRespEsq = new SoundFile(this, "sons/1_resposta_esq.mp3");
  gravacaoMoneyPerg = new SoundFile(this, "sons/2_bens_materiais_perg.mp3");
  gravacaoMoneySim = new SoundFile(this, "sons/2_bens_materiais_resp_sim.mp3");
  gravacaoMoneyNao = new SoundFile(this, "sons/2_bens_materiais_resp_sim.mp3");
  gravacaoFamilyPerg = new SoundFile(this, "sons/3_familia_perg.mp3");
  gravacaoFamilySim = new SoundFile(this, "sons/3_familia_resp_sim.mp3");
  gravacaoFamilyNao = new SoundFile(this, "sons/3_familia_resp_nao.mp3");
  gravacaoMorte = new SoundFile(this, "sons/6_morte_perg.mp3");
  gravacaoMuitoBom = new SoundFile(this, "sons/muito_bom.mp3");
  gravacaoNao = new SoundFile(this, "sons/nao.mp3");
  gravacaoSim = new SoundFile(this, "sons/sim.mp3");
  
  
  familyFilme = new Movie(this, "videos/FamilyFilme.mp4");
  familyFilme2 = new Movie(this, "videos/FamilyFilme2.mp4");
  money = new Movie(this, "videos/Money.mp4");
  money2 = new Movie(this, "videos/Money2.mp4");
  deathFilme = new Movie(this, "videos/DeathFilme.mp4");
  
  relax.amp(0.4);
  relax.loop();
  delay(3000);
}

void draw() {
 thread("requestData");
 getSound(gravacaoPT1);
 getSound(gravacaoPT2);
 getSound(gravacaoPT3);
 getSound(gravacaoRespDir);
 getSound(gravacaoMoneyPerg);
 getSound(gravacaoSim);
 getMovie(money2);
 getSound(gravacaoMoneySim);
}

public void getSound(SoundFile sound){
    int duracao = (int) sound.duration() * 1000;
    sound.play();
    delay(duracao);
}

public void getSoundNoDelay(SoundFile sound){
    sound.play();
}

public void getMovie(Movie movie){
  movie.loop();
  while(movie.time() < movie.duration()){
    image(movie, 0, 0, width, height);
  }
}

void movieEvent(Movie m) {
  m.read();
}

/**
  * Teste inicial da Thread
  */
public void requestData() {
  for(int i = 0; i < 10000; i++) {
    JSONObject json = loadJSONObject("http://time.jsontest.com/");
    String time = json.getString("time");
    println(time);
  }
}