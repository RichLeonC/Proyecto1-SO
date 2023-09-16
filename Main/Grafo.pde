class Grafo{
  private ArrayList<Nodo> nodos;
  private ArrayList<Arista> aristas;
  private ArrayList<Carro> carros;
  private static final int INF = Integer.MAX_VALUE;  //valor asignado como distancia que no interesa o interfiere en lo final
  
  Grafo(){
    this.nodos = new ArrayList();
    this.aristas = new ArrayList();
    this.carros = new ArrayList();
  
  }
  
  public void addNodo(float radio,PVector pos,float alpha){
    nodos.add(new Nodo(radio,pos,alpha));
    
  }
  
  public void addArista(float distancia,PVector nodoOrigen, PVector nodoDestino,color c){
    aristas.add(new Arista(distancia,nodoOrigen,nodoDestino,c));
  
  }
  
  public void addCarro(float x, float y,float velocidad,PVector direccion,float radio){
    carros.add(new Carro(x,y,velocidad,direccion,radio));
  }
  
  public ArrayList<Nodo> dijkstra(ArrayList<Arista> grafo,Nodo inicio,Nodo destino){
 
    boolean[] visitado = new boolean[ grafo.size()]; // marcas de nodos visitados
    int [] distancia = new int[ grafo.size()];//guarda la distnacias de las aristas 
    
      for (int i = 0; i < grafo.size(); i++) {
            distancia[i] = INF;//asigna todos como valores que no interesan aun para despues cambiarlos
        }
       
       distancia[inicio.getNombre()] = 0; 
      
      for (int i = 0; i < grafo.size()-1; i++){
          int distanciaMin = vecinoMasConfiable(distancia, visitado);
          visitado[distanciaMin] = true;
          
          
      
      }
      
    
    
    ArrayList<Nodo> nodosFinales = new ArrayList();
    return nodosFinales;
  }
  
  public int vecinoMasConfiable(int[] distancia, boolean[] visitado){
       int min = INF;
       int vecino = -1;

        for (int i = 0; i < distancia.length; i++) {
            if (!visitado[i] && distancia[i] < min) {
                min = distancia[i];
                vecino = i;
            }
        }
     
    return vecino;
  }
  
  
  public ArrayList<Nodo> getNodosVecinos(Nodo nodo){
    ArrayList<Nodo> vecinos = new ArrayList();
    return vecinos;
  }
  
  public void borrarCarros(){
    carros.clear();
  
  }
  
  public void display(){
  
  
  }
  
  public void update(){
  
  }


}
