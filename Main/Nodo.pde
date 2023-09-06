class Nodo {
  
  private float radio;
  private PVector pos;
  private float alpha;
  private boolean ocupado;
  private ArrayList<Carro> carrosEspera;
  
  Nodo(float radio, PVector pos, float alpha, boolean ocupado){
      this.radio = radio;
      this.alpha = alpha;
      this.pos = pos;
      this.ocupado =ocupado;
      this.carrosEspera = new ArrayList();
  
  }

  public Carro generarCarro(){
      return Carro;
    
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
