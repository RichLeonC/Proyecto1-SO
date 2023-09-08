import controlP5.*;

Arista arista;
Carro carro;
ControlP5 cp5;
String inputData = "";
Button saveButton;
PGraphics configCanvas;
PGraphics grafoCanvas;
PFont font;

void setup() {
  size(1280, 720);
  // background(220);
  cp5 = new ControlP5(this);
  arista = new Arista(30, new PVector(width/2, height/2), new PVector(200, 200), color(255, 255, 255));
  carro = new Carro(width/2, height/2, 1, new PVector(0, 1), 10);

  font = createFont("Arial", 16);

  configCanvas = createGraphics(width * 1/2, height);
  // configCanvas.background(#001f3f);
  grafoCanvas = createGraphics(width * 3/4, height);

  Group configGroup = cp5.addGroup("Config")
    .setPosition(0, 0)
    .setWidth(width / 4)
    .setHeight(height);


  panelConfigUI();
}

void panelConfigUI() {
  Textfield nodesField = cp5.addTextfield("NODOS")
    .setPosition(20, 20)
    .setSize(75, 30)
    .setAutoClear(true);

  nodesField.getCaptionLabel().setSize(14);
  nodesField.setFont(font);

  Button btnIncrement = cp5.addButton("incremento")
    .setPosition(110, 20)
    .setSize(30, 30)
    .setCaptionLabel("+");

  Button btnDecrement = cp5.addButton("decremento")
    .setPosition(150, 20)
    .setSize(30, 30)
    .setCaptionLabel("-");
    
    btnIncrement.getCaptionLabel().setSize(14);
    btnDecrement.getCaptionLabel().setSize(14);
    
  Button btnCreateTable = cp5.addButton("createTable")
  .setPosition(200,20)
  .setSize(90,30)
  .setCaptionLabel("Crear tabla");
  
  btnCreateTable.getCaptionLabel().setSize(14);
}

void draw() {
  background(255);
  //arista.display();
  // carro.display();
  //carro.update();
  stroke(0);
  strokeWeight(10);
  noFill();
  rect(0, 0, width / 2.5, height);

  drawConfigCanvas();
  image(configCanvas, 0, 0);
  drawGrafoCanvas();
  image(grafoCanvas, width/2.5, 0);



  //if (cp5.getController("saveButton").isMousePressed()) {
  //  // Obtener el texto ingresado en el campo de texto
  //  inputData = cp5.get(Textfield.class, "inputField").getText();
  //  // Aquí puedes procesar o guardar los datos como desees
  //  println("Datos ingresados: " + inputData);
  //}
}

void drawGrafoCanvas() {
  grafoCanvas.beginDraw();
  grafoCanvas.background(#001f3f);

  // LOS DIBUJOS DE LOS NODOS,ARISTAS Y  IRAN ACA

  grafoCanvas.endDraw();
}

void drawConfigCanvas() {
  configCanvas.beginDraw();
  configCanvas.background(150);



  configCanvas.endDraw();
}
