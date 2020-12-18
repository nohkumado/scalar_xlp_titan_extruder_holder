use <../x-axe/Schlittenplatte.scad>;
use <../x-axe/E3DV6.scad>;
use <../masken/cantileverSnapFit.scad>;
DIN965  = 2;

// Schlittenplatte(dicke = 5,baender = false, centered = [1,0,0]);
// difference()
// {
//   union()
//   {
//     translate([0,52.4,5]) TitanHolder();
//     translate([0,52.4,5]) HotendHolder(print = "bottom");
//   }
//   difference()
//   {
//     bohrungsmaske( 31.5, baender = false,centered = [1,0,0],screwtype = DIN965); 
//       translate([0,52.4,40.0])
//       cube([10,30,80], center = true);
//   }
// }

//translate([-35,7,0]) Sonde();
 translate([0,-53,-5])
 difference()
 {
   union()
   {
     translate([0,52.4,5]) HotendHolder(print = "top");
   }
  difference()
  {
    bohrungsmaske( 18.6, baender = false,centered = [1,0,0],screwtype = DIN965); 
      translate([0,52.4,40.0])
      cube([10,30,80], center = true);
  }
 }
//translate([0,0,0]) HotendHolder(print = "top");

module Sonde(part = "both")
{
  cs = [22.1, 8,28.1];
  translate([0,cs[1]/2,cs[2]/2])
  {
    difference()
    {
      cube(cs,center = true);
      union()
      {
        translate([cs[0]/2,0,cs[2]/2]) rotate([0,180,0]) rotate([90,0,0]) fillet(r = 5, h = cs[1]+2);
    translate([0,0,3])
    {
      translate([0,50,0])
        rotate([90,0,0])
        cylinder(d=12.5, h =65, $fn = 32);
     ///screw
     //  translate([0,5,0])
     //  rotate([90,0,0])
     //  cylinder(d=22, h =20, $fn = 32);
    }
     color("red")//xsensor stopper
  translate([-cs[0]/2+4.5,0,-5 -cs[2]/2])
      boppel(cs[1], 0.1);
      }
    }
  }
     //xsensor stopper
  translate([-cs[0]+4.5,5,cs[1]/2])
      rotate([90,0,0])
      boppel(cs[1]);
}

module boppel(d, luft = 0)
{
  
cube([9,d,10],center = true);
translate([0,(d-2)/2,5-0.01])
rotate([90,0,0])
doubleCantilever(baseThick = 2, headThick = 3, cantL = 4, headL = 2, ratio = 0.75, mask = luft,d = d-2);
}


module collet()
{

  //difference()
  {
    befblock2 =[42,15,25];
    translate([0,befblock2[2]/2+33.5,befblock2[2]/2+5]) 
      difference()
      {
        cube(befblock2,center = true);
        union()
        {
          cube([befblock2[0]+5,befblock2[1]+5, 0.5],center = true);
          translate([0,befblock2[1]/2-0.5,befblock2[2]/2+2.5]) 
            cube([befblock2[0]+5, 0.5,befblock2[2]+5],center = true);
        }
      }
    translate([0,-8,17]) rotate([-90,0,0]) E3DV6(offset = "bot");
  }
}//module collet()

function hzoff(pos) = (pos == "top")? 0: 1;
module HotendHolder(print = "both", luft = .2)
{
  befblock2 =[43,15,25];
  translate([0,0,hzoff(print) *befblock2[2]/2]) 
    difference()
    {
      union()
      {
        if(print == "both" || print == "bottom")
        {
          translate([0,-befblock2[1]/2,-befblock2[2]/4]) 
            color("blue")
            cube([befblock2[0],befblock2[1], befblock2[2]/2],center = true);
          color("red") 
            translate([-befblock2[0]/2+2.5,-befblock2[1]/1+2.5,-befblock2[2]/2])
            cylinder(d=8, h = befblock2[2]/2, $fn = 32);
          translate([befblock2[0]/2-2.5,-befblock2[1]/1+2.5,-befblock2[2]/2])
            cylinder(d=8, h = befblock2[2]/2, $fn = 32);
        }
        if(print == "both" || print == "top")
        {
          difference()
          {
            union()
            {
              translate([0,-befblock2[1]/2-luft,befblock2[2]/4+luft+3]) 
                //thicker to allow extra fan to be attached
                cube([befblock2[0],befblock2[1]-2*luft, befblock2[2]/2-2*luft+6],center = true);
              translate([-befblock2[0]/2+2.5,-befblock2[1]/1+2.5,luft])
                cylinder(d=8, h = befblock2[2]/2-luft, $fn = 32);
              translate([befblock2[0]/2-2.5,-befblock2[1]/1+2.5,luft])
                cylinder(d=8, h = befblock2[2]/2-luft, $fn = 32);
            }
            //Screw reservations
            union() 
            {
              //lower screwholes
              translate([-befblock2[0]/2+2.5,-befblock2[1]/1+2.5,befblock2[2]/2-luft])
                cylinder(d=9, h = 7, $fn = 32);
              translate([befblock2[0]/2-2.5,-befblock2[1]/1+2.5,befblock2[2]/2-luft])
                cylinder(d=9, h = 7, $fn = 32);
              //fanhoiles
              translate([-11.9,-befblock2[1]/1+5,befblock2[2]/2-luft])
                cylinder(d=3, h = 7, $fn = 32);
              translate([11.9,-befblock2[1]/1+5,befblock2[2]/2-luft])
                cylinder(d=3, h = 7, $fn = 32);
              //upper, partial screw holes
              translate([-befblock2[0]/2+6.0,+1.5,-befblock2[2]/2-luft])
                cylinder(d=9, h = 2*befblock2[2]+2*luft, $fn = 32);
              translate([befblock2[0]/2-7.0,1.5,-befblock2[2]/2-luft])
                cylinder(d=9, h = 2*befblock2[2]+2*luft, $fn = 32);
            }
          }
            color("red") 
            {
            }



        }
      }
      rotate([-90,0,0]) E3DV6(offset = "top");
    }
}
module TitanHolder()
{
  befblock =[37,8,25];
  translate([0,befblock[1],befblock[2]/2])
    union()
    {
      //translate([0,befblock[1]/2,befblock[2]/2]) cube(befblock,center = true);
      difference()
      {
        union()
        {
          translate([0,-befblock[1]/2,0]) cube(befblock,center = true);
          translate([0,1,0]) rotate([-90,0,0]) ColletRing(1);
        }
        union()
        {
        translate([0,1,0])
          rotate([90,0,0]) cylinder(d=ptdiam(mask = true,luft = 0.2), h = 40, $fn = 32);
color("red")
        translate([0,-7.1,0])
          rotate([90,0,0]) cylinder(d=2.5*ptdiam(mask = true,luft = 0.2), h = 1, $fn = 32);
}
      }
      translate([befblock[0]/2,-befblock[1],0])
        fillet(r = 3, h = 25);
      translate([-befblock[0]/2,-befblock[1],0])
        rotate([0,0,90])fillet(r = 3, h = 25);
    }
}
