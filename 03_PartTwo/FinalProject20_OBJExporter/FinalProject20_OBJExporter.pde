/*                         ----- SuperRetablo AR Poster -----
 
 Alesandra Miro Quesada
 www.bgrandpa.com
 alesandra@bgrandpa.com
 

 This is part TWO of the SuperRetablo AR poster project. 
 
 In order to creat a successfull AR piece I had to have dynamic objects that would animate and 
 captivate the audience atention when experiencign AR. So far I had created supershapes but now
 I needed to animate and export them so I could work in Unity. 
 
 The code you see bellow is very similar to part ONE except for the fact that here we are mapping
 two superformula values onto the m,n1,n2 and n3 values. This will create an oscilating effect 
 between two parameters, thus display how awesome this formula is!!!
 
 Once I had my supershapes successfully oscilated I used Andrew Marshs website to preview and 
 test different numerical combinations instead of randomly generating number values. This was super 
 helpfull because it allowed me to combine different shapes that complemented eachother. 
 
 I then used nervoussystem obj exporter library to export obj sequences of the animations. 
 
 Bibliography:
 Converting poloar to cartesian coorindates
 https://en.wikipedia.org/wiki/Spherical_coordinate_system
 Amazing explanation and documentation by Paul Bourke
 http://paulbourke.net/geometry/supershape/
 Generate online Supershapes
 https://drajmarsh.bitbucket.io/supershapes.html
 As allways Daniel Shifman: 3D supersphere tutorial. This gave me the knowledge to use Pvectors
 https://www.youtube.com/watch?v=RkuBWEkBrZA
 Exporting OBJ sequences
 https://n-e-r-v-o-u-s.com/tools/obj/
 
 */

// -------------------------------------------Importerd Libraries-----------------------------------------------------------------------------------------


import peasy.*;
import nervoussystem.obj.*;

PeasyCam cam;


// -------------------------------------------Supershape Parameters-----------------------------------------------------------------------------------------
//creat a 2D array to store all the x,y,z values for every theta and phi (latitue and longitue) 
PVector[][] supershape;
int total = 75; // the resolution for the sphere that will go in the array
float m = 0; //superformula′s most magic variable that esencially defines the cool shapes

//r1 belongs to the first set of values that the supershape that control the latitude parameters (phi) 
float r1_n1Anim = 0; // these are going to animate the values between supershapes
float r1_n2Anim = 0;
float r1_n3Anim = 0;
float r1_mAnim = 0;

//r1 belongs to the first set of values that the supershape that control the logitud parameters (theta)
float r2_n1Anim = 0; 
float r2_n2Anim = 0;
float r2_n3Anim = 0;
float r2_mAnim = 0;

float n1Range = 0; //range of values the sueperformula parameters can oscilate between
float n2Range = 0;
float n3Range = 0;
float mRange = 0;

float spin = 0.0; //used for rotation of supershape
boolean record = false; //start recording/exporting obj sequences


// -------------------------------------------Color Parameter-----------------------------------------------------------------------------------------

int dim;


void setup() {
  //A2 size in px: 1587, 2230
  
  size(595, 842, P3D);
  colorMode(HSB);
  frameRate(30);
  ellipseMode(RADIUS);
  // background(0);


  // ------------------------------------------PeasyCam-----------------------------------------------------------------------------------------

  cam = new PeasyCam(this, 600);
  cam.setRotations(0, QUARTER_PI, 0); 
  // cam.setActive(false);


  // ------------------------------------------supershape PVector-----------------------------------------------------------------------------------------

  supershape = new PVector[total+1][total+1]; //if you add +1 to the total of i in the vector you will avoid the ′ArrayIndexOutOfBounds′ error
}

