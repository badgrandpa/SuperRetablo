/*                            ----- SuperRetablo AR Poster -----
 
 Alesandra Miro Quesada
 www.bgrandpa.com
 alesandra@bgrandpa.com
 
 
 This is part ONE of two part AR poster project. This sketch displays the main imagery for the poster
 which will then act as an AR Image Target to be recognized. 
 
 My inspiration behing this project was an andean object called a Retablo. It is a box adored with 
 geometrical patterns and colors that, when oppened, has a story to tell. In my case I am telling
 the story of the superfomula and its unique organic shapes which I am slightly obsessed with.
 
 In order to achieve a geometrical pattern like the ones in the ones in the Retablos I created a class 
 whch contained the superformula maths along with all its parameters (more on than on part TWO).
 
 After creating the class I created a series of Array Lists that would allow me to design a convincing
 folckloric looking pattern which will be the face of the Retablo. Using for loops and pushing/popping 
 here and there I created superformula poster. 
 
 This consisted of the first step in telling the mathematical story of this formula. Next up I animate
 the supershapes and implement an OBJ exporter to bring OBJ sequences into unity and make them come to 
 life in AR.
 
 WARNING: creating supershapes is quite computer demanding, apologies if I make your computer cry!
 
 */


import peasy.*;
PeasyCam cam;
//array lists of supers
ArrayList<Supershape> supers01;
ArrayList<Supershape> supers02;
ArrayList<Supershape> supers03;
ArrayList<Supershape> supers04;
ArrayList<Supershape> supers05;
ArrayList<Supershape> supers06;

void setup() {
  //Different resolutions:
  //size(2380, 3360, P3D);
  //size(1754, 1754, P3D);
  //size(1240, 1754, P3D);
  size(1190, 1684, P3D);
  frameRate(30);
  // ------------------------------------------PeasyCam-----------------------------------------------------------------------------------------

  cam = new PeasyCam(this, 600);

  // ------------------------------------------Supershapes-----------------------------------------------------------------------------------------

  //create an array of supershapes
  supers01 = new ArrayList<Supershape>(); 
  supers02 = new ArrayList<Supershape>(); 
  supers03 = new ArrayList<Supershape>(); 
  supers04 = new ArrayList<Supershape>(); 
  supers05 = new ArrayList<Supershape>();
  supers06 = new ArrayList<Supershape>();

  /* Remmebering all the superformula parameters is hard. H having this handy is helpful:
   Supershape(a,  b,  m1,  n1,  n2,  n3,  fill)
   1,  // a transforms on x asis
   1,  // b transforms on y axis
   r2_mAnim, // m number of rotations in shape (′6 spikes′)
   r2_n1Anim, //n1Anim, //n1 smoother or pointy 
   r2_n2Anim, // n2 determine the cool shape of the pointy bits on x axis 
   r2_n3Anim  // n3  determine the cool shape of the pointy bits on y axis
   */

  //red super
  for (int i = 0; i < 1; i++) {
    //supers01.add(new Supershape(a, b, r1_m, r1_n1, r1_n2, r1_n3, r2_m, r2_n2, r2_n3, r2_n3, color(255, 230, 0)));
    supers01.add(new Supershape(1, 1, 20, 3, 1.2, 1, 20, 3, 1.2, 1, color(255, 0, 68)));
  }

  //neon green super
  for (int i = 0; i < 22; i++) {
    supers02.add(new Supershape(1, 1, 9.1, 2.04, 4, 1.7, 9.1, 2.04, 4, 1.7, color(0, 255, 43)));
  }

  //light blue super
  for (int i = 0; i < 10; i++) { //every 30 degrees we have 1 shape aprox
    supers03.add(new Supershape(1, 1, 5.7, 0.5, 1, 2.5, 5.7, 0.5, 1, 2.5, color(35, 116, 198)));
  }

  // pink super
  for (int i = 0; i < 20; i++) {
    supers04.add(new Supershape(1, 1, 20, 3, 1.2, 1, 20, 3, 1.2, 1, color(196, 36, 121)));
  }

  //purple super
  for (int i = 0; i < 20; i++) { //every 30 degrees we have 1 shape aprox
    supers05.add(new Supershape(1, 1, 6.3, -9.20, 16.4, 20, 5.5, -13.60, 22.50, 18.70, color(127, 0, 255)));
  }

  //orange super
  for (int i = 0; i < 1; i++) { //every 30 degrees we have 1 shape aprox
    supers06.add(new Supershape(1, 1, 20, 0.6, 100.2, 1, 20, 6.748, 1.2, 10, color(255, 162, 0)));
  }
}

