class Carro extends Thread {
  float velocidad;
  PVector direccion;
  PVector acc;
  PVector vel;
  float horaSalida;
  float horaLlegada;
  float radio;
  PVector pos;
  color c;
  PVector objetivo;
  int objetivoId;
  LinkedList<Nodo> ruta;
  int id;
  boolean esperando = false;
  int objFinal;
  boolean cruzando = false;
  float tiempo;
  int aristaId;
  public void run() {
    update();
  }

  Carro(float x, float y, float vel, float radio, int id, LinkedList<Nodo> rutas, int aristaId) {
    this.ruta = rutas;
    this.aristaId = aristaId;
    this.id = id;
    this.objFinal = ruta.getLast().id;
    this.velocidad = vel*0.1;
    this.objetivoId = ruta.get(0).id;
    this.acc = new PVector(0, velocidad);
    PVector v = ruta.get(0).pos;
    this.objetivo = v.copy();
    this.pos = new PVector(x, y);
    if (x == ruta.get(0).pos.x) {
      if (y > ruta.get(0).pos.y) {
        this.objetivo.x-=radio;
        this.pos.x -= radio;
      } else {
        this.objetivo.x+=radio;
        this.pos.x += radio;
      }
    }
    if (y == ruta.get(0).pos.y) {
      if (x > ruta.get(0).pos.x) {
        this.objetivo.y+=radio;
        this.pos.y += radio;
      } else {
        this.objetivo.y-=radio;
        this.pos.y -= radio;
      }
    }
    if (x > ruta.get(0).pos.x) {
      if (y > ruta.get(0).pos.y) {
        this.objetivo.x+=radio;
        this.pos.x += radio;
      } else {
        this.objetivo.x-=radio;
        this.pos.x -= radio;
      }
    }
    if (y > ruta.get(0).pos.y) {
      if (x > ruta.get(0).pos.x) {
        this.objetivo.y-=radio;
        this.pos.y -= radio;
      } else {
        this.objetivo.y+=radio;
        this.pos.y += radio;
      }
    }
    if (y < ruta.get(0).pos.y) {
      if (x > ruta.get(0).pos.x) {
        this.objetivo.y-=radio;
        this.pos.y -= radio;
      } else {
        this.objetivo.y+=radio;
        this.pos.y += radio;
      }
    }
    this.horaSalida = millis();
    this.radio = radio;
    this.c = color(random(128, 255), random(128, 255), random(128, 255));
    this.direccion = PVector.sub(objetivo, pos);
    this.direccion.normalize();
  }

  public void setObjetivo(int objetivoId, LinkedList rutas){
    this.objetivoId = objetivoId;
    this.ruta = rutas;
  }
  
  public void cruzar(){
    this.cruzando = true;
    tiempo = millis();
  }
  
  public void siguienteNodo(){
    if(ruta.size() > 1){
      this.ruta.remove(0);
      this.objetivoId = this.ruta.get(0).id;
    }else {
      grafo.carros.remove(grafo.getCarroIndex(this.id));
      grafo.nCarros--;
    }
    this.esperando = false;
    this.cruzando = false;
    setearNuevaPosicion();
  }
  
  void setearNuevaPosicion(){
    PVector v = ruta.get(0).pos;
    this.objetivo = v.copy();
    float x = pos.x;
    float y = pos.y;
    if (x == ruta.get(0).pos.x) {
      if (y > ruta.get(0).pos.y) {
        this.objetivo.x-=radio;
        this.pos.x -= radio;
      } else {
        this.objetivo.x+=radio;
        this.pos.x += radio;
      }
    }
    if (y == ruta.get(0).pos.y) {
      if (x > ruta.get(0).pos.x) {
        this.objetivo.y+=radio;
        this.pos.y += radio;
      } else {
        this.objetivo.y-=radio;
        this.pos.y -= radio;
      }
    }
    if (x > ruta.get(0).pos.x) {
      if (y > ruta.get(0).pos.y) {
        this.objetivo.x+=radio;
        this.pos.x += radio;
      } else {
        this.objetivo.x-=radio;
        this.pos.x -= radio;
      }
    }
    if (y > ruta.get(0).pos.y) {
      if (x > ruta.get(0).pos.x) {
        this.objetivo.y-=radio;
        this.pos.y -= radio;
      } else {
        this.objetivo.y+=radio;
        this.pos.y += radio;
      }
    }
    if (y < ruta.get(0).pos.y) {
      if (x > ruta.get(0).pos.x) {
        this.objetivo.y-=radio;
        this.pos.y -= radio;
      } else {
        this.objetivo.y+=radio;
        this.pos.y += radio;
      }
    }
    this.horaSalida = millis();
    this.direccion = PVector.sub(objetivo, pos);
    this.direccion.normalize();
  }

  boolean touchAny() {
    float distancia = PVector.dist(objetivo, this.pos);
    if (grafo.getNodos().get(objetivoId).carrosEspera.size() != 0) {
      if ((distancia <= grafo.getNodos().get(objetivoId).radio + this.radio + this.radio*2 * (grafo.getNodos().get(objetivoId).carrosEspera.size()+1)) && !esperando) {
        this.esperando = true;
        // println(millis()-horaSalida);
        grafo.getNodos().get(objetivoId).carrosEspera.add(this);
        grafo.nCarrosEspera++;
        return true;
      }
    } else {
      if ((distancia <= grafo.getNodos().get(objetivoId).radio + this.radio) && !esperando) {
        this.esperando = true;
        //println(millis()-horaSalida);
        grafo.getNodos().get(objetivoId).carrosEspera.add(this);
       grafo.nCarrosEspera++;

        return true;
      }
    }
    return false;
  }

  void update() {
    /*vel.add(acc);
     pos.add(vel);
     acc.mult(0);*/
    if ( !esperando && !touchAny()) {
      pos.add(PVector.mult(direccion, velocidad));
    }
    //else{
    //pos.x = constrain(pos.x, radio,  - r);
    //pos.y = constrain(pos.y, radio, width - r);
    //println("Llego");
    //}
  }

  void avanzar(PVector v) {
    pos = v.copy();
  }

  void display() {
    //noStroke();
    stroke(153, 246, 214);
    fill(red(c), blue(c), green(c));
    circle(pos.x, pos.y, radio*2);
    PVector v = new PVector(mouseX, mouseY);
    float distancia = PVector.dist(v, this.pos);
    if (distancia <= this.radio*2) {
      // println("Distancia: ", distancia);
      fill(0);
      text("Objetivo: " + objFinal, this.pos.x, this.pos.y);
    }
  }
}
