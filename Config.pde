public static class Config {
  public static String HOST = "127.0.0.1";
  public static int PORT = 58082;
  public static int STRIPS = 40;
  public static int LEDS = 160;

  public static boolean ENABLE_GAMMA = false; //true;
  public static float GAMMA_VALUE = 2.5;
  public static float ZOOM = 4;
  public static float BRIGHTNESS = 1.0;
  public static float FRAMERATE = 60;
  public static float MODE_TIMEOUT = 300;

  public static boolean MAP_SWIRL = false;
  public static int MAP_WIDTH = 360;
  public static int MAP_HEIGHT = 360;
  public static int MAP_PADDING = 20;
  
  public static color[] PALETTE = new color[] {
    col(255,255,255),
    col(170,11,5),
    col(232,183,42),
    col(75,166,0),
    col(34,173,228),
    col(136,8,103),
    col(245,244,240),
    col(130,21,14)
  };
  

public static int[] STRIP_LOOKUP = new int[] {
    -1, -1, -1, -1, -1, -1, -1, -1, 
    -1, -1, -1, -1, -1, -1, -1, -1, 
    -1, -1, -1, -1, -1, -1, -1, -1, 
    -1, -1, -1, -1, -1, -1, -1, -1, 
    -1, -1, -1, -1, -1, -1, -1, -1 
  };
  public static boolean[] SWAP_LOOKUP = new boolean[] {
    false, false, false, false, false, false, false, false, 
    false, false, false, false, false, false, false, false, 
    false, false, false, false, false, false, false, false, 
    false, false, false, false, false, false, false, false, 
    false, false, false, false, false, false, false, false
  };

  public static int col(int r, int g, int b, int a) {
    return (a<<24) | (r<<16) | (g<<8) | b;
  }
  
  public static int col(int r, int g, int b) {
    return col(r,g,b,255);
  }
  
  public static int col(int b) {
    return col(b,b,b,255);
  }
}