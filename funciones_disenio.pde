float minEdgeX = margin;
float maxEdgeX = sizeWidth - assetWidth - margin;

float minEdgeY = margin;
float maxEdgeY = sizeHeight - assetHeight - margin;

float dogX = margin;
float dogY = maxEdgeY + assetHeight - assetHeight;

// Total de fuegos default
int fireCount = 5;
int coordenateCount = 2;
int[][] firePos = new int[fireCount][coordenateCount];

int resetFireTime = 200;
int elapsedTime = 0;

void inicio() {
  estado = "inicio";
 reinicio();

  background(#EA2121);

  fill(255);
  text("-This is not Fine- THE GAME", 30, 100); 
  text("Para comenzar:\nApretá la tecla -n- para dirigirte \nal instructivo de juego, noble usuari@.", 20, 140);
}

void comandos() {
  estado= "instrucciones";
  background(#62C154);
  fill(255);
  textSize(14.5);
  text("Las teclas W,A,S y D controlarán el \nmovimiento del estimado Dogo.", 20, 50); 
  text("¡Esquiva el fuego y llega a la mesa antes\nde que te topes con el fuego!", 20, 105); 
  text("Cuando te sientas list@, toca la tecla -p- \ny a jugar!", 20, 150);
  textSize(12);
  text("(psss, presiona -R- para volver al inicio)", 29, 200);
}

void juego() {
  estado = "juego";
  makeScenario();
  
}

void makeScenario() { //display de pantalla juego y sus funciones
  background(background);
  image(checkpoint, checkpointX, checkpointY, checkpointXtam, checkpointYtam);
  image(dog, dogX, dogY, tamDogX, tamDogY);

  makeFire();
  checkBurnt();
  checkpointCheck();
}

void makeFire() {//plano que determina la duracion y reseteo del fuego if no collision
  if ((elapsedTime == resetFireTime || elapsedTime == 0) && estado == "juego") {
    resetFire();
    elapsedTime = 0;
  }

  elapsedTime += 1; //iteración del fuego con arreglo bidimensional para posX,posY
  for (int i = 0; i < firePos.length; i++) {
    image(fire, firePos[i][0], firePos[i][1]);
  }
}

void resetFire() { //array 

  for (int i = 0; i < fireCount; i++) {
    int[] coordinates = new int[2];

    coordinates[0] = int(random(minEdgeX, maxEdgeX));
    coordinates[1] = int(random(minEdgeY, maxEdgeY));

    firePos[i] = coordinates;
  }
}

void checkBurnt() {
  for (int i = 0; i < firePos.length; i++) {
    int minX = firePos[i][0];
    int maxX = minX + assetWidth;

    int minY = firePos[i][1];
    int maxY = minY + assetHeight;

    float maxDoggoX = dogX + assetWidth;
    float maxDoggoY = dogY + assetWidth;

    boolean checkMinX = dogX >= minX && dogX <= maxX;
    boolean checkMaxX = maxDoggoX >= minX && maxDoggoX <= maxX;

    boolean checkMinY = dogY >= minY && dogY <= maxY;
    boolean checkMaxY = maxDoggoY >= minY && maxDoggoY <= maxY;

    boolean cornerCheck = checkMinX && checkMinY ||
      checkMinX && checkMaxY ||
      checkMaxX && checkMinY ||
      checkMaxX && checkMaxY;
    println("corner check: ", cornerCheck);
    if (cornerCheck) {
      estado = "perder";
    }
  }
}

void checkpointCheck() {
  float minX = checkpointX;
  float maxX = checkpointX + checkpointXtam;

  float minY = checkpointY;
  float maxY = minY + assetHeight;

  float maxDoggoX = dogX + assetWidth;
  float maxDoggoY = dogY + assetWidth;

  boolean checkMinX = dogX >= minX && dogX <= maxX;
  boolean checkMaxX = maxDoggoX >= minX && maxDoggoX <= maxX;

  boolean checkMinY = dogY >= minY && dogY <= maxY;
  boolean checkMaxY = maxDoggoY >= minY && maxDoggoY <= maxY;

  boolean cornerCheck = checkMinX && checkMinY ||
    checkMinX && checkMaxY ||
    checkMaxX && checkMinY ||
    checkMaxX && checkMaxY;
  println("corner check: ", cornerCheck);
  if (cornerCheck) {
    estado = "ganar";
  }
}


void ganar() { //estado de ganar
  estado = "ganar";
  makeScenario();
  textSize(12);
  fill(255);
  text(fraseWin, 20, 180);
  image(end, 140, 75);
}

void perder() { //estado de perder
  estado = "perder";
  fill(#3E0B0B);
  text("psss, presiona -R- para volver al inicio", 25, 30);
  strokeWeight(9);
  textSize(15);
 
  makeScenario();
  text(tryAgain, 20, 60);
  
}

void creditos() {
  estado = "creditos";
  background (#72E6F0);
  text("psss, presiona -R- para volver al inicio", 10,10);
  for (int i = 0; i< infoAlumne.length; i++) {
    fill(0);
    textSize(11.5);
    text(infoAlumne[i], 10, 40*i);
  }
}

void reinicio() {
  estado= "inicio";

  elapsedTime = 0;
  dogX = margin;
  dogY = maxEdgeY + assetHeight - assetHeight;
}
