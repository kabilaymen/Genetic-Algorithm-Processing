Vehicle[] vehicles;
Wall[] walls;
float target_x, target_y, target_d;
int timer, generation;
final int time = 500;

void setup() {
  size(800, 500);
  target_d = 40;
  target_x = width - target_d - 20;
  target_y = height/2;
  init();
}

void draw() {
  background(250);
  frameRate(1000);

  showTarget();
  for (Wall w : walls) {
    w.show();
  }
  for (Vehicle v : vehicles) {
    v.update();
    v.show();
  }

  next();
  infos();
}

void next() {
  timer++;
  if (timer > time) {
    generation++;
    crossover();
    mutate(2);
    timer = 0;
  }
}

void infos() {
  textFont(createFont("Comic Sans MS", 20));
  fill(200, 0, 0);
  text("Timer : "+timer, 20, 30);
  fill(200, 100, 0);
  text("Generation : #"+generation, 20, 30+textAscent());
}

void showTarget() {
  stroke(150, 10, 20);
  strokeWeight(2);
  fill(160, 60, 40, 100);
  ellipse(target_x, target_y, target_d, target_d);
}

void init() {
  timer = 0;
  generation = 1;
  vehicles = new Vehicle[200];
  for (int i = 0; i < vehicles.length; i++)
    vehicles[i] = new Vehicle(width/2, height/2, 2);
  walls = new Wall[0];
  for (int i = 0; i < walls.length; i++)
    walls[i] = new Wall(width/2-20/2, height/2-(height/4)/2, 20, height/4);
}

void crossover() {
  Vehicle[] newPop = new Vehicle[vehicles.length];

  float maxfit = 0;
  float[] fitness = new float[vehicles.length];
  for (int i = 0; i < vehicles.length; i++)
    vehicles[i].fitness = 1/dist(vehicles[i].pos.x, vehicles[i].pos.y, target_x, target_y);
  for (int i = 0; i < vehicles.length; i++)
    if (maxfit < vehicles[i].fitness) maxfit = vehicles[i].fitness;
  for (int i = 0; i < vehicles.length; i++) {
    vehicles[i].fitness /= maxfit;
    fitness[i] = vehicles[i].fitness;
  }

  Vehicle[] matingpool = DNA.getMatingPool(vehicles, fitness);
  for (int k = 0; k < vehicles.length; k++) {
    Vehicle A = matingpool[(int) random(matingpool.length)];
    Vehicle B = matingpool[(int) random(matingpool.length)];
    // Vehicle C = matingpool[(int) random(matingpool.length)];
    PVector[] genes = new PVector[time];
    for (int i = 0; i < genes.length; i++) {
      if (i <= time/2) genes[i] = A.dna.genes[i];
      else genes[i] = B.dna.genes[i];
      // if (i <= time/3) genes[i] = A.dna.genes[i];
      // else if (i > time/3 && i <= time*2/3) genes[i] = B.dna.genes[i];
      // else genes[i] = C.dna.genes[i];
    }
    newPop[k] = new Vehicle(width/2, height/2, 2, genes);
  }

  vehicles = newPop;
}

void mutate(float rate) {
  for (int i = 0; i < vehicles.length; i++)
    if (random(100) < rate) vehicles[i] = new Vehicle(width/2, height/2, 2);
}