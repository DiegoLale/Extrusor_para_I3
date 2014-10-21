difference()
{
	union()
	{
		cylinder( d = 8.5, h = 13, $fn = 100);
	}
	union()
	{
		translate([0,0,8.5])rotate([90,0,0])cylinder( d = 4.5, h = 20, $fn = 50, center = true);
		translate([0,0,8.5])rotate([90,0,0])intersection()
		{
			cylinder(d = 7.3, h = 20, $fn = 50);
			cube([4.5,20,20],center = true);
		}
	}
}