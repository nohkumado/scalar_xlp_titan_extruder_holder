use <fillet.scad>;
use<scalar_titan_adapter.scad>;
use<../chain_link/chainlink.scad>

gbreite = 59; //gesamtbreite
sbreitu = 40; //smale Breite unten
sbreito = 47; //smale Breite open
ebreite = 25;  //Einschnitt Breite
uebreit = 11;  //Untereinschnitt Breite

ghoehe = 29;  //Gesamt Hoehe
ehoehe = 5.5;  //einschnitt Hoehe
uehoeh = 3.5;  //Untereinschnitt Hoehe
ueinr = 10;  //Untere Einrückung 
oeinr = 6;  //Obere Einrückung 

dicke = 6;


scalar_titan_adapter();
//Kabelbrücke
translate([-ebreite/2-5,ghoehe/2-5,0]) kabelbruecke();
translate([ebreite/2+3,-ghoehe/2-5,0])kettenbefestigung(b=8);

module kettenbefestigung(b=10)
{
    translate([0,0,4.5]) cube([16.3,b+10,3], center = true);
  translate([-16.3/2-4.5,5,0]) cube([5,4,3]);
    translate([16.3/2+1.5,7.5,3]) rotate([0,0,45])cube([16,5,6], center=true);
    color("magenta")
difference()
    {translate([-16.3/2+8,(b-6)/2,3]) cube([16.6,b+6,6],center=true);
  color("magenta")  translate([-6.0,-5,-2]) rotate([-20,0,0])rotate([0,90,0])cylinder(d=10, h=12, $fn=3);
    }
  rotate([0,90,0]) translate([1.5,-b/2-1.5,6.3]) cylinder(d=10, h=2, $fn=3);
  rotate([0,90,0]) translate([1.5,-b/2-1.5,-8.4]) cylinder(d=10, h=2, $fn=3);
  translate([0,-b,-6.5])
    rotate([0,0,90])
    difference()
    {
      chainlink(length = 30,width= 16.6, height=25, wall= 2, angle = 75,tol=.3);
      translate([13,0,0])
        cube([20,30,30], center=true);
    }
}//module kettenbefestigung()
module kabelbruecke()
{

  translate([0,0.5,-3])
    cube([5,4.5,5]);
  translate([0,0.5,-5])
    cube([5,45,2]);
  translate([0,0.5,-7]) kabelhaken();
  translate([5,22.5,-7]) rotate([0,0,180])kabelhaken();
  translate([0,42.5,-7]) kabelhaken();
}//module kabelbrücke()

module kabelhaken()
{
  cube([2,3,2]);
  translate([0,0,-2]) cube([4,3,2]);
}//module kabelhaken()


module ausschnitt()
{
  difference()
  {
    cube([16,1.16*dicke,2*dicke/3]);
    union()
      color("red") 
      {
        translate([0,0,2])fillet(3,dicke); 
        translate([16,0,2]) rotate([0,0,90])fillet(3,dicke); 
        translate([16,1.16*dicke,2]) rotate([0,0,180])fillet(3,dicke); 
        translate([0,1.16*dicke,2]) rotate([0,0,-90])fillet(3,dicke); 
      }
  }
}
