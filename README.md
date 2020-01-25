# SuperRetablo
Augmented Reality poster using Supershapes in Processing

Alesandra Miro Quesada
amiro001
13/01/2020


           —————————————————— SuperRetablo AR Poster——————————————————— 

For the Final term assignment I really wanted to set myself a challenge and break the boundaries of what was expected out of Processing. I took advantage of my background in AR and  Unity to further my practice and find a way to merge Processing with interactivity and 3D graphics. 

I decided to appropriate a Peruvian artefact called retablo. These wooden boxes were used my missionaries in the 15th century to bring the word of God to the newly ′discovered′ people of Latin America. Inside there were miniature sculptures depicting biblical scenes adored with colours and metals. 

Since then, retablos have been widely used throughout all of Latin America to tell all different kinds of stories. I thought it would be an appropriate artefact to display as a poster and then further develop as a virtual piece.  

This is where the Superformula comes in. Not only have I been wanting to use super shapes for quite some time now, I also discovered a obj exporter library from processing that exported obj sequence. This meant that I could use processing generated shapes in Unity and therefore AR. SO EXCITING!

I therefore decided to create a two part project that would encompass a 2D poster complemented by 3D graphics, all derived from the Superformula. 

In part one I create a class Superformula_3D() that followed the Superformula (http://paulbourke.net/geometry/supershape/) structure and create all the necessary parameters to generate a series of points in 3Dspace. To do this I created a Vector that would store my array of points so we could later connect them using  drawShape(); Once we managed this it was time to design.

Because of the geometrical and organic nature of Superformula they were a prefect candidate to recreate a modern spin of a retablo. I cread a series of if statements and by using  sin and cos translated my ArrayList of Superformula to create round and spirals  patterns. Once I was happy it was time to 3D.

In part two, I imported the obj library (https://n-e-r-v-o-u-s.com/blog/?p=3378) to export 3D meshes. Moreover I mapped the m,n1,n2 and n3 values for the longitude and latitude of the Superformula. Again by the use of sin and cos I was able to oscillate the Superformula between different values. Each time I saw a Supershape that Liked, I exported it as an obj sequence to use in Unity. They are going to be shown inside the retablo happily oscillating.

Finally once I had created both the poster and the obj sequence using processing it was time to migrate into game engine Unity. The poster acted as the Image target that the phone camera would be looking for. When found the the image target will trigger the SuperRetablo. I created the box design in Cinema4D and animated the doors opening and closing. On the inside I created rows and columns, each created a cubby hole in which the animated super shape is going to be displayed. 

Finally I generated UV maps and textures for the retablo. The result? See for yourself! (:

