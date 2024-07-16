
import java.util.Random;


//////////////////////////////////////////////////////////////

// PERLIN NOISE, rewriten by cfloutier to change the way cosinus is computed

// [toxi 040903]
// octaves and amplitude amount per octave are now user controlled
// via the noiseDetail() function.

// [toxi 030902]
// cleaned up code and now using bagel's cosine table to speed up

// [toxi 030901]
// implementation by the german demo group farbrausch
// as used in their demo "art": http://www.farb-rausch.de/fr010src.zip

static final int PERLIN_YWRAPB = 4;
static final int PERLIN_YWRAP = 1<<PERLIN_YWRAPB;
static final int PERLIN_ZWRAPB = 8;
static final int PERLIN_ZWRAP = 1<<PERLIN_ZWRAPB;
static final int PERLIN_SIZE = 4095;

int perlin_octaves = 4; // default to medium smooth
float perlin_amp_falloff = 0.5f; // 50% reduction/octave

// [toxi 031112]
// new vars needed due to recent change of cos table in PGraphics
int perlin_PI;
static final int perlin_TWOPI = 65536;

float[] perlin_cosTable;
float[] perlin;

Random perlinRandom;

/**
 */
public float noise(float x) {
  // is this legit? it's a dumb way to do it (but repair it later)
  return noise(x, 0f, 0f);
}

/**
 */
public float noise(float x, float y) {
  return noise(x, y, 0f);
}


/**
 * ( begin auto-generated from noise.xml )
 *
 * Returns the Perlin noise value at specified coordinates. Perlin noise is
 * a random sequence generator producing a more natural ordered, harmonic
 * succession of numbers compared to the standard <b>random()</b> function.
 * It was invented by Ken Perlin in the 1980s and been used since in
 * graphical applications to produce procedural textures, natural motion,
 * shapes, terrains etc.<br /><br /> The main difference to the
 * <b>random()</b> function is that Perlin noise is defined in an infinite
 * n-dimensional space where each pair of coordinates corresponds to a
 * fixed semi-random value (fixed only for the lifespan of the program).
 * The resulting value will always be between 0.0 and 1.0. Processing can
 * compute 1D, 2D and 3D noise, depending on the number of coordinates
 * given. The noise value can be animated by moving through the noise space
 * as demonstrated in the example above. The 2nd and 3rd dimension can also
 * be interpreted as time.<br /><br />The actual noise is structured
 * similar to an audio signal, in respect to the function's use of
 * frequencies. Similar to the concept of harmonics in physics, perlin
 * noise is computed over several octaves which are added together for the
 * final result. <br /><br />Another way to adjust the character of the
 * resulting sequence is the scale of the input coordinates. As the
 * function works within an infinite space the value of the coordinates
 * doesn't matter as such, only the distance between successive coordinates
 * does (eg. when using <b>noise()</b> within a loop). As a general rule
 * the smaller the difference between coordinates, the smoother the
 * resulting noise sequence will be. Steps of 0.005-0.03 work best for most
 * applications, but this will differ depending on use.
 *
 * ( end auto-generated )
 *
 * @webref math:random
 * @param x x-coordinate in noise space
 * @param y y-coordinate in noise space
 * @param z z-coordinate in noise space
 * @see PApplet#noiseSeed(long)
 * @see PApplet#noiseDetail(int, float)
 * @see PApplet#random(float,float)
 */
