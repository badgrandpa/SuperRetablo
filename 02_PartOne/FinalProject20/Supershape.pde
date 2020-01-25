
/*                            ----- SuperRetablo AR Poster -----
 
 Alesandra Miro Quesada
 www.bgrandpa.com
 alesandra@bgrandpa.com
 
 
 Welcome to the class!
 Here I develop the mathematical formula of the supershape. This part of the project was BY FAR 
 the most hard/intimidating/new and overall difficult thing to achieve. In this section I 
 put into practice constructors, PVectors and functions to construct and dinamically use a 
 supershape.
 
 Please refere to video for in depth explanation of the process of converting the superformula
 maths into processing. Please also refere to the bibliography for all the code/videos/documentation
 I have been looking at over the past weeks to achieve this.
 
 
 
 
 
 
 */




class Supershape {

  //creat a 2D array to store all the x,y,z values for every theta and phi (latitue and longitue) 
  PVector[][] supershape;
  int total; // the resolution for the sphere that will go in the array
  

  //r1 belongs to the first set of values that the supershape that control the latitude parameters (phi) 
  float r1_n1Anim; // these are going to animate the values between supershapes
  float r1_n2Anim;
  float r1_n3Anim;
  float r1_mAnim;

  //r1 belongs to the first set of values that the supershape that control the logitud parameters (theta)
  float r2_n1Anim; 
  float r2_n2Anim;
  float r2_n3Anim;
  float r2_mAnim;

  float n1Range; //range of values the sueperformula parameters can oscilate between
  float n2Range;
  float n3Range;
  float mRange;

  color c;



  // -------------------------------------------Supershape Function-----------------------------------------------------------------------------------------
  // translating the superformula from maths to a processing function. 
  // I followed Paul Bourke′s documentation on his website (check bibliography) 
  // however managed to create it on my own.
  float supershape(float theta, float a, float b, float m, float n1, float n2, float n3) {
    return pow(pow(abs(cos(m*theta/4.0)/a), n2) + 
      pow(abs(sin(m*theta/4.0)/b), n3), -1.0/n1); //BOOOM superformula in procesing
  }
  
   /* Remmebering all the superformula parameters is hard. Having this handy is helpful:
   Supershape(a,  b,  m1,  n1,  n2,  n3,  fill)
   1,  // a transforms on x asis
   1,  // b transforms on y axis
   r2_mAnim, // m number of rotations in shape (′6 spikes′)
   r2_n1Anim, //n1Anim, //n1 smoother or pointy 
   r2_n2Anim, // n2 determine the cool shape of the pointy bits on x axis 
   r2_n3Anim  // n3  determine the cool shape of the pointy bits on y axis
   */

  Supershape( float a, float b, 
  
                float r1_m, float r1_n1, float r1_n2, float r1_n3, 
  
                float r2_m, float r2_n1, float r2_n2, float r2_n3,

                color fill) {

    total = 200; // acts as resolution or total number of points 
    supershape = new PVector[total+1][total+1]; //if you add +1 to the total of i in the vector you will avoid the ′ArrayIndexOutOfBounds′ error
    // Animations for the latitude oscilation of Supershape
    r1_mAnim = r1_m;  // pluging in supershape parameters from function
    r1_n1Anim = r1_n1; 
    r1_n2Anim = r1_n2;
    r1_n3Anim = r1_n3;
   
    r2_mAnim = r2_m;  // pluging in supershape parameters from function
    r2_n1Anim = r2_n1; 
    r2_n2Anim = r2_n2;
    r2_n3Anim = r2_n3;
    c = fill; //color please!!

  }

  void superformula_3D(float transX, float transY, float transZ, float r) {
    
   // float theta,float phi,float x,float y,float z,float r

    float theta; // θ lon
    float phi; // φ  lat
    float x;
    float y;
    float z;
    
    //float r = 100;
   

    //doing all of the superformula calculations and storing them in a 2D array
    for (int i = 0; i < total+1; i++) {
      phi = map (i, 0, total, -HALF_PI, HALF_PI); //longitute -> remember these are polar coordinates
      float r2 = supershape(phi, 1, 1, r2_mAnim, r2_n1Anim, r2_n2Anim, r2_n3Anim);
      for ( int j = 0; j < total+1; j++) {
        theta = map(j, 0, total, -PI, PI); //latitute 
        float r1 = supershape(theta, 1, 1, r1_mAnim, r1_n1Anim, r1_n2Anim, r1_n3Anim);
        //we must convert longitute and latitue to x,y,z coordinates. We find the formula from Paul Bourke in Bibliography (:.
        x = r * r1 * cos(theta) * r2 *cos(phi);
        y = r * r1 * sin(theta) * r2* cos(phi);
        z = r * r2 * sin(phi);
        supershape[i][j] = new PVector(x + transX, y + transY , z + transZ); //adding translation values to the paramenters
      }
    }
    // use the 2D array to setup the verteces and triangles to make the 3D shape
    fill(255);
    for (int i = 0; i < total; i++) {
      fill(c);
      beginShape(TRIANGLE_STRIP); //filling the vertex with triangels to create geometry
      for (int j = 0; j < total+1; j++) {
        pushMatrix();
        PVector v1 = supershape[i][j]; //calling my vector
        vertex(v1.x, v1.y, v1.z);
        PVector v2 = supershape[i+1][j];
        vertex(v2.x, v2.y, v2.z);
        popMatrix();
      }
      endShape();
    }
  }
}
