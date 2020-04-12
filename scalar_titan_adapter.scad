include <fillet.scad>;

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
bohrluft = .2;

scalar_titan_adapter();

module scalar_titan_adapter()
{
  eckpunkte =
    [
    [-gbreite/2,-ghoehe/2+ueinr,0], //0
    [-sbreitu/2,-ghoehe/2,0], //1
    [sbreitu/2,-ghoehe/2,0], //2
    [gbreite/2,-ghoehe/2+ueinr,0], //3
    [gbreite/2,ghoehe/2-oeinr,0], //4
    [sbreito/2,ghoehe/2,0], //5
    [ebreite/2,ghoehe/2,0], //6
    [ebreite/2,ghoehe/2-ehoehe,0], //7
    [uebreit/2,ghoehe/2-ehoehe,0], //8
    [uebreit/2,ghoehe/2-(ehoehe+uehoeh),0], //9
    [-uebreit/2,ghoehe/2-(ehoehe+uehoeh),0], //10
    [-uebreit/2,ghoehe/2-ehoehe,0], //11
    [-ebreite/2,ghoehe/2-ehoehe,0], //12
    [-ebreite/2,ghoehe/2,0], //13
    [-sbreito/2,ghoehe/2,0], //14
    [-gbreite/2,ghoehe/2-oeinr,0], //15
    //hinterseite
    [-gbreite/2,-ghoehe/2+ueinr,dicke], //16
    [-sbreitu/2,-ghoehe/2,dicke], //17
    [sbreitu/2,-ghoehe/2,dicke], //18
    [gbreite/2,-ghoehe/2+ueinr,dicke], //19
    [gbreite/2,ghoehe/2-oeinr,dicke], //20
    [sbreito/2,ghoehe/2,dicke], //21
    [ebreite/2,ghoehe/2,dicke], //22
    [ebreite/2,ghoehe/2-ehoehe,dicke], //23
    [uebreit/2,ghoehe/2-ehoehe,dicke], //24
    [uebreit/2,ghoehe/2-(ehoehe+uehoeh),dicke], //25
    [-uebreit/2,ghoehe/2-(ehoehe+uehoeh),dicke], //26
    [-uebreit/2,ghoehe/2-ehoehe,dicke], //27
    [-ebreite/2,ghoehe/2-ehoehe,dicke], //28
    [-ebreite/2,ghoehe/2,dicke], //29
    [-sbreito/2,ghoehe/2,dicke], //30
    [-gbreite/2,ghoehe/2-oeinr,dicke], //31
    ];

  flaechen =
    [
    [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15],//vordere Flaeche
    [31,30,29,28,27,26,25,24,23,22,21,20,19,18,17,16],
    [16,17,1,0],
    [17,18,2,1],
    [18,19,3,2],
    [19,20,4,3],
    [20,21,5,4],
    [21,22,6,5],
    [22,23,7,6],
    [23,24,8,7],
    [24,25,9,8],
    [25,26,10,9],
    [26,27,11,10],
    [27,28,12,11],
    [28,29,13,12],
    [29,30,14,13],
    [30,31,15,14],
    [31,16,0,15],
    ];
    difference()
    {
      union()
      {
        polyhedron(eckpunkte,flaechen);
        translate(eckpunkte[7]) translate([0,0,3]) rotate([0,0,90]) fillet(3,dicke);
        translate(eckpunkte[12]) translate([0,0,3])  fillet(3,dicke);
        //adding the titant extruder thing....
        //translate([-8,-ghoehe/4-2,-10]) cube([16,ghoehe-(ehoehe+uehoeh),5.5]);
        difference()
        {
          translate([-0.15, -.5,-24])cylinder(d=16, h=24, $fn=128);
          union()
          {
            difference()
            {
              translate([-0.15, -.5,-20.4])cylinder(d=17, h=6, $fn=64);
              translate([-0.15, -.5,-21.4])cylinder(d=12, h=8, $fn=64);
            }
            color("blue")translate([-6,5.5,-5]) cube([12,5,5.1]);
          }
        }
      }
      union()
      {
        translate([0, 0,-1])
        {
          translate([-0.15, -.5,-dicke-19])cylinder(d=4+bohrluft, h=2*dicke+25, $fn=64);//PTE Zentralloch
          //translate([-0.15, -.5,1])cylinder(d=12, h=21, $fn=64);//PTe Mutter
          translate([-ebreite/2+1, ghoehe/2-(ehoehe+uehoeh)+1,0])cylinder(d=3.5, h=dicke+2, $fn=32);//Hintenlinks
          translate([ebreite/2-1, ghoehe/2-(ehoehe+uehoeh)+1,0])cylinder(d=3.5, h=dicke+2, $fn=32);//hinten Rechts
          translate([-ebreite/2+1, -ghoehe/2+(ehoehe+uehoeh)-3,0])cylinder(d=3.5, h=dicke+2, $fn=32);//Vorne Links
          translate([ebreite/2-1, -ghoehe/2+(ehoehe+uehoeh)-3,0])cylinder(d=3.5, h=dicke+2, $fn=32);//vorne Rechts
         translate([-gbreite/2+4.45, -0.5,0])cylinder(d=2.8, h=dicke+2, $fn=32);//Bohrung links 
          translate([gbreite/2-4.55, -0.5,0])cylinder(d=2.8, h=dicke+2, $fn=32);//Bohrung rechts
          translate([gbreite/2+5.3, -1.55,0])cylinder(d=13, h=dicke+2, $fn=32);//Sondenausschnitt
          translate([-ebreite+1, ghoehe/2-(ehoehe+uehoeh)-2.5,0]) ausschnitt();//Schraubenauschnitt vorne links
          translate([ebreite-17, ghoehe/2-(ehoehe+uehoeh)-2.5,0])ausschnitt();
          translate([-ebreite+1, -ghoehe/2+2.5,0]) ausschnitt();
          translate([ebreite-17, -ghoehe/2+2.5,0])ausschnitt();
          translate([-ebreite+1, -ghoehe/2-6,0]) cube([16,2*dicke,2*dicke/3]);//Oeffnungen der Schraubenaussschnitte
          translate([ebreite-17, -ghoehe/2-6,0]) cube([16,2*dicke,2*dicke/3]);
          translate(eckpunkte[6]) translate([0,0,4]) rotate([0,0,-90]) fillet(1,dicke+2);
          translate(eckpunkte[8]) translate([0,0,4]) rotate([0,0,-90]) fillet(2,dicke+2);
          translate(eckpunkte[11]) translate([0,0,4]) rotate([0,0,180]) fillet(2,dicke+2);
          translate(eckpunkte[13]) translate([0,0,4]) rotate([0,0,180]) fillet(1,dicke+2);
          translate([-ebreite+17, -ghoehe/2,2.25]) rotate([0,0,0]) fillet(3,dicke/2+.5);
          translate([ebreite-17, -ghoehe/2,2.25]) rotate([0,0,90]) fillet(3,dicke/2+.5);
        }
      }
    }
}

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
