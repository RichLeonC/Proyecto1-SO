class Arista {
  float distancia;
  int nodoOrigenId;
  int nodoDestinoId;
  int id;
  color c;
  
  Arista(float distancia, int origen, int destino, color c, int id){
    this.distancia = distancia;
    this.nodoOrigenId = origen;
    this.nodoDestinoId = destino;
    this.c = c;
    this.id = id;
  }
  
  Arista(float distancia, int origen, int destino, int id){
    this.nodoOrigenId = origen;
    this.nodoDestinoId = destino;
    this.distancia = distancia;
    this.id = id;
    this.c = color(random(128,255), random(128,255), random(128,255));
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
    stroke(red(c),green(c),blue(c));
    strokeWeight(3);
    line(x1,y1,x2,y2);
    PVector centro = new PVector(origenPos.x + (destinoPos.x - origenPos.x)*0.8,
                                  origenPos.y + (destinoPos.y - origenPos.y)*0.8);
    fill(0);
    text((int)distancia, centro.x, centro.y);
  }

}
