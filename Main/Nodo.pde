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
    LinkedList<Nodo> ruta;
    LinkedList<Nodo> aux = new LinkedList<Nodo>(grafo.nodos);
    aux.remove(this.id);
    Collections.shuffle(aux);
    do{
      Nodo objetivo = aux.pop();
      ruta = grafo.dijkstra(this, objetivo);
    }while(ruta.size() <= 1 && aux.size() > 0);
    if(ruta.size() > 1){
      ruta.remove(0);
      Arista a = getArista(this.id, ruta.get(0).id);
      float distanciaReal = pos.dist(grafo.getNodos().get(a.nodoDestinoId).pos); // Distancia real en píxeles
      float segundosAdurar = a.distancia/10;
      synchronized(grafo) {
        grafo.addCarro(pos.x, pos.y, distanciaReal / segundosAdurar / 6.5, a.nodoDestinoId, radio/10, grafo.nCarros, ruta, a.id);
        grafo.nCarros++;
      }
    }
  }
  
  public boolean tieneArista(int origen){
    for (Arista a : aristas) {
      if (a.nodoOrigenId == origen) {
        return true;
      }
    }
    return false;
  }

  public Arista getArista(int origen, int destino) {
    for (Arista a : aristas) {
      if (a.nodoOrigenId == origen && a.nodoDestinoId == destino) {
        return a;
      }
    }
    return null;
  }

  public void addArista(Arista a) {
    aristas.add(a);
  }

  public void siguienteCarro() {
    if (carrosEspera.size() > 0) {
      Carro next = carrosEspera.get(0);
      carrosEspera.remove(0);
      grafo.nCarrosEspera--;
      cruzando = millis();
      PVector next2 = next.pos.copy();
      next.pos = this.pos.copy();
      next.siguienteNodo();
      int i = 0;
      for (Carro carro : carrosEspera) {
        if (carro.aristaId == next.aristaId) {
          PVector next3 = carro.pos.copy();
          carro.avanzar(next2);
          next2 = next3.copy();
          i++;
        }
      }
      //grafo.nCarros--;
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
      if (ocupado && millis() - cruzando >= 2000) {
        cruzando = millis();
        siguienteCarro();
        ocupado = false;
      } else if (!ocupado && carrosEspera.size()>0) {
        cruzando = millis();
        Carro next = carrosEspera.get(0);
        next.pos = this.pos;
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
