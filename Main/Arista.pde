class Arista {
  float distancia;
  PVector nodoOrigen;
  PVector nodoDestino;
  color c;
  
  Arista(float distancia, PVector origen, PVector destino, color c, float radio){
    this.distancia = distancia;
    this.nodoOrigen = origen;
    this.nodoDestino = destino;
    this.c = c;
  }
  
  void display(){
    PVector dif = PVector.sub(nodoOrigen,nodoDestino);
    float x1,x2,y1,y2;
    x1 = nodoDestino.x;
    y1 = nodoDestino.y;
    PVector dest = PVector.add(nodoDestino, dif);
    x2 = dest.x;
    y2 = dest.y;
    stroke(255);
    strokeWeight(3);
    line(x1,y1,x2,y2);
  }

}