public float noise(float x, float y, float z) {
  if (perlin == null) {
    if (perlinRandom == null) {
      perlinRandom = new Random();
    }
    perlin = new float[PERLIN_SIZE + 1];
    for (int i = 0; i < PERLIN_SIZE + 1; i++) {
      perlin[i] = perlinRandom.nextFloat(); //(float)Math.random();
    }

    perlin_cosTable = new float[perlin_TWOPI];
    perlin_PI = perlin_TWOPI >> 1;
    for (int i = 0; i < perlin_TWOPI; i++)
    {
      float angle = (float)i/perlin_PI;

      perlin_cosTable[i] =  cos( angle * PI );
    }
  }

  if (x<0) x=-x;
  if (y<0) y=-y;
  if (z<0) z=-z;

  int xi=(int)x, yi=(int)y, zi=(int)z; //<>//
  float xf = x - xi;
  float yf = y - yi;
  float zf = z - zi;
  float rxf, ryf;

  float r=0;
  float ampl=0.5f;

  float n1, n2, n3;

  for (int i=0; i<perlin_octaves; i++) {
    int of=xi+(yi<<PERLIN_YWRAPB)+(zi<<PERLIN_ZWRAPB);

    rxf=noise_fsc(xf);
    ryf=noise_fsc(yf);

    n1  = perlin[of&PERLIN_SIZE];
    n1 += rxf*(perlin[(of+1)&PERLIN_SIZE]-n1);
    n2  = perlin[(of+PERLIN_YWRAP)&PERLIN_SIZE];
    n2 += rxf*(perlin[(of+PERLIN_YWRAP+1)&PERLIN_SIZE]-n2);
    n1 += ryf*(n2-n1);

    of += PERLIN_ZWRAP;
    n2  = perlin[of&PERLIN_SIZE];
    n2 += rxf*(perlin[(of+1)&PERLIN_SIZE]-n2);
    n3  = perlin[(of+PERLIN_YWRAP)&PERLIN_SIZE];
    n3 += rxf*(perlin[(of+PERLIN_YWRAP+1)&PERLIN_SIZE]-n3);
    n2 += ryf*(n3-n2);

    n1 += noise_fsc(zf)*(n2-n1);

    r += n1*ampl;
    ampl *= perlin_amp_falloff;
    xi<<=1; 
    xf*=2;
    yi<<=1; 
    yf*=2;
    zi<<=1; 
    zf*=2;

    if (xf>=1.0f) { 
      xi++; 
      xf--;
    }
    if (yf>=1.0f) { 
      yi++; 
      yf--;
    }
    if (zf>=1.0f) { 
      zi++; 
      zf--;
    }
  }
  return r;
}

// [toxi 031112]
// now adjusts to the size of the cosLUT used via
// the new variables, defined above
private float noise_fsc(float i) {
  // using bagel's cosine table instead

  int index = (int)(i*perlin_PI)%perlin_TWOPI;
  float cosvalue = perlin_cosTable[index];

  // for a very precise cosinus, just un-comment this line (all cos table is uselless then you can remove it as well
  // cosvalue = cos(i*PI);

  return 0.5f*(1.0f-cosvalue);
}

// [toxi 040903]
// make perlin noise quality user controlled to allow
// for different levels of detail. lower values will produce
// smoother results as higher octaves are surpressed

/**
 * ( begin auto-generated from noiseDetail.xml )
 *
 * Adjusts the character and level of detail produced by the Perlin noise
 * function. Similar to harmonics in physics, noise is computed over
 * several octaves. Lower octaves contribute more to the output signal and
 * as such define the overal intensity of the noise, whereas higher octaves
 * create finer grained details in the noise sequence. By default, noise is
 * computed over 4 octaves with each octave contributing exactly half than
 * its predecessor, starting at 50% strength for the 1st octave. This
 * falloff amount can be changed by adding an additional function
 * parameter. Eg. a falloff factor of 0.75 means each octave will now have
 * 75% impact (25% less) of the previous lower octave. Any value between
 * 0.0 and 1.0 is valid, however note that values greater than 0.5 might
 * result in greater than 1.0 values returned by <b>noise()</b>.<br /><br
 * />By changing these parameters, the signal created by the <b>noise()</b>
 * function can be adapted to fit very specific needs and characteristics.
 *
 * ( end auto-generated )
 * @webref math:random
 * @param lod number of octaves to be used by the noise
 * @see PApplet#noise(float, float, float)
 */
public void noiseDetail(int lod) {
  if (lod>0) perlin_octaves=lod;
}

/**
 * @see #noiseDetail(int)
 * @param falloff falloff factor for each octave
 */
public void noiseDetail(int lod, float falloff) {
  if (lod>0) perlin_octaves=lod;
  if (falloff>0) perlin_amp_falloff=falloff;
}

/**
 * ( begin auto-generated from noiseSeed.xml )
 *
 * Sets the seed value for <b>noise()</b>. By default, <b>noise()</b>
 * produces different results each time the program is run. Set the
 * <b>value</b> parameter to a constant to return the same pseudo-random
 * numbers each time the software is run.
 *
 * ( end auto-generated )
 * @webref math:random
 * @param seed seed value
 * @see PApplet#noise(float, float, float)
 * @see PApplet#noiseDetail(int, float)
 * @see PApplet#random(float,float)
 * @see PApplet#randomSeed(long)
 */
public void noiseSeed(long seed) {
  if (perlinRandom == null) perlinRandom = new Random();
  perlinRandom.setSeed(seed);
  // force table reset after changing the random number seed [0122]
  perlin = null;
}
