difference()
{
	hull()
	{
		translate([-15,-4,0])cube([30,8,3]);
		translate([0,0,4])rotate([0,90,0])cylinder(r=4, h = 30, center = true,$fn = 50);
	}
	union()
	{
		translate([-8,0,-1])cylinder(r=2.5, h = 20, $fn = 50);
		translate([8,0,-1])cylinder(r=2.5, h = 20, $fn = 50);
	}
}