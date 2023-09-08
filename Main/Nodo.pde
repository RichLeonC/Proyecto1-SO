class Nodo {
  
  private float radio;
  private PVector pos;
  private float alpha;
  private boolean ocupado;
  private ArrayList<Carro> carrosEspera;
  
  Nodo(float radio, PVector pos, float alpha){
      this.radio = radio;
      this.alpha = alpha;
      this.pos = pos;
      this.ocupado =false;
      this.carrosEspera = new ArrayList();
  
  }

  public void generarCarro(){
    
      return ;
    
  }
  
  public void siguienteCarro(){
  
  }
  
  public boolean ponerEspera(Carro carro){
      return true;
  }

    public void display(){
  
  
  }
  
  public void update(){
  
  }

}
