// StegosaurusNozzleHolder.scad - a 3D printable model of a 3D printer nozzle holder
// Copyright (C) 2018 Jaromir Hradilek
// 2019 cn

include <ISOThreadUM2.scad>

// Thread library licensed Creative Commons Public Domain Dedication

// This program is free software:  you can redistribute it and/or modify it
// under  the terms of the  GNU General Public License  as published by the
// Free Software Foundation, version 3 of the License.
//
// This program is  distributed  in the hope  that it will  be useful,  but
// WITHOUT ANY WARRANTY;  without  even the implied  warranty of MERCHANTA-
// BILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the  GNU General Public
// License for more details.
//
// You should have received a copy of the  GNU General Public License along
// with this program. If not, see <http://www.gnu.org/licenses/>.

nozzle_thread = 6;
// Change these to customize the model for your guitar picks:
pick_shape = "nozz";          // The guitar pick shape, "jazz" or "tortex"
pick_thickness = 1.38;        // The thickness of your pick
pick_tolerance = 0.12;        // The additional width of the pick slots

// A generic guitar pick in the classic Tortex shape:
module pick_tortex(thickness=1.0) {
    // Define the constant for proper scaling:
    profile_scale = 25.4/90;

    // Define the vectors for the guitar pick shape:
    points = [
      [-0.000012,-54.921270],[-3.719855,-54.840297],
      [-7.423487,-54.598563],[-11.106460,-54.197846],
      [-14.764324,-53.639922],[-18.392633,-52.926570],
      [-21.986937,-52.059565],[-25.542788,-51.040686],
      [-29.055738,-49.871710],[-31.513187,-48.698416],
      [-33.776531,-47.303686],[-35.847474,-45.713569],
      [-37.727717,-43.954115],[-39.418964,-42.051374],
      [-40.922917,-40.031394],[-42.241278,-37.920225],
      [-43.375749,-35.743916],[-44.328034,-33.528518],
      [-45.099834,-31.300079],[-45.692852,-29.084650],
      [-46.108791,-26.908279],[-46.349352,-24.797016],
      [-46.416239,-22.776910],[-46.311154,-20.874012],
      [-46.035799,-19.114370],[-43.430439,-9.781793],
      [-40.302877,-0.651673],[-36.664439,8.252728],
      [-32.526451,16.908153],[-27.900242,25.291339],
      [-22.797136,33.379027],[-17.228462,41.147958],
      [-11.205545,48.574870],[-8.811574,50.799143],
      [-6.145994,52.830208],[-4.711352,53.664580],
      [-3.208807,54.320203],[-1.638361,54.753594],
      [-0.000012,54.921270],[1.638326,54.753938],
      [3.208768,54.320709],[4.711312,53.665107],
      [6.145956,52.830657],[8.811544,50.799312],
      [11.205521,48.574870],[17.228437,41.147958],
      [22.797112,33.379027],[27.900218,25.291339],
      [32.526430,16.908153],[36.664422,8.252728],
      [40.302866,-0.651673],[43.430437,-9.781793],
      [46.035809,-19.114370],[46.311158,-20.874012],
      [46.416239,-22.776910],[46.349349,-24.797016],
      [46.108786,-26.908279],[45.692846,-29.084650],
      [45.099827,-31.300079],[44.328027,-33.528518],
      [43.375742,-35.743916],[42.241270,-37.920225],
      [40.922909,-40.031394],[39.418956,-42.051374],
      [37.727707,-43.954115],[35.847462,-45.713569],
      [33.776516,-47.303686],[31.513167,-48.698416],
      [29.055713,-49.871710],[25.542762,-51.040236],
      [21.986907,-52.058021],[18.392599,-52.923675],
      [14.764286,-53.635805],[11.106419,-54.193021],
      [7.423448,-54.593931],[3.719820,-54.837145],
      [-0.000012,-54.921270],[-0.000012,-54.921270]];

    // Scale the guitar pick to the proper size:
    scale([profile_scale, -profile_scale, 1]) {
        // Create the guitar pick shape from supplied vectors and
        // extrude it to proper thickness:
        union() {
            linear_extrude(height=thickness)
            polygon(points);
        }
    }
}


// A low poly model of a Stegosaurus without its plates:
module body(scale_factor=1) {
    // Place the imported model in the middle:
    translate([0, 0, 0])

    // Scale the imported model:
    scale([scale_factor, scale_factor, scale_factor])

    // Import the STL model:
    import("Stegosaurus.stl", convexity=5);
}