void draw() {

  background(255);
  noStroke();

  // ------------------------------------------Lights-----------------------------------------------------------------------------------------
 //light arangement that follos X and Yposition
  ambientLight(100, 100, 100);
  directionalLight(255, 255, 230, -100, -100, 0);
  directionalLight(219, 251, 255, mouseX, mouseY, 100);
  pointLight(255, 255, 255, mouseX, mouseY, 300);


  // ------------------------------------------Supershapes-----------------------------------------------------------------------------------------

  //Designing the poster 


  //bright yellow
  for (Supershape s : supers01) {
    pushMatrix();
    //rotate(0.4);
    s.superformula_3D(0, 0, 400, 30);
    popMatrix();
  }

  //Neon green
  //calling my sueprhapes and creating a for loop that generates round and spiral patterns
  // these are perfect to get the super geometrical cool. Besides super fun to play around with 
  // and really see your supershapes come to life. 
  for (Supershape s : supers02) {
    float step = 2*PI/supers02.size();
    float r = 60;
    for (float theta = 0; theta < 2*PI; theta += step, r-=3) {
      //pushMatrix();
      float x = r * cos(theta);
      float y = r * sin(theta);
      s.superformula_3D(x, y, 450, r/23);
      pushMatrix();
      rotate(2);
      s.superformula_3D(x, y, 450, r/23);
      popMatrix();
      pushMatrix();
      rotate(4);
      s.superformula_3D(x, y, 450, r/23);
      popMatrix();
    }
  }
  //Light Blue 
  for (Supershape s : supers03) {
    float step = 2*PI/supers03.size();
    float r = 220;

    //crating a circle of supershapes by taking the polar coordinates
    // and translating them into x and y values
    for (float theta = 0; theta < 2*PI; theta += step, r-=20) {
      float x = r * cos(theta);
      float y = r * sin(theta);
      s.superformula_3D(x, y, 100, r/5);
      pushMatrix();
      rotate(10);
      s.superformula_3D(x, y, 100, r/5);
      popMatrix();
      pushMatrix();
      rotate(20);
      s.superformula_3D(x, y, 100, r/5);
      popMatrix();
    }
  }

  //orange/yellow
  for (Supershape s : supers06) {
    s.superformula_3D(0, 0, 0, 100);
  }


  // Pink
  for (Supershape s : supers04) {
    float step = 2*PI/supers04.size();
    float r = 80;


    for (float theta = 0; theta < 2*PI; theta += step) {
      //pushMatrix();
      float x = r * cos(theta);
      float y = r * sin(theta);
      // rotate(2);
      s.superformula_3D(x, y, 250, r/6);
      // popMatrix();
    }
  }


  //purple
  for (Supershape s : supers05) {
    float step = 2*PI/supers05.size();
    float r = 100;

    for (float theta = 0; theta < 2*PI; theta += step) {
      //pushMatrix();
      float x = r * cos(theta);
      float y = r * sin(theta);
      // rotate(2);
      s.superformula_3D(x, y, 400, r/5);
      // popMatrix();
    }
  }

  // ------------------------------------------Export Png-----------------------------------------------------------------------------------------
  //Uncomment to save
  // saveFrame("Supershape_####.png"); // saves frame
}
