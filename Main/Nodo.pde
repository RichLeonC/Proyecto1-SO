class Nodo extends Thread {
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
    int i = 0;
    // println("Id: " + id + " aristas: " + aristas.size() + "\n");

    synchronized(grafo) {
      for (Arista a : aristas) {
        float distanciaEstablecida = a.distancia; // Distancia establecida en kilómetros
        float distanciaReal = pos.dist(grafo.getNodos().get(a.nodoDestinoId).pos); // Distancia real en píxeles
        float segundosAdurar = a.distancia/10;
        grafo.addCarro(pos.x, pos.y, distanciaReal / segundosAdurar / 6.5, a.nodoDestinoId, radio/10, grafo.nCarros);
        i++;
        grafo.nCarros++;
      }
    }
  }

  public void addArista(Arista a) {
    aristas.add(a);
  }

  public void siguienteCarro() {
    if (carrosEspera.size() > 0) {
      Carro next = carrosEspera.get(0);
      carrosEspera.remove(0);
      grafo.nCarrosEspera++;
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
    synchronized(lock) {
      if (!ocupado || millis() - cruzando >= 4000) {
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
