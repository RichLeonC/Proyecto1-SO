class Grafo{
  private ArrayList<Nodo> nodos;
  private ArrayList<Arista> aristas;
  private ArrayList<Carro> carros;
  private static final int INF = Integer.MAX_VALUE;  //valor asignado como distancia que no interesa o interfiere en lo final
  private int radio = 300;
  public int nCarros;
  
  Grafo(){
    this.nodos = new ArrayList();
    this.aristas = new ArrayList();
    this.carros = new ArrayList();
  
  }
  
  /*public void addNodo(float radio,PVector pos,float alpha){
    nodos.add(new Nodo(radio,pos,alpha));
    
  }*/
  
  public void generarNodos(float numNodos){
    int centroX = width * 1320 / 1920;
    int centroY = height/2;
    nodos = new ArrayList();
    for (int i = 0; i < numNodos; i++) {
      float angulo = TWO_PI / numNodos * i;
      float x = centroX + cos(angulo) * radio;
      float y = centroY + sin(angulo) * radio;
      nodos.add(new Nodo(constrain(radio/numNodos,30,30),new PVector(x,y),2,i));
    }
  }
  
  public void addArista(float distancia,int nOrigen, int nDestino){
    Arista a = new Arista(distancia,nOrigen,nDestino);
    nodos.get(nOrigen).addArista(a);
    aristas.add(a);
  
  }
  
  public void addCarro(float x, float y,float velocidad,int objetivoId,float radio, int id){
    carros.add(new Carro(x,y,velocidad,objetivoId,radio*5, id));
  }
  
  public   HashMap<Nodo, Integer> dijkstra(ArrayList<Nodo> grafo,Nodo inicio,Nodo destino){
       HashMap<Integer, Integer> distancias = new HashMap<>();
       HashMap<Nodo, Nodo> padres = new HashMap<>();
       ArrayList<Nodo> visitados = new ArrayList();
       ArrayList<Nodo> recorrido = new ArrayList();
       
       
         for (Nodo nodo : grafo) {
            distancias.put(nodo.getID(), Integer.MAX_VALUE);
        }
        
        distancias.put(inicio.getID(), 0);
        Nodo actual = inicio;
        
        while(!visitados.contains(destino)){
            visitados.add(actual);
          //  ArrayList<Arista> vecinos = actual.getAristas(); 
            
            
             for (Arista arista : actual.getAristas()) {
                if (!visitados.contains(getNodoPorId(arista.getDestino()))) {
                    float distanciaTentativa = distancias.get(actual.getID()) + arista.distancia;
                    if (distanciaTentativa < distancias.get(arista.nodoDestinoId)) { //compara el comino con el infinito anteriormente guardado
                        distancias.put(arista.nodoDestinoId, int (distanciaTentativa));
                        padres.put(getNodoPorId(arista.getDestino()), actual);// guarda nodo como destino como key, guarda el nodo actual
                        
                    }
                }
            }
            
            Nodo nodoMinDistancia = null;
            int minDistancia = Integer.MAX_VALUE;
            
             for (Nodo nodo : grafo) {
                if (!visitados.contains(nodo) && distancias.get(nodo.getID()) < minDistancia) {
                    nodoMinDistancia = nodo;
                    minDistancia = distancias.get(nodo.getID());
                }
            }
            if (nodoMinDistancia == null) {
                break;
            }

            actual = nodoMinDistancia;
         
        
        }
       
       
  
        return obtenerCaminoMasCorto(padres, inicio, destino);
      }
      
    
       private  HashMap<Nodo, Integer> obtenerCaminoMasCorto(HashMap<Nodo, Nodo> padres, Nodo inicio, Nodo destino) {
        HashMap<Nodo, Integer> caminoMasCorto = new HashMap<>();
        Nodo actual = destino;
        int distanciaTotal = 0;

        while (actual != null) {
            caminoMasCorto.put(actual, distanciaTotal);
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
 
  
  public void borrarCarros(){
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
  
  public ArrayList<Carro> getCarros(){
    return carros;
  }
  
  public ArrayList<Nodo> getNodos(){
    return nodos;
  }
  
 
  
  public void display(){
    for(Arista arista : aristas) {
      arista.display();
    }
    for (Nodo nodo : nodos) {
      nodo.update();
      nodo.display();
    }
    for(Carro carro : carros) {
      carro.update();
      carro.display();
    }
  }
  
  public void update(){
  
  }


}
