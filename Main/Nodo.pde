class Nodo extends Thread {
  int id;
  float radio;
  PVector pos;
  float alpha;
  boolean ocupado;
  ArrayList<Carro> carrosEspera;
  ArrayList<Arista> aristas;
  int lastTime = 0;
  int current;
  int cruzando = 0;
  private final Object lock = new Object();

  void setAlpha(float alpha) {
    this.alpha = alpha;
  }

  Nodo(float radio, PVector pos, float alpha, int id) {
    this.id = id;
    this.radio = radio;
    this.alpha = alpha;
    this.pos = pos;
    this.ocupado =false;
    this.carrosEspera = new ArrayList();
    this.aristas = new ArrayList();
    this.current = millis();
  }

  public void run() {

    current = millis();
    if (current - lastTime >= (1000/1/alpha)) {
      lastTime = current;
      generarCarro();
    }

    update();
  }


  public void generarCarro() {
    // println("Id: " + id + " aristas: " + aristas.size() + "\n");

    synchronized(grafo) {
      //for (Arista a : aristas) {
        Arista a = aristas.get((int) random(0,aristas.size()));
        float distanciaEstablecida = a.distancia; // Distancia establecida en kilómetros
        float distanciaReal = pos.dist(grafo.getNodos().get(a.nodoDestinoId).pos); // Distancia real en píxeles
        float segundosAdurar = a.distancia/10;
        if(grafo.nodos.size() > 0){
          LinkedList<Nodo> aux = new LinkedList<Nodo>(grafo.nodos);
          aux.remove(this.id);
          /*for(Nodo n : aux){
            if(!grafo.existeCaminoEntreNodos(this.id, n.id)){
              aux.remove(n.id);
            }
          }*/
          if(aux.size() > 0){
            Nodo objetivo = grafo.nodos.get(aux.get((int)random(0,aux.size())).id);
            LinkedList<Nodo> ruta = grafo.dijkstra(this, objetivo);
            /*print("\nDel nodo " + this.id + " quiere ir al nodo " + objetivo.id + "Y la ruta es ");
            for(Nodo n : ruta){
              print(n.id);
            }
            print("\n");*/
            ruta.remove(0);
            grafo.addCarro(pos.x, pos.y, distanciaReal / segundosAdurar / 6.5, a.nodoDestinoId, radio/10, grafo.nCarros, ruta);
            grafo.nCarros++;
          }
        }
      //}
    }
  }

  public void addArista(Arista a) {
    aristas.add(a);
  }

  public void siguienteCarro() {
    if (carrosEspera.size() > 0) {
      Carro next = carrosEspera.get(0);
      carrosEspera.remove(0);
      next.siguienteNodo();
      grafo.nCarrosEspera--;
      cruzando = millis();
      PVector next2 = next.pos.copy();
      next.pos = this.pos.copy();
      int i = 0;
      for (Carro carro : carrosEspera) {
        PVector next3 = carro.pos.copy();
        carro.avanzar(next2);

        next2 = next3.copy();
        i++;
      }
      grafo.nCarros--;
    } else {
      ocupado = false;
    }
  }

  public boolean ponerEspera(Carro carro) {
    return true;
  }

  public void display() {
    noStroke();
    fill(0);
    circle(pos.x, pos.y, radio*2);
    fill(255);
    text(id, pos.x-5, pos.y+5);
  }

  public void update() {
    synchronized(this) {
      if (!ocupado || millis() - cruzando >= 2000) {
        cruzando = millis();
        siguienteCarro();
        ocupado = true;
      }
    }
  }

  public int getID() {
    return id;
  }


  public ArrayList<Arista> getAristas() {
    return aristas;
  }
}
