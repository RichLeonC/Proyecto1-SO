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
  
  Carro(float x, float y,float vel, PVector direccion, float radio){
    this.velocidad = vel;
    this.acc = new PVector(0, velocidad);
    this.direccion = direccion;
    this.horaSalida = millis();
    this.radio = radio;
    this.pos = new PVector(x,y);
    this.vel = new PVector(0,velocidad);
    this.c = color(random(128,255),random(128,255),random(128,255));
  }
  
  void update() {
    vel.add(acc);
    pos.add(vel);
    acc.mult(0);
  }
  
  void display() {
    stroke(255);
    fill(0);
    circle(pos.x,pos.y,radio*2);
  }

}
