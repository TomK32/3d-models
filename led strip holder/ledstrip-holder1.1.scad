/* (C) Copyright 2017 by Thomas R. Koll
 * LED strip holder is a 3D model released under the Creative Commons Attribution Share Alike license
*/


w = 20;
p = 10;
t = w - 15;
q = 6.5; // how wide the strip is
f = (2.5*w)/t;
k = 2; // thickness of the wires with 1mm space
u = 7;

translate([1.4 * w, 0, 0]) union() {
    difference() {
        union() {
            cube([w, w, p]);
                    
            translate([w/2, -t/2, 0])
                scale([2, 1, 1])  rotate([0, 0, 45])
                    cube([q, q, p]);
            translate([-0.5, 0, 0])
                    cube([w + 1, t/10, p]);
        }
        // cut out to fix the wall  
        translate([t/2, t/2, -1]) {
            difference() {
                cube([w-t, w+2, p+2]);
                translate([w - t + 0.4, w - t * 0.7, 0])
                    rotate([0, 0, 50])
                        cube([t/3, t/3, p+2]);
                translate([-0.4, w - t * 0.7, 0])
                    rotate([0, 0, 50])
                        cube([t/3, t/3, p+2]);
            }
        }
    }

    // two horizontal slots
    translate([w,w/f*(f-1),0]) {
        cube([q, w/f, p]);
        translate([q/f*(f-1), -k/u, 0])
            cube([q/f, q/f, p]);
    }
    
    translate([w,w/f*(f-2) - k,0]) {
        cube([q, w/f, p]);
        translate([q/f*(f-1), w/f -k/u, 0])
            cube([q/f, q/f, p]);
    }
}
