class Nodo {
  private int id;
  private float radio;
  private PVector pos;
  private float alpha;
  private boolean ocupado;
  private ArrayList<Carro> carrosEspera;
  private ArrayList<Arista> aristas;
  int lastTime = 0;
  int current;
  
  Nodo(float radio, PVector pos, float alpha, int id){
      this.id = id;
      this.radio = radio;
      this.alpha = alpha;
      this.pos = pos;
      this.ocupado =false;
      this.carrosEspera = new ArrayList();
      this.aristas = new ArrayList();
      this.current = millis();
  
  }

  public void generarCarro(){
      int i = 0;
      for(Arista a : aristas){
        grafo.addCarro(pos.x, pos.y, 2, aristas.get(i).nodoDestinoId, radio/10);
        i++;
      }
      return ;
    
  }
  
  public void addArista(Arista a){
    aristas.add(a);
  }
  
  public void siguienteCarro(){
  
  }
  
  public boolean ponerEspera(Carro carro){
      return true;
  }

  public void display(){
    circle(pos.x,pos.y,radio*2);
    current = millis();
    if (current - lastTime >= 2000) {
      lastTime = current;
      generarCarro();      
    }
  }
  
  public void update(){
  
  }

}
