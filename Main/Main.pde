import controlP5.*;

Arista arista;
Carro carro;
ControlP5 cp5;

PGraphics configCanvas;
PGraphics grafoCanvas;
PFont font;

Textfield nodesField;
Textfield[][] cells;
Textlabel[] rowLabels;    // Etiquetas de fila
Textlabel[] colLabels;    // Etiquetas de columna

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
  nodesField = cp5.addTextfield("NODOS")
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
    .setPosition(200, 20)
    .setSize(90, 30)
    .setCaptionLabel("Crear tabla");

  btnCreateTable.getCaptionLabel().setSize(14);
}



void controlEvent(ControlEvent event) {
  if (event.isController()) {
    if (event.getName().equals("createTable")) {
      try {
        String nodes = nodesField.getText();
        int numNodes = Integer.parseInt(nodes);
        createTable(numNodes, numNodes);
      }
      catch(Error error) {
        print("Error en textfield nodos");
      }
    }
  }
}

void createTable(int rows, int cols) {
  int cellWidth = 50;
  int cellHeight = 40;

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
      colLabels[j] = cp5.addTextlabel("ColLabel_" + j)
        .setText("" + j)
        .setPosition(x + j * cellWidth, 90)
        .setColorValue(color(255))
        .setFont(font);

      cells[i][j] = cp5.addTextfield("" + i + "_" + j)
        .setPosition(x + j * cellWidth, y + i * cellHeight)
        .setSize(cellWidth, cellHeight)
        .setFont(font)
        .setAutoClear(true);
    }
  }
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
