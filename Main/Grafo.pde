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
  
  public void addCarro(float velocidad,PVector direccion,float entrada,float salida){
    carros.add(new Carro(velocidad,direccion,entrada,salida));
  }
  
  public ArrayList<Nodo> dijkstra(Nodo inicio,Nodo destino){
    ArrayList<Nodo> nodosFinales;
    return nodosFinales;
  }
  
  public ArrayList<Nodo> getNodosVecinos(Nodo nodo){
    ArrayList<Nodo> vecinos;
    return vecinos;
  }
  
  public borrarCarros(){
    carros.clear();
  
  }
  
  public voidisplay(){
  
  
  }
  
  public void update(){
  
  }


}
