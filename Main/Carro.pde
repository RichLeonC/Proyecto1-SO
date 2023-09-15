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
  
  Carro(float x, float y,float vel, PVector objetivo, float radio){
    this.velocidad = vel;
    this.acc = new PVector(0, velocidad);
    this.objetivo = objetivo;
    this.horaSalida = millis();
    this.radio = radio;
    this.pos = new PVector(x,y);
    this.vel = new PVector(0,velocidad);
    this.c = color(random(128,255),random(128,255),random(128,255));
    this.direccion = PVector.sub(objetivo, pos);
    this.direccion.normalize();
  }
  
  boolean touchAny(){
    float distancia = PVector.dist(objetivo, this.pos);
    if (distancia <= this.radio*10 + this.radio) {
        return true;
    }
    for(Carro c : grafo.getCarros()){
      distancia = PVector.dist(c.pos, this.pos);
      if (distancia <= c.radio + this.radio) {
        return true;
      } else {
        return false;
      }
    }
    return false;
  }
  
  void update() {
    /*vel.add(acc);
    pos.add(vel);
    acc.mult(0);*/
    //if(!touchAny()){
      pos.add(PVector.mult(direccion, velocidad));
    /*}
    else{
      //pos.x = constrain(pos.x, radio,  - r);
      //pos.y = constrain(pos.y, radio, width - r);
      println("Llego");
    }*/
  }
  
  void display() {
    stroke(255);
    fill(0);
    circle(pos.x,pos.y,radio*2);
  }

}
