
// outher length from the corner into the plates' center
length = 50;

// in mm, increases the slot width for your plates
tolerance = 0.6;

// wudth along the edge
width = 30;

// two in case you use different plates for the sides
plate_a_thickness = 5;
plate_b_thickness = 5;

clip_wall = 3;

edge_overlap = 10;

module base_plate(cutoff_percent = 0.5) {
    linear_extrude(clip_wall) polygon([
        [0, 0], [0, length], [length, length], [length, length * (1-cutoff_percent)], [length * cutoff_percent, 00]
    ]);
}

module plate(length, plate_thickness, tolerance, wall_thickness) {
    // outer side
    w = wall_thickness;
    x1 = length + w;
    y1 = y + w;
    x2 = x1 + plate_thickness + tolerance;
    polygon([
        [0, 0], [0, x], [x, y],
        [x, y1], [w, y1], [w, 0]
    ]);

}

module edge() {
        linear_extrude(width) union() {
            plate(length, plate_a_thickness, tolerance, clip_wall);
            rotate([0, 90, 0]) 
                plate(length, plate_b_thickness, tolerance, clip_wall);

        w = clip_wall;
        a = w + plate_a_thickness + tolerance;
        b = length - w - plate_b_thickness - tolerance;
        
        k = 3 * w;
        m = length /2 - k/2;
        polygon([
            [a, m], [a, m + k], [m, b], [m + k, b]
        ]);
    }
}

edge();
module corner() {
    union() {
        linear_extrude(width) union() {
            // outer side
            x = length;
            y = length;
            w = clip_wall;
            x1 = x - w;
            y1 = y - w;
            polygon([
                [0, 0], [0, x], [x, y],
                [x, y1], [w, y1], [w, 0]
            ]);
            // inner side
            a = w + plate_a_thickness + tolerance;
            b = length - w - plate_b_thickness - tolerance;
            polygon([
                [a, 0], [a, b], [length, b], [ length, b - w],
                [a + w, b - w], [a + w, 0]
            ]);
        
            polygon([
                [0, b - w], [a + w, b - w], [a + w, b], [0, b]
            ]);
            
            k = 3 * w;
            m = length /2 - k/2;
            polygon([
                [a, m], [a, m + k], [m, b], [m + k, b]
            ]); 
        }
        
        r = 0.5;
        color([0.5, 1, 0.57])  difference() {
            base_plate();
            
            intersection() {
                k = 0.1;
                scale([1-k, 1-k, 1]) translate([length * k/2, length * k/2, 0]) base_plate();
                c = 0.4   ;
                for(x = [1:3:length]) {
                   translate([x, c, c]) cube([0.01, length - 0.6, clip_wall - 2 * c]);
                }
            }
        }
     }
 }