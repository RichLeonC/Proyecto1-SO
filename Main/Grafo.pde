class Grafo {
  public ArrayList<Nodo> nodos;
  private ArrayList<Arista> aristas;
  private ArrayList<Carro> carros;
  public ArrayList<Thread>nodosThreads;
  private static final int INF = Integer.MAX_VALUE;  //valor asignado como distancia que no interesa o interfiere en lo final
  private int radio = 300;
  public int nCarros;
  public int nCarrosEspera = 0;
  public int idsCounter = 0;
  public int idsAristasCounter = 0;

  Grafo() {
    this.nodos = new ArrayList();
    this.aristas = new ArrayList();
    this.carros = new ArrayList();
    this.nodosThreads = new ArrayList();
  }

  public void generarNodos(float numNodos) {
    int centroX = width * 1320 / 1920;
    int centroY = height/2;
    nodos = new ArrayList();
    for (int i = 0; i < numNodos; i++) {
      float angulo = TWO_PI / numNodos * i;
      float x = centroX + cos(angulo) * radio;
      float y = centroY + sin(angulo) * radio;
      Nodo nodo = new Nodo(constrain(radio/numNodos, 30, 30), new PVector(x, y), 2, i);
      nodos.add(nodo);      
    }
  }

  public void addArista(float distancia, int nOrigen, int nDestino) {
    Arista a = new Arista(distancia, nOrigen, nDestino,idsAristasCounter);
    idsAristasCounter++;
    nodos.get(nOrigen).addArista(a);
    aristas.add(a);
  }

  public void addCarro(float x, float y, float velocidad, int objetivoId, float radio, int id, LinkedList<Nodo> ruta, int arista ) {
    carros.add(new Carro(x, y, velocidad, radio*4, idsCounter, ruta, arista));
    idsCounter++;
  }
  
  public Carro getCarro(int id){
    for(Carro c : carros){
      if(c.id == id){
        return c;
      }
    }
    return null;
  }
  
  public int getCarroIndex(int id){
    for(int i = 0; i < carros.size(); i++){
      if(carros.get(i).id == id){
        return i;
      }
    }
    return -1;
  }

public LinkedList<Nodo> dijkstra(Nodo inicio, Nodo destino) {
    HashMap<Integer, Integer> distancias = new HashMap<>();
    HashMap<Integer, Integer> padres = new HashMap<>();
    ArrayList<Nodo> visitados = new ArrayList<>();
    LinkedList<Nodo> recorrido = new LinkedList<>();
     ArrayList<Nodo> recorridoseguro = new ArrayList<>();

    for (Nodo nodo : nodos) {
        distancias.put(nodo.getID(), Integer.MAX_VALUE);
    }

    distancias.put(inicio.getID(), 0);

    while (!visitados.contains(destino)) {
        Nodo actual = null;
        int minDistancia = Integer.MAX_VALUE;

        // Encuentra el nodo con la distancia mínima no visitado
        for (Nodo nodo : nodos) {
            if (!visitados.contains(nodo) && distancias.get(nodo.getID()) < minDistancia) {
                actual = nodo;
                minDistancia = distancias.get(nodo.getID());
            }
        }

        if (actual == null) {
            break;
        }

        visitados.add(actual);

        for (Arista arista : actual.getAristas()) {
            if (!visitados.contains(nodos.get(arista.nodoDestinoId))) {
                float distanciaTentativa = distancias.get(actual.getID()) + arista.distancia;
                if (distanciaTentativa < distancias.get(arista.nodoDestinoId)) {
                    distancias.put(arista.nodoDestinoId, (int) distanciaTentativa);
                    padres.put(arista.nodoDestinoId, actual.getID());
                }
            }
        }
    }

    // Construye el recorrido desde el destino hacia el inicio
    int nodoActualID = destino.getID();
    while (nodoActualID != inicio.getID() && padres.get(nodoActualID) != null) {
        recorrido.add(nodos.get(nodoActualID));
        nodoActualID = padres.get(nodoActualID);
    }
    recorrido.add(inicio);
    Collections.reverse(recorrido); // Invierte el recorrido para que vaya desde el inicio al destino

    return recorrido;
}

  public void borrarCarros() {
    carros.clear();
  }

  public Nodo getNodoPorId(int id) {
    for (Nodo nodo : nodos) {
      if (nodo.getID() == id) {
        return nodo;
      }
    }
    return null;
  }

  public ArrayList<Carro> getCarros() {
    return carros;
  }

  public ArrayList<Nodo> getNodos() {
    return nodos;
  }
  
  public void clearAll(){
    nodos.clear();
    aristas.clear();
    carros.clear();
    nodosThreads.clear();
    nCarros = 0;
    nCarrosEspera = 0;
  }



  public void display() {
    for (Arista arista : aristas) {
      arista.display();
    }
    for (Nodo nodo : nodos) {
      //nodo.update();
      nodo.display();
      //Thread nodoT = new Thread(nodo);
      //nodoT.start();
    }
    for (Carro carro : carros) {
      carro.update();
      carro.display();
      //Thread carroT = new Thread(carro);
      //carroT.start();
    }
  }

  public void update() {
  }
}
