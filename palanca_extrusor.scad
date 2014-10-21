module rodamiento()
{
rotate([0,90,0])cylinder(r = 2.7, h = 15.5, $fn = 50, center = true);
rotate([0,90,0])cylinder(r = 10, h = 8, $fn = 50, center = true);
translate([0,0,-2])cube([15.5,4.8,4],center = true);
}

difference()
{
	union()
	{
		hull()
		{
			translate([0,0,5])rotate([0,90,0])cylinder(r = 5, h = 30, $fn = 50, center = true);//positivo eje
			translate([-15,34,0])cube([30,5,10]);
		}
		
	}
	union()
	{
		translate([0,17,2])rodamiento();
		translate([-7.45,15,-1])cube([14.90,4,3]);//entrada eje rodamiento
		translate([0,34,14])rotate([0,90,0])cylinder(r = 5, h = 50, $fn = 50, center = true);
		translate([0,0,5])rotate([0,90,0])cylinder(r = 1.75, h = 50, $fn = 50, center = true);// eje
		translate([0,0,5])rotate([0,90,0])cylinder(r = 6, h = 15, $fn = 50, center = true);//corte eje	
		translate([-16,0,5])rotate([0,90,0])cylinder(r = 3.25, h = 3, $fn = 6);
		translate([12,0,5])rotate([0,90,0])cylinder(r = 3.15, h = 4, $fn = 60);
		translate([-7.5,0,-1])cube([15,6,6]);
		translate([0,40,0])rotate([-15,0,0])cube([40,10,30],center=true);
		hull()
		{
			translate([-8,33,-1])cylinder(r=2.6,h=20,$fn= 20);
			translate([-8,44,-1])cylinder(r=2.6,h=20,$fn= 20);
		}
		hull()
		{
			translate([8,33,-1])cylinder(r=2.6,h=20,$fn= 20);
			translate([8,44,-1])cylinder(r=2.6,h=20,$fn= 20);
		}
	}
}