// Tortex shaped picks placed along the left side of the body:
module plates_tortex(thickness=1.0) {
    translate([-11, 0, 21]) rotate([255, 0, 90]) pick_tortex(thickness);
    translate([-9, -30, 14]) rotate([255, -30, 100]) pick_tortex(thickness);
    translate([-9, 30, 14]) rotate([255, 30, 80]) pick_tortex(thickness);
}

// Jazz III shaped picks placed along the left side of the body:
module plates_jazz(thickness=1.38) {
    translate([-9, 0, 16]) rotate([255, 0, 90]) pick_jazz(thickness);
    translate([-7, -25, 9]) rotate([255, -30, 100]) pick_jazz(thickness);
    translate([-7, 25, 9]) rotate([255, 30, 80]) pick_jazz(thickness);
}

// A guitar pick holder with the Tortex shaped slots:
module stegosaurus_tortex(thickness=1.0) {
    difference() {
        color("SeaGreen") body(16);
        color("CornflowerBlue") plates_tortex(thickness);
        color("CornflowerBlue") mirror([1,0,0]) plates_tortex(thickness);
    }
}

module nozzle(thread=6, colour) {
    // if thread == 0 we’re creating space for a >0 call of module in same coordinates
    
    // commented wiggle room for insertions
    d1=10;//+0.2;
    d2=9;
    d3=8;
    h=0.75;
    z=6.0;
    z2=8;
    // wiggle room
    if(thread>0) {
        d1 = d1 + 0.3;
        d3 = d3 + 0.3;
    }
    union() {
            translate([0,0,z+5.0]) color(colour)
            difference() {
            union() {
                // commented cylinders substituted for
                // individual threaded sockets ease of
                // insertion
                
                cylinder(d1=d3,d2=d1,3);
                translate([0,0,3]) cylinder(d=d1,z2-3);
//                cylinder(d=10,z2);
                translate([0,0,-1]) cylinder(d=d3,1);
//                translate([0,0,-1]) cylinder(d=10,1);
                
                // conical chamfer piece
                translate([0,0,z2]) cylinder(d1=d1,d2=d2,h);
            }
            // “drill” hole for thread
            if(thread>0) {
            translate([0,0,-0.1]) cylinder(d=thread,11.2);
            }
        }
            if(thread>0) {
                difference() {
                    translate([0,0,z+3+4.3]) thread_in(thread,z+1);
                    //slice top of helix
                    translate([0,0,5+z+z2+h])  cylinder(d=d2,1);
                }
            }
    }
}

module nozzles(thread, colour="LightBlue") {
    difference() {
    union() {
    translate([-4.9, -2.50, 1.6]) rotate([35, -15.0, 90])
        nozzle(thread, colour);
    translate([-4.9, 1.50, 1.6]) rotate([35, 15.0, 90])
        nozzle(thread, colour);
    translate([-7, -11.5, 0.9]) rotate([35, -30, 100]) nozzle(thread, colour);
    translate([-7, 10.5, 0.9]) rotate([35, 30, 80]) nozzle(thread, colour);
        // -4.9 ?
    translate([-7, -23.5, -3.9]) rotate([35, -30, 100]) nozzle(thread, colour);
    translate([-7, 21.5, -5.49]) rotate([35, 30, 80]) nozzle(thread, colour);
    }
    // slice away portion that overlaps and interferes
        translate([-9.99,-40,-1.0])  cube([10,80,20]);
    }
}

module stegosaurus_nozz(thread=6){
    union() {
        // Comment out to produce the "ridges"
      /**
        difference() {
          color("SeaGreen")
            body(15);
          mirror([1,0,0]) nozzles(0);
          nozzles(0);
        }
      **/

    // Comment out to produce body with recesses
        mirror([1,0,0]) nozzles(thread, "Gold");
       // nozzles(thread, "Silver");
    }
}

// A guitar pick holder with the Jazz III shaped slots:
module stegosaurus_jazz(thickness=1.38) {
    difference() {
        color("SeaGreen") body(14);
        color("Crimson") plates_jazz(thickness);
        color("Crimson") mirror([1,0,0]) plates_jazz(thickness);
    }
}

// Determine which guitar pick shape to use:
if (pick_shape == "tortex") {
    stegosaurus_tortex(pick_thickness + pick_tolerance);
}
else if (pick_shape == "nozz") {
    stegosaurus_nozz(nozzle_thread);
}
else if (pick_shape == "jazz") {
    stegosaurus_jazz(pick_thickness + pick_tolerance);
}
