final float dx = 10;
final float dy = 15;

class Vehicle {
  PVector pos, vel, acc;
  float max, fitness;
  boolean crashed, done;
  DNA dna;

  Vehicle(float x, float y, float s) {
    this.pos = new PVector(x, y);
    this.vel = new PVector();
    this.acc = new PVector();
    this.max = s;
    dna = new DNA(time);
    crashed = false;
    done = false;
  }

  Vehicle(float x, float y, float s, PVector[] a) {
    this.pos = new PVector(x, y);
    this.vel = new PVector();
    this.acc = new PVector();
    this.max = s;
    dna = new DNA(a);
    crashed = false;
    done = false;
  }

  void show() {
    pushMatrix();
    stroke(0);
    strokeWeight(2);
    translate(pos.x, pos.y);
    rotate(vel.heading()+PI/2);
    fill(0, 100);
    beginShape();
    vertex(-dx/2, dy/2);
    vertex(0, -dy/2);
    vertex(dx/2, dy/2);
    vertex(-dx/2, dy/2);
    endShape();
    popMatrix();
  }

  void applyForce(PVector force) {
    acc.add(force);
  }

  void update() {
    try {
      if (!crashed && !done) {
        applyForce(dna.genes[timer]);
        vel.add(acc);
        vel.limit(max);
        pos.add(vel);
        acc.mult(0);
      }

      if (pos.x < 0 || pos.x > width || pos.y < 0 || pos.y > height) {
        crashed = true;
        fitness /= 10;
      }
      for (int i = 0; i < walls.length; i++)
        if (!(pos.x < walls[i].x || pos.x > walls[i].x+walls[i].w || pos.y < walls[i].y || pos.y > walls[i].y+walls[i].h)) {
          crashed = true;
          fitness /= 10;
        }
      
      if (dist(pos.x, pos.y, target_x, target_y) < target_d/2) {
        done = true;
        fitness *= 10;
      }
    } 
    catch(Exception e) {
    }
  }
}