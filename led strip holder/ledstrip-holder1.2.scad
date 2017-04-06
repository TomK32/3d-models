/* (C) Copyright 2017 by Thomas R. Koll
 * LED strip holder is a 3D model released under the Creative Commons Attribution Share Alike license
*/


w = 20;
extrude_width = 10;
t = w - 15;
q = 6.5; // how wide the strip is
k = 2; // thickness of the wires with 1mm space

module top_decoration(w, t) {
    // overhang on the top
    translate([-0.5, 0]) square([w + 1, t/5]);
    // pyramid on the top
    polygon([[w/4, 0], [w/2, -t], [w * 0.75, 0]]);
}

module bottom_decoration(w, t) {
    f = t/5;
    translate([t/2, 0]) polygon([[0, 0], [f, 0], [0, -f]]);
    translate([w -t/2, 0]) polygon([[0, 0], [-f, 0], [0, -f]]);
}

linear_extrude(extrude_width) union() {
    top_decoration(w, t/2);
    difference() {
        square(w); // base body
        translate([t/2, t/2]) {
            square([w-t, w]);
        }
    }
    translate([0, w]) bottom_decoration(w, t);
    
    // clip to hold the cable
    translate([w, w - 3 * k]) difference() {
        square([q, k * 3]);
        difference() {
            translate([0, k]) square([q, k]);
            polygon([[q, k], [q, k * 1.2], [q - k / 1.2, k]]);
            translate([0, k]) polygon([[q, k], [q, k / 1.2], [q - k / 1.3, k]]);
        }
    }
}

