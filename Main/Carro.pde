class Carro{
  float velocidad;
  PVector direccion;
  PVector acc;
  PVector vel;
  float horaSalida;
  float horaLlegada;
  float radio;
  PVector pos;
  color c;
  PVector objetivo;
  int objetivoId;
  int id;
  boolean esperando = false;
  
  Carro(float x, float y,float vel, int objetivoId, float radio, int id){
    this.id = id;
    this.velocidad = vel*0.1;
    this.objetivoId = objetivoId;
    this.acc = new PVector(0, velocidad);
    PVector v = grafo.getNodos().get(objetivoId).pos;
    this.objetivo = v.copy();
    this.pos = new PVector(x,y);
    if(x == grafo.getNodos().get(objetivoId).pos.x){
      if(y > grafo.getNodos().get(objetivoId).pos.y){
        this.objetivo.x-=radio;
        this.pos.x -= radio;
      }
      else{
        this.objetivo.x+=radio;
        this.pos.x += radio;
      }
    }
    if(y == grafo.getNodos().get(objetivoId).pos.y){
      if(x > grafo.getNodos().get(objetivoId).pos.x){
        this.objetivo.y+=radio;
        this.pos.y += radio;
      }
      else{
        this.objetivo.y-=radio;
        this.pos.y -= radio;
      }
    }
    if(x > grafo.getNodos().get(objetivoId).pos.x){
      if(y > grafo.getNodos().get(objetivoId).pos.y){
        this.objetivo.x+=radio;
        this.pos.x += radio;
      }
      else{
        this.objetivo.x-=radio;
        this.pos.x -= radio;
      }
    }
    if(y > grafo.getNodos().get(objetivoId).pos.y){
      if(x > grafo.getNodos().get(objetivoId).pos.x){
        this.objetivo.y-=radio;
        this.pos.y -= radio;
      }
      else{
        this.objetivo.y+=radio;
        this.pos.y += radio;
      }
    }
    this.horaSalida = millis();
    this.radio = radio;
    this.c = color(random(128,255),random(128,255),random(128,255));
    this.direccion = PVector.sub(objetivo, pos);
    this.direccion.normalize();
  }
  
  boolean touchAny(){
    float distancia = PVector.dist(objetivo, this.pos);
    if(grafo.getNodos().get(objetivoId).carrosEspera.size() != 0){
      if ((distancia <= grafo.getNodos().get(objetivoId).radio + this.radio + this.radio*2 * (grafo.getNodos().get(objetivoId).carrosEspera.size()+1)) && !esperando) {
          this.esperando = true;
          println(millis()-horaSalida);
          grafo.getNodos().get(objetivoId).carrosEspera.add(this);
          return true;
      }
    }else{
        if ((distancia <= grafo.getNodos().get(objetivoId).radio + this.radio) && !esperando) {
          this.esperando = true;
          println(millis()-horaSalida);
          grafo.getNodos().get(objetivoId).carrosEspera.add(this);
          return true;
      }
    }
    return false;
  }
  
  void update() {
    /*vel.add(acc);
    pos.add(vel);
    acc.mult(0);*/
    if( !esperando && !touchAny()){
      pos.add(PVector.mult(direccion, velocidad));
    }
    //else{
      //pos.x = constrain(pos.x, radio,  - r);
      //pos.y = constrain(pos.y, radio, width - r);
      //println("Llego");
    //}
  }
  
  void avanzar(PVector v){
    pos = v.copy();;
  }
  
  void display() {
    noStroke();
    //stroke(153,246,214);
    fill(red(c),blue(c),green(c));
    circle(pos.x,pos.y,radio*2);
    PVector v = new PVector(mouseX, mouseY);
    float distancia = PVector.dist(v, this.pos);
    if(distancia <= this.radio*2){
      println("Distancia: ", distancia);
      fill(0);
      text("Objetivo es nodo " + objetivoId, this.pos.x, this.pos.y);
    }
  }

}
