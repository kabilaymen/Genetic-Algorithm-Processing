static class DNA {
  int time;
  PVector[] genes;
  
  DNA(int time) {
    this.time = time;
    genes = new PVector[time];
    for (int i = 0; i < time; i++)
      genes[i] = PVector.random2D().mult(0.1);
  }
  
  DNA(PVector[] genes) {
    this.time = genes.length;
    this.genes = genes;
  }
  
  static Vehicle[] getMatingPool(Vehicle[] vehicles, float[] fitness) {
    ArrayList<Vehicle> matingpool = new ArrayList<Vehicle>();
    for (int i = 0; i < fitness.length; i++) {
      int prc = (int) (100 * fitness[i]);
      for (int j = 0; j < prc; j++)
        matingpool.add(vehicles[i]);
    }
    Vehicle[] mp = new Vehicle[matingpool.size()];
    for (int i = 0; i < matingpool.size(); i++)
      mp[i] = matingpool.get(i);
    return mp;
  }
}