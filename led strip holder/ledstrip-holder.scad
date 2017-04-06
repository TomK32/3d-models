/* (C) Copyright 2017 by Thomas R. Koll
 * LED strip holder is a 3D model released under the Creative Commons Attribution Share Alike license
/*

difference() {
    w = 20;
    p = 10;
    t = w - 15;
    union() {
        cube([w, w, p]);
        q = 6.2; // how wide the strip is
        f = (2*w)/t;
        k = 1.9; // thickness of the wires with 1mm space
        // two horizontal slots
        translate([w,w/f*(f-1),0]) {
            cube([q, w/f, p]);
            translate([q/f*(f-1), -k/5, 0])
                cube([q/f, w/f, p]);
        }
        translate([w,w/f*(f-2) - k,0]) {
            cube([q, w/f, p]);
            translate([q/f*(f-1), k/5, 0])
                cube([q/f, w/f, p]);
        }
    }
    // cut out to fix the wall
    translate([t/2, t/2, -1])
        cube([w-t, w+2, p+2]);
}
