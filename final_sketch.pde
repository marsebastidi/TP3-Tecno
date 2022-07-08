//URL para el video explicativo https://youtu.be/X12KFRjdxqU
 
//ALUMNA MARINA SEBASTIAN DIAZ


PImage background;
PImage dog;
PImage fire;
PImage exit;
PImage end;
PImage checkpoint;
PImage reference;
PFont fuente;
String fraseWin = "¡ENHORABUENA, CHAVALETE!\n Lograste tu cometido,\nDoggo os agradece tu ayuda.";
String tryAgain = "Otro intento no hace daño a nadie.\n Etto...bueno, a tí no, claro.";
float tamDogX = 26;
float tamDogY = 35;

float checkpointX =160; 
float checkpointY= 90;
float checkpointYtam= 41;
float checkpointXtam = 69;

float fireTamX= 26;
float fireTamY= 35;

String estado;

String creditos;
String [] infoAlumne;

int assetWidth = 26;
int assetHeight = 35;

// ajustar con los valores en la llamada a size
int sizeWidth = 320;
int sizeHeight = 240;

int margin = 20;



void setup() {
  
  estado = "inicio";
  size(320, 240);
  textAlign(LEFT, BASELINE);
  textSize(15);

  background = loadImage("background.png");
  dog = loadImage("dog.png");
  fire = loadImage("fire.png");
  exit = loadImage("exit.png");
  end = loadImage("end.png");
  checkpoint = loadImage("checkpoint.png");
  reference = loadImage("reference.jpg");


  infoAlumne = new String[6];
  infoAlumne[0]= "-";
  infoAlumne[1]= "Alumna Marina Sebastián Díaz";
  infoAlumne[2]= "Comisión 2";
  infoAlumne[3]= "Legajo 85554/5";
  infoAlumne[4]= "El diseño del personaje no es creación \ndel todo mía, ha sido elaborada con ayuda externa\n a la universidad.";
  infoAlumne[5]= "\n¡Mis agradecimientos a mis compas!";
}

void draw() {
  if (estado.equals("inicio")) {
    inicio();
  } else if (estado.equals("instrucciones")) {
    comandos();
  } else if (estado.equals("creditos")) {
    creditos();
  } else if (estado.equals("juego")) {
    juego();
  } else if (estado.equals("ganar")) {
    ganar();
  } else if (estado.equals("perder")) {
    perder();
  } else if (estado.equals("reinicio")) {
    reinicio();
  }
}



void keyPressed() {
  if (estado.equals("inicio") && key == 'n') {
    estado= "instrucciones";
    comandos();
  } else if (estado.equals("instrucciones") && key == 'p') {
    estado = "juego";
    juego();
  } else if (estado.equals("instrucciones") && key == 'r') {
    reinicio();
  } else if (estado.equals("inicio") && key == 'c') {
    estado = "creditos";  
    creditos();
  } else if (estado.equals("creditos") && key== 'r') {
    estado= "inicio";
    reinicio();
  } else if (estado.equals("perder") && key == 'r') {
    estado = "inicio";
    inicio();
   
  } else if (estado.equals("ganar") && key == 'r') {
   estado = "inicio";
    reinicio();
  }

  //------------------reconfigurar
  float[] position = nextDoggoPosition();

  // Chequear si el proximo movimiento está adnetro del rango de movimiento
  boolean isInsideXRange = position[0] >= minEdgeX && position[0] <= maxEdgeX;
  boolean isInsideYRange = position[1] >= minEdgeY && position[1] <= maxEdgeY;

  // Si esta adentro del rango, movemos el doggo,
  // si no, dejamos donde estaba
  if (isInsideXRange && isInsideYRange && estado == "juego") {
    dogX = position[0];
    dogY = position[1];
  }
}

float[] nextDoggoPosition() {
  // Obtenemos la posicion actual del doggo
  float[] newPosition = { dogX, dogY };

  float vel = 2;

  // aplicamos desplazamiento
  if (key == 'w') {
    newPosition[1] -= vel;
  }

  if (key == 's') {
    newPosition[1] += vel;
  }

  if (key == 'a') {
    newPosition[0] -= vel;
  }

  if (key== 'd') {
    newPosition[0] += vel;
  }

  // devolvemos nueva posicion
  // en caso de que se haya apretado una tecla de movimiento
  return newPosition;
}
