Arista arista;

void setup(){
  size(800,600);
  background(0);
  arista = new Arista(30, new PVector(width/2, height/2), new PVector(12,32),color(255,255,255), 3);
}

void draw(){
  background(0);
  arista.display();
}
