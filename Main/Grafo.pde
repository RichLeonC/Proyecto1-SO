class Grafo{
  private ArrayList<Nodo> nodos;
  private ArrayList<Arista> aristas;
  private ArrayList<Carro> carros;
  
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
  
  public ArrayList<Nodo> dijkstra(Nodo inicio,Nodo destino){
    ArrayList<Nodo> nodosFinales = new ArrayList();
    return nodosFinales;
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