void draw() {

  background(0);
  noStroke();
  pointLight(200, 102, 255, 200, -200, 200); // r,g,b,x,y,z
  pointLight(200, 20, 255, 0, 200, 200); // r,g,b,x,y,z
  lightSpecular(204, 204, 204);
  specular(255, 255, 255);
  rotateX(spin);
  rotateY(spin);
  rotate(spin);
  spin += 0.01;

  // -------------------------------------------OBJ Exporter-----------------------------------------------------------------------------------------

  //beginRecord("nervoussystem.obj.OBJExport", "supershape01_####.obj");  //Exports OBJ Sequence which I later plug into C4D and Unity to creat AR
  superformula_3D();

  // ---------------------------------------scree----Animation of Supershape-----------------------------------------------------------------------------------------
  // Animations for the latitude oscilation of Supershape
  // this is going to create smooth oscilating values of phi and theta values, making them animate
 println(frameCount);
 //for (int i = 0; i < 10; i++) {
  r1_mAnim = map(cos(mRange), -1, 1, 10, 5.7); // after the sin wave first two values are the wave oscilation
  mRange +=0.01;
  println("r1_mAnim: ", r1_mAnim);
// }
  r1_n1Anim = map(sin(n1Range), 1, -1, 0.479, 8.3); 
  n1Range += 0.01;
  println("r1_n1Anim: ", r1_n1Anim);

  r1_n2Anim = map(cos(n2Range), -1, 1, 30.25, 1.2); 
  n2Range += 0.01;
  println("r1_n2Anim: ", r1_n2Anim);

  r1_n3Anim = map(sin(n3Range), 1, -1, 0.35, 2.5); 
  n3Range += 0.01;
  println("r1_n3Anim: ", r1_n3Anim);

  //---------------------------------------------------------------------------------------------------------------------------------------------  // Animations for the longitude oscilation of Supershape
  r2_mAnim = map(cos(mRange), -1, 1, 15, 12.4); // after the sin wave first two values are the wave oscilation
  mRange +=0.01;

  r2_n1Anim = map(cos(n1Range), 1, -1, 15.44, 3.33); 
  n1Range += 0.01;

  r2_n2Anim = map(sin(n2Range), -1, 1, -0.4537, 0.2);  
  n2Range += 0.01;

  r2_n3Anim = map(sin(n3Range), 1, -1, 87.07, 1);
  n3Range += 0.01;
}


// -------------------------------------------Supershape Function-----------------------------------------------------------------------------------------


// translating the superformula from maths to a processing function. 
// I followed Paul Bourke′s documentation on his website (check bibliography)
float supershape(float theta, float a, float b, float m, float n1, float n2, float n3) {
  return pow(pow(abs(cos(m*theta/4.0)/a), n2) + 
    pow(abs(sin(m*theta/4.0)/b), n3), -1.0/n1); //BOOOM superformula in procesing
}


// -------------------------------------------3D Supershape-----------------------------------------------------------------------------------------

void superformula_3D() {

  float theta; // θ lon
  float phi; // φ  lat
  float x;
  float y;
  float z;
  float r = 100;

  //doing all of the superformula calculations and storing them in a 2D array
  for (int i = 0; i < total+1; i++) {
    phi = map (i, 0, total, -HALF_PI, HALF_PI); //longitute -> remember these are polar coordinates
    float r2 = supershape(phi, 1, 1, r1_mAnim, r1_n1Anim, r1_n2Anim, r1_n3Anim);
    for ( int j = 0; j < total+1; j++) {
      theta = map(j, 0, total, -PI, PI); //latitute 
      float r1 = supershape(theta, 1, 1, r1_mAnim, r1_n1Anim, r1_n2Anim, r1_n3Anim);
      //we must convert longitute and latitue to x,y,z coordinates. We find the formula from Paul Bourke in Bibliography (:
      x = r * r1 * cos(theta) * r2 *cos(phi);
      y = r * r1 * sin(theta) * r2* cos(phi);
      z = r * r2 * sin(phi);
      supershape[i][j] = new PVector(x, y, z);
    }
  }
  // use the 2D array to setup the verteces and triangles to make the 3D shape
  fill(255);
  for (int i = 0; i < total; i++) {
    //float hu = map(i, 0, total, 0, 255*6);
    //fill(hu % 255, 255, 255);

    beginShape(TRIANGLE_STRIP); //filling the vertex with triangels to create geometry
    for (int j = 0; j < total+1; j++) {

      pushMatrix();
      PVector v1 = supershape [i][j]; //calling my vector
      vertex(v1.x, v1.y, v1.z);
      PVector v2 = supershape[i+1][j];
      vertex(v2.x, v2.y, v2.z);
      popMatrix();
    }
    endShape();
  }
}
