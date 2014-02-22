class CameraInfo {
  String name;
  Integer resX;
  Integer resY;
  Integer fps;

  CameraInfo(String name, Integer resX, Integer resY, Integer fps) {
    this.name = name;
    this.resX = resX;
    this.resY = resY;
    this.fps = fps;
  }

  CameraInfo(String desc) {
    String regex = "^name=([^,]*),size=([0-9]+)x([0-9]+),fps=([0-9]+)$";
    String[] m = match(desc, regex);
    if (m != null && m.length == 5) {
      this.name = m[1];
      this.resX = int(m[2]);
      this.resY = int(m[3]);
      this.fps = int(m[4]);
    } else {
      println("Invalid camera description: [" + desc + "]");
    }
  }
  
}

