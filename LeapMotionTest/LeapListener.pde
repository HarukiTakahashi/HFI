// event listener for Leap motion 
class LeapListener extends Listener {

  void onConnect(final Controller controller) {
    println("LeapMotion is Connected!");
    // optimize tracking mode (HMD)
    controller.setPolicyFlags(Controller.PolicyFlag.POLICY_OPTIMIZE_HMD);
  }

  
  void onFrame(final Controller controller)
  {
    ConcurrentMap<Finger,Integer> fingerCount = new ConcurrentHashMap<Finger,Integer>();
    ConcurrentMap<Finger,PVector> fingerAve = new ConcurrentHashMap<Finger,PVector>();

    fingerPositions.clear();

    // I want to rewrite this smoothing...
    for (Finger finger : controller.frame().fingers())
    {
      fingerCount.put(finger, 0);
      PVector fp = new PVector(finger.tipPosition().getX(), finger.tipPosition().getY(), finger.tipPosition().getZ());
      fingerAve.put(finger, fp);
      
      for(int i = 0; i < 50;i++){
         for (Finger finger2 : controller.frame(i).fingers()){
           if(finger.id() == finger2.id()){
             PVector fp2 = new PVector(finger2.tipPosition().getX(), finger2.tipPosition().getY(), finger2.tipPosition().getZ());
             PVector ave = fingerAve.get(finger);
             ave.x += fp2.x;
             ave.y += fp2.y;
             ave.z += fp2.z;
             Integer c = fingerCount.get(finger);
             fingerCount.put(finger,++c);
           }
         }
      }
      
      PVector res = fingerAve.get(finger);
      res.x /= fingerCount.get(finger);
      res.y /= fingerCount.get(finger);
      res.z /= fingerCount.get(finger);
      
      fingerPositions.put(finger, res);
      
    }
  }
}