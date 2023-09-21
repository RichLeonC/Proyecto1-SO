class Arista {
  float distancia;
  int nodoOrigenId;
  int nodoDestinoId;
  color c;
  
  Arista(float distancia, int origen, int destino, color c){
    this.distancia = distancia;
    this.nodoOrigenId = origen;
    this.nodoDestinoId = destino;
    this.c = c;
  }
  
  Arista(float distancia, int origen, int destino){
    this.nodoOrigenId = origen;
    this.nodoDestinoId = destino;
    this.distancia = distancia;
  }
  
  void setDistancia(float distancia){
    this.distancia = distancia;
  }
  
   public int getDestino(){
    return nodoDestinoId;
  }
  
  
  void display(){
    PVector origenPos = grafo.getNodos().get(nodoOrigenId).pos;
    PVector destinoPos = grafo.getNodos().get(nodoDestinoId).pos; 
    PVector dif = PVector.sub(origenPos,destinoPos);
    float x1,x2,y1,y2;
    x1 = destinoPos.x;
    y1 = destinoPos.y;
    PVector dest = PVector.add(destinoPos, dif);
    x2 = dest.x;
    y2 = dest.y;
    stroke(210,107,219);
    strokeWeight(3);
    line(x1,y1,x2,y2);
    PVector centro = new PVector(origenPos.x + (destinoPos.x - origenPos.x)*0.7,
                                  origenPos.y + (destinoPos.y - origenPos.y)*0.7);
    text((int)distancia, centro.x, centro.y);
  }

}
