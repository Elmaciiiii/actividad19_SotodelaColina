// 🌟 Clase para manejar varias pelotitas
class Pelotita {
  float x, y;
  float xSpeed, ySpeed;
  float diametro;
  color pelotaColor;
  boolean esAzul;

  Pelotita(float _x, float _y, float _xSpeed, float _ySpeed, float _d, boolean azulInicial) {
    x = _x;
    y = _y;
    xSpeed = _xSpeed;
    ySpeed = _ySpeed;
    diametro = _d;
    esAzul = azulInicial;
    if (azulInicial) {
      pelotaColor = color(0, 0, 255); // azul
    } else {
      pelotaColor = color(255, 0, 0); // rojo
    }
  }

  void actualizar() {
    x += xSpeed;
    y += ySpeed;

    // Rebote contra bordes
    if (x > width - diametro/2 || x < diametro/2) xSpeed *= -1;
    if (y > height - diametro/2 || y < diametro/2) ySpeed *= -1;
  }

  void dibujar() {
    fill(pelotaColor);
    noStroke();
    ellipse(x, y, diametro, diametro);

    // Efecto de brillo
    fill(255, 255, 255, 100);
    ellipse(x - diametro/6, y - diametro/6, diametro/3, diametro/3);
  }

  void cambiarColor() {
    if (esAzul) {
      pelotaColor = color(255, 0, 0); // cambia a rojo
      esAzul = false;
    } else {
      pelotaColor = color(0, 0, 255); // cambia a azul
      esAzul = true;
    }
  }
}

// 📷 Variables para las imágenes
PImage fondo;
PImage imagen;

// Lista de pelotitas
ArrayList<Pelotita> pelotitas;

// Estado de instrucciones
boolean mostrarInstrucciones = true;
int tiempoInstrucciones = 0;

void setup() {
  size(800, 600);

  // 🔹 Cargar imágenes
  fondo = loadImage("fondo.jpg");
  imagen = loadImage("logo.png");

  // Inicializar lista de pelotitas
  pelotitas = new ArrayList<Pelotita>();

  // Crear 3 pelotitas iniciales (2 azules y 1 roja)
  pelotitas.add(new Pelotita(width/2, height/2, 3, 2, 50, true));
  pelotitas.add(new Pelotita(200, 300, -2, 3, 40, false));
  pelotitas.add(new Pelotita(600, 200, 2.5, -2.5, 45, true));

  tiempoInstrucciones = millis();
}

void draw() {
  // 🖼 Fondo ajustado
  image(fondo, 0, 0, width, height);

  // 📷 Logo en la esquina
  image(imagen, width - 120, 20, 100, 100);

  // 🔴⚫ Dibujar todas las pelotitas
  for (Pelotita p : pelotitas) {
    p.actualizar();
    p.dibujar();
  }

  // 🔤 Mostrar nombre
  drawNombre();

  // ℹ️ Contador de pelotitas
  fill(255);
  textSize(16);
  textAlign(RIGHT);
  text("Pelotitas: " + pelotitas.size(), width - 10, height - 20);

  // 📝 Instrucciones
  if (mostrarInstrucciones && millis() - tiempoInstrucciones < 7000) {
    dibujarInstrucciones();
  }
}

// ✍ Dibujar "MAXI" con figuras geométricas
void drawNombre() {
  stroke(255);
  strokeWeight(6);

  // M
  line(60, 500, 60, 400);
  line(60, 400, 90, 450);
  line(90, 450, 120, 400);
  line(120, 400, 120, 500);

  // A
  line(150, 500, 180, 400);
  line(210, 500, 180, 400);
  line(160, 460, 200, 460);

  // X
  line(240, 400, 280, 500);
  line(280, 400, 240, 500);

  // I
  line(310, 400, 310, 500);
}

// 📝 Instrucciones con fondo azul y borde rojo
void dibujarInstrucciones() {
  // Fondo azul con contorno rojo
  stroke(200, 0, 0);
  strokeWeight(4);
  fill(0, 0, 150, 220);
  rect(width/2 - 200, 20, 400, 160, 15);

  // Título
  fill(255);
  textAlign(CENTER);
  textSize(18);
  text("INSTRUCCIONES", width/2, 50);

  // Texto
  textSize(14);
  text("Click izquierdo: Cambiar colores (Azul / Rojo)", width/2, 80);
  text("Click derecho: Agregar nueva pelotita", width/2, 105);
  text("Tecla 'M': Mostrar/Ocultar ayuda", width/2, 130);
}

// 🖱 Clicks
void mousePressed() {
  if (mouseButton == LEFT) {
    // Cambiar color de todas
    for (Pelotita p : pelotitas) {
      p.cambiarColor();
    }
  } else if (mouseButton == RIGHT) {
    // Nueva pelotita (aleatoria azul o roja)
    boolean esAzul = random(1) > 0.5;
    float velX = random(-4, 4);
    float velY = random(-4, 4);
    float diam = random(30, 60);
    pelotitas.add(new Pelotita(mouseX, mouseY, velX, velY, diam, esAzul));
  }
}

// ⌨ Teclado
void keyPressed() {
  if (key == 'm' || key == 'M') {
    mostrarInstrucciones = !mostrarInstrucciones;
    if (mostrarInstrucciones) tiempoInstrucciones = millis();
  }
}
