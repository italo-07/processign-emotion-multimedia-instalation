import processing.video.*;
import processing.serial.*;
import ddf.minim.*;

/**
  * Sons 
  */
Minim som;
AudioPlayer relaX;
AudioPlayer gravacoes;

/**
  * Videos 
  */
Movie familyFilme;
Movie familyFilme2;
Movie money;
Movie money2;
Movie deathFilme;

/**
  * Flags
  */
boolean isSound = true;

Serial minhaPorta;       
String stringValue;  
float floatValue;
int numProcesso = 5;

void setup(){
  minhaPorta = new Serial(this, Serial.list()[32], 9600);
  minhaPorta.bufferUntil('\n');
  printArray(Serial.list());
  
  size(1200, 800);
  frameRate(30);
  background(255);
  
  som = new Minim(this);
  getSoundNoDelay(som.loadFile("sons/relax.mp3"));
  
  //relax = new SoundFile(this, "sons/relax.mp3");
  //gravacaoPT1 = new SoundFile(this, "sons/1_apresentacao_PT1.mp3");
  //gravacaoPT2 = new SoundFile(this, "sons/1_apresentacao_PT2.mp3");
  //gravacaoPT3 = new SoundFile(this, "sons/1_apresentacao_PT3.mp3");
  //gravacaoRespDir = new SoundFile(this, "sons/1_resposta_dir.mp3");
  //gravacaoRespEsq = new SoundFile(this, "sons/1_resposta_esq.mp3");
  //gravacaoMoneyPerg = new SoundFile(this, "sons/2_bens_materiais_perg.mp3");
  //gravacaoMoneySim = new SoundFile(this, "sons/2_bens_materiais_resp_sim.mp3");
  //gravacaoMoneyNao = new SoundFile(this, "sons/2_bens_materiais_resp_sim.mp3");
  //gravacaoFamilyPerg = new SoundFile(this, "sons/3_familia_perg.mp3");
  //gravacaoFamilySim = new SoundFile(this, "sons/3_familia_resp_sim.mp3");
  //gravacaoFamilyNao = new SoundFile(this, "sons/3_familia_resp_nao.mp3");
  //gravacaoMorte = new SoundFile(this, "sons/6_morte_perg.mp3");
  //gravacaoMuitoBom = new SoundFile(this, "sons/muito_bom.mp3");
  //gravacaoNao = new SoundFile(this, "sons/nao.mp3");
  //gravacaoSim = new SoundFile(this, "sons/sim.mp3");
  
  money = new Movie(this, "videos/Money.mp4");
  money2 = new Movie(this, "videos/Money2.mp4");
  familyFilme = new Movie(this, "videos/FamilyFilme.mp4");
  familyFilme2 = new Movie(this, "videos/FamilyFilme2.mp4");
  deathFilme = new Movie(this, "videos/DeathFilme.mp4");
  
  money.loop();
}

void draw() {
 image(money, 0, 0, width, height);
}

void movieEvent(Movie m) {
  if(isSound){
    switch(numProcesso){
      case 1 : {
          getSound(som.loadFile("sons/1_apresentacao_PT1.mp3"));
        break;
      }
      case 2 : {
          getSound(som.loadFile("sons/1_apresentacao_PT2.mp3"));
        break;
      }
      case 3 : {
          getSound(som.loadFile("sons/1_apresentacao_PT3.mp3"));
        break;
      }
      case 4 : {
          getSound(som.loadFile("sons/1_resposta_dir.mp3"));
        break;
      }
      case 5 : {
          getSound(som.loadFile("sons/2_bens_materiais_perg.mp3"));
          thread("requestData");
        break;
      }
      case 6 : {
          if(floatValue > 1000){
            getSound(som.loadFile("sons/sim.mp3"));
            getSoundNoDelay(som.loadFile("sons/2_bens_materiais_resp_sim.mp3"));
          }
          else{
            getSound(som.loadFile("sons/nao.mp3"));
            getSoundNoDelay(som.loadFile("sons/2_bens_materiais_resp_nao.mp3"));
          }
        break;
      }
    }
  }
  
  if(numProcesso == 6){
    isSound = false;
    m.read();
  }
  
  if(isSound)
    numProcesso++;
}

public void getSound(AudioPlayer sound){
    int duracao = (int) sound.length();
    sound.play();
    delay(duracao);
}

public void getSoundNoDelay(AudioPlayer sound){
    sound.play();
}

/**
  * Teste inicial da Thread
  */
public void requestData() {
  println("Entrou na Thread");
  while (minhaPorta.available() > 0 ) {
    stringValue = minhaPorta.readStringUntil('\n');
    floatValue = Float.parseFloat(stringValue);
    println("String " + stringValue);
    println("Float " + floatValue);
  }
}