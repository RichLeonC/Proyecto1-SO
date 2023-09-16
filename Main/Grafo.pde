class Grafo{
  private ArrayList<Nodo> nodos;
  private ArrayList<Arista> aristas;
  private ArrayList<Carro> carros;
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
