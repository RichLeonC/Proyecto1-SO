class Nodo {
  private int id;
  private float radio;
  private PVector pos;
  private float alpha;
  private boolean ocupado;
  private ArrayList<Carro> carrosEspera;
  private ArrayList<Arista> aristas;
  int lastTime = 0;
  int current;
  int cruzando = 0;
  
  Nodo(float radio, PVector pos, float alpha, int id){
      this.id = id;
      this.radio = radio;
      this.alpha = alpha;
      this.pos = pos;
      this.ocupado =false;
      this.carrosEspera = new ArrayList();
      this.aristas = new ArrayList();
      this.current = millis();
  
  }

  public void generarCarro(){
      int i = grafo.nCarros;
      println("Id: " + id + " aristas: " + aristas.size() + "\n");
      for(Arista a : aristas){
        float distanciaEstablecida = a.distancia; // Distancia establecida en kilómetros
        float distanciaReal = pos.dist(grafo.getNodos().get(a.nodoDestinoId).pos); // Distancia real en píxeles
        // Calcular la velocidad en función de la distancia establecida
        float velocidadEstablecida = distanciaReal * (9.01*distanciaEstablecida/10)/distanciaReal;
        float distancia = pos.dist(grafo.getNodos().get(a.nodoDestinoId).pos);
        float segundosAdurar = a.distancia/10;
        grafo.addCarro(pos.x, pos.y, distanciaReal / segundosAdurar / 6.5, a.nodoDestinoId, radio/10, i);
        i++;
        grafo.nCarros++;
      }
      return ;
    
  }
  
  public void addArista(Arista a){
    aristas.add(a);
  }
  
  public void siguienteCarro(){
    if(carrosEspera.size() > 0){
      Carro next = carrosEspera.get(0);
      carrosEspera.remove(0);
      cruzando = millis();
      PVector next2 = next.pos.copy();
      next.pos = this.pos.copy();
      int i = 0;
      for(Carro carro : carrosEspera){
         PVector next3 = carro.pos.copy(); 
         carro.avanzar(next2);
         next2 = next3.copy();
         i++;
      }
    }else{
      ocupado = false;
    }
  }
  
  public boolean ponerEspera(Carro carro){
      return true;
  }

  public void display(){
    noStroke();
    fill(0);
    circle(pos.x,pos.y,radio*2);
    fill(255);
    text(id, pos.x-5, pos.y+5);
    current = millis();
    if (current - lastTime >= 2000) {
      lastTime = current;
      generarCarro();      
    }
  }
  
  public void update(){
    if (!ocupado || millis() - cruzando >= 4000) {
      cruzando = millis();
      siguienteCarro();
      ocupado = true;
    }
  }

}
