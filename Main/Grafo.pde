class Grafo {
  public ArrayList<Nodo> nodos;
  private ArrayList<Arista> aristas;
  private ArrayList<Carro> carros;
  public ArrayList<Thread>nodosThreads;
  private static final int INF = Integer.MAX_VALUE;  //valor asignado como distancia que no interesa o interfiere en lo final
  private int radio = 300;
  public int nCarros;
  public int nCarrosEspera = 0;

  Grafo() {
    this.nodos = new ArrayList();
    this.aristas = new ArrayList();
    this.carros = new ArrayList();
    this.nodosThreads = new ArrayList();
  }

  /*public void addNodo(float radio,PVector pos,float alpha){
   nodos.add(new Nodo(radio,pos,alpha));
   
   }*/

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
    Arista a = new Arista(distancia, nOrigen, nDestino);
    nodos.get(nOrigen).addArista(a);
    aristas.add(a);
  }

  public void addCarro(float x, float y, float velocidad, int objetivoId, float radio, int id, LinkedList<Nodo> ruta ) {
    carros.add(new Carro(x, y, velocidad, radio*4, id, ruta));
  }

/*  public  ArrayList<Nodo> dijkstra(ArrayList<Nodo> grafo, Nodo inicio, Nodo destino) {
    HashMap<Integer, Integer> distancias = new HashMap<>();
    HashMap<Nodo, Nodo> padres = new HashMap<>();
    ArrayList<Nodo> visitados = new ArrayList();
    ArrayList<Nodo> recorrido = new ArrayList();


    for (Nodo nodo : grafo) {
      distancias.put(nodo.getID(), Integer.MAX_VALUE);
    }

    distancias.put(inicio.getID(), 0);
    Nodo actual = inicio;

    while (!visitados.contains(destino)) {
      visitados.add(actual);
      //  ArrayList<Arista> vecinos = actual.getAristas();


      for (Arista arista : actual.getAristas()) {
        if (!visitados.contains(getNodoPorId(arista.getDestino()))) {//el si el nodo actual no esta visitado
          float distanciaTentativa = distancias.get(actual.getID()) + arista.distancia;
          if (distanciaTentativa < distancias.get(arista.nodoDestinoId)) { //compara el comino con el infinito anteriormente guardado primera vez , depsues ya con la que haya
            distancias.put(arista.nodoDestinoId, int (distanciaTentativa));
            padres.put(getNodoPorId(arista.getDestino()), actual);// guarda nodo como destino como key, guarda el nodo actual
          }
        }
      }

      Nodo nodoMinDistancia = null;
      int minDistancia = Integer.MAX_VALUE;

      for (Nodo nodo : grafo) {
        if (!visitados.contains(nodo) && distancias.get(nodo.getID()) < minDistancia) {//si el nodo no fue visitado y la distancia del nodo  es menor al infinito
          nodoMinDistancia = nodo;//se asigna como el nodo que tiene la menor distancia
          minDistancia = distancias.get(nodo.getID());// y la minima distancia pasa a ser la del nodo que estoy recorriendo
        }
      }
      if (nodoMinDistancia == null) {
        break;
      }

      actual = nodoMinDistancia;
    }


    recorrido = (ArrayList)padres.keySet();
    return recorrido;
  }


  private  HashMap<Nodo, Integer> obtenerCaminoMasCorto(HashMap<Nodo, Nodo> padres, Nodo inicio, Nodo destino) {
    HashMap<Nodo, Integer> caminoMasCorto = new HashMap<>();
    ArrayList<Nodo> recorrido = new ArrayList();
    Nodo actual = destino;
    int distanciaTotal = 0;

    while (actual != null) {
      //  caminoMasCorto.put(actual, distanciaTotal);
      recorrido.add(actual);
      if (actual == inicio) {
        break;
      }
      distanciaTotal += obtenerPesoArista(padres.get(actual), actual);
      actual = padres.get(actual);
    }

    return caminoMasCorto;
  }


  private  float obtenerPesoArista(Nodo origen, Nodo destino) {
    for (Arista arista : origen.aristas) {
      if (arista.nodoDestinoId == destino.getID()) {
        return arista.distancia;
      }
    }
    return Integer.MAX_VALUE;
  }

*/

boolean existeCaminoEntreNodos(int nodoInicio, int nodoFin) {
  // Crear un arreglo de booleanos para llevar un registro de los nodos visitados
  boolean[] visitados = new boolean[nodos.size()];
  

  // Llamar a la función de búsqueda en profundidad
  return dfs(nodoInicio, nodoFin, visitados);
}

boolean dfs(int nodoActual, int nodoFin, boolean[] visitados) {
  // Marcar el nodo actual como visitado
  visitados[nodoActual - 1] = true;

  // Si hemos llegado al nodo de destino, se ha encontrado un camino
  if (nodoActual == nodoFin) {
    return true;
  }

  // Recorrer las aristas para encontrar un nodo vecino no visitado
  for (Arista arista : aristas) {
    //if (arista.nodoOrigenId == nodoActual && !visitados[arista.nodoDestinoId - 1]) {
      // Llamada recursiva para explorar el nodo vecino
      if (dfs(arista.nodoDestinoId, nodoFin, visitados)) {
        return true;
      }
    //}
  }

  // Si no se encontró un camino, retornar false
  return false;
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
    while (nodoActualID != inicio.getID()) {
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
