Arista arista;
Carro carro;

void setup(){
  size(800,600);
  background(0);
  arista = new Arista(30, new PVector(width/2, height/2), new PVector(200,200),color(255,255,255));
  carro = new Carro(width/2,height/2,1,new PVector(0,1),10);
}

void draw(){
  background(0);
  arista.display();
  carro.display();
  carro.update();
}
