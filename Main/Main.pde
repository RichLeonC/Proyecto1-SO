import controlP5.*;

//COLORES
//AZUL: #001f3f
//NARANJA: #FF5733
//GRIS: 150
//VERDE: #39FF14

//NODOS: NARANJA
//ARISTAS: VERDE
//CARROS: GRIS o BLANCO

Arista arista;
Carro carro;
ControlP5 cp5;

PGraphics configCanvas;
PGraphics grafoCanvas;
PFont font;
PFont fontBTN;
boolean alert;
boolean tableDone;
Grafo grafo = new Grafo();

Textfield nodesField;
Textfield[][] cells;
Textlabel[] rowLabels;
Textlabel[] colLabels;
Textfield[]alphasField;

float[][]table;
float[]alphas;
int nodes;


void setup() {
  size(1920, 1080);
  // background(220);
  cp5 = new ControlP5(this);
  //arista = new Arista(30, new PVector(width/2, height/2), new PVector(200, 200), color(255, 255, 255));
  carro = new Carro(width/2, height/2, 1, new PVector(0, 1), 10);
  tableDone = false;
  font = createFont("Arial", 16);
  fontBTN = createFont("Arial Black", 16);

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
  nodesField = cp5.addTextfield("NODOS")
    .setPosition(20, 20)
    .setText("0")
    .setSize(75, 30)
    .setAutoClear(true);

  nodesField.getCaptionLabel().setSize(14);
  nodesField.setFont(font);

  Button btnIncrement = cp5.addButton("incremento")
    .setPosition(110, 20)
    .setSize(30, 30)
    .setCaptionLabel("+")
    .setColorBackground(#FF5733);

  Button btnDecrement = cp5.addButton("decremento")
    .setPosition(150, 20)
    .setSize(30, 30)
    .setCaptionLabel("-")
    .setColorBackground(#FF5733);

  btnIncrement.getCaptionLabel().setSize(14);
  btnDecrement.getCaptionLabel().setSize(14);

  Button btnCreateTable = cp5.addButton("createTable")
    .setPosition(width*200/1920, height *20/1080)
    .setSize(width *120/1920, height*30/1080)
    .setColorBackground(#FF5733)
    .setFont(fontBTN)
    .setCaptionLabel("Crear tabla");

  btnCreateTable.getCaptionLabel().setSize(14);

  Button btnStart = cp5.addButton("start")
    .setPosition(width * 400/1920, height*950/1080)
    .setSize(width*150/1920, height*60/1080)
    .setColorBackground(#FF5733)
    .setFont(fontBTN)
    .setCaptionLabel("Iniciar");

  btnStart.getCaptionLabel().setSize(16);
  
  //if(!tableDone) btnStart.setLock(true);
  //else btnStart.setLock(false);

  Button btnStop = cp5.addButton("stop")
    .setPosition(width * 600/1920, height*950/1080)
    .setSize(width*150/1920, height*60/1080)
    .setColorBackground(#FF5733)
    .setFont(fontBTN)
    .setCaptionLabel("Detener");

  btnStop.getCaptionLabel().setSize(16);
}




void controlEvent(ControlEvent event) {
  if (event.isController()) {
    for (int i = 0; i < nodes; i++) {
      for (int j = 0; j < nodes; j++) {
      String textFieldName = i + "." + j;
      if (event.getName().equals(textFieldName)) {
        String texto = event.getStringValue();
        println("Texto en " + textFieldName + ": " + texto);
      }
     }
   }
    if (event.getName().equals("createTable")) {
      try {
        String nodes1 = nodesField.getText();
        nodes = Integer.parseInt(nodes1);
        createTable(nodes, nodes);
        grafo.generarNodos(nodes);
        tableDone = true;
      }
      catch(Error error) {
        print("Error en textfield nodos");
      }
    }
    if (event.getName().equals("incremento")) {
      String nodes = nodesField.getText();
      int numNodes = Integer.parseInt(nodes);
      numNodes++;
      String newNodes = String.valueOf(numNodes);
      nodesField.setText(newNodes);
    }

    if (event.getName().equals("decremento")) {
      String nodes = nodesField.getText();
      int numNodes = Integer.parseInt(nodes);
      if (numNodes>0) numNodes--;

      String newNodes = String.valueOf(numNodes);
      nodesField.setText(newNodes);
    }
    
    if(event.getName().equals("start")){
      startSimulation();
    }
  }
}

void createTable(int rows, int cols) {
  int cellWidth = 50;
  int cellHeight = 40;
  int labelCount = 0;
  int lastPosition = 0;
  
  if (rows>9) {
    cellWidth = 40;
  }

  cells = new Textfield[rows][cols];
  rowLabels = new Textlabel[rows];
  colLabels = new Textlabel[cols];
  int x = 40;
  int y = 120;


  for (int i = 0; i < rows; i++) {
    rowLabels[i] = cp5.addTextlabel("FilaLabel_"+i)
      .setText(""+i)
      .setPosition(10, y + i * cellHeight+10)
      .setColorValue(color(255))
      .setFont(font);

    for (int j = 0; j<cols; j++) {
      if (labelCount<cols) {
        colLabels[j] = cp5.addTextlabel("ColLabel_" + j)
          .setText("" + j)
          .setPosition(x + j * cellWidth, 90)
          .setColorValue(color(255))
          .setFont(font);
        labelCount++;
      }
      cells[i][j] = cp5.addTextfield(""+i+"."+j)
        .setPosition(x + j * cellWidth, y + i * cellHeight)
        .setSize(cellWidth, cellHeight)
        .setFont(font)
        .setCaptionLabel("")
        .setAutoClear(false);
    }
    if (i==rows-1) lastPosition = y+i*cellHeight;
  }

  alphasRow(rows, lastPosition, cellWidth);
}

void alphasRow(int nodes, int lastPosition, int cellWidth) {
  int cellHeight = 40;
  int x = 40;

  alphasField = new Textfield[nodes];

  for (int i = 0; i<nodes; i++) {
    alphasField[i] = cp5.addTextfield("a"+i)
      .setPosition(x + i*cellWidth, lastPosition+70)
      .setSize(cellWidth, cellHeight)
      .setFont(font)
      .setAutoClear(true);
  }
}

void checkTable() {
}

void startSimulation() {
  String cell;
  float cellValue;
  String alphaCell;
  float alphaValue;
  
  alphas = new float[nodes];
  table = new float[nodes][nodes];
  for (int i = 0; i<nodes; i++) {
    alphaCell = alphasField[i].getText();
    if (alphaCell.equals("") || alphaCell.equals(" ")) {
      alphaValue = 0;
    } else {
      alphaValue = Float.parseFloat(alphaCell);
    }
    alphas[i] = alphaValue;
    println("a"+i+" = "+alphas[i]);

    for (int j = 0; j<nodes; j++) {
      cell = cells[i][j].getText();
      if (cell.equals("") || cell.equals(" ")) {
        cellValue = 0;
      } else {
        cellValue = Float.parseFloat(cell);
      }

      table[i][j] = cellValue;
      if(cellValue != 0){
        grafo.addArista(table[i][j],i,j);
      }
      println("i: "+i+" - j: "+j+" = "+table[i][j]);
    }
  }
}

void draw() {
  background(255);
  grafo.display();
  //arista.display();
  // carro.display();
  //carro.update();
  stroke(0);
  strokeWeight(10);
  noFill();
  rect(0, 0, width / 2.5, height);
  //grafo.display();
  drawConfigCanvas();
  image(configCanvas, 0, 0);
  //drawGrafoCanvas();
  image(grafoCanvas, width/2.5, 0);
  
}

void drawGrafoCanvas() {
  grafoCanvas.beginDraw();
  grafoCanvas.background(#001f3f);
  // LOS DIBUJOS DE LOS NODOS,ARISTAS, CARROS IRAN ACA

  grafoCanvas.endDraw();
}

void drawConfigCanvas() {
  configCanvas.beginDraw();
  configCanvas.background(150);



  configCanvas.endDraw();
}
