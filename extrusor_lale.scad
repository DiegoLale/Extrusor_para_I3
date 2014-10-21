
//modulo de agujeros para cuatro tornillos, se invoca con el centro del motor
//el ajuste está configurado en el eje x con +-2mm
//para que el ajuste esté en el eje y se debe girar 90º
module cuatro_tornillos(altura_cabeza,longitud)
	{
	translate([0,0,-1])cylinder(h=longitud+1,r=16,$fn=100);
	translate([-31/2,-31/2,0])for(i = [0,31],e= [0,31])
		{
		translate([i,e,0])union()
							{
							hull()
							{
							translate([-2,0,-1])cylinder(r=3.7,h=altura_cabeza+1,$fn=20);
							translate([2,0,-1])cylinder(r=3.7,h=altura_cabeza+1,$fn=20);
							}
							hull()
							{
							translate([-2,0,altura_cabeza+0.2])cylinder(r=1.65,h=longitud-altura_cabeza,$fn=20);
							translate([2,0,altura_cabeza+0.2])cylinder(r=1.65,h=longitud-altura_cabeza,$fn=20);
							}
					}
		}
	}
//no tiene mucho sentido este módulo... es para que no cargue mucho abajo
//son los tornillos que sujetan el extrusor al carro
//y los que sujetan el rebaje del j_head
module tornillos_frente()
{
	translate([0,-5,5])rotate([-90,0,0])cylinder(r=1.7,h=60, $fn= 20);
	translate([0,-5,29])rotate([-90,0,0])cylinder(r=1.7,h=60, $fn= 20);
	translate([0,30,5])rotate([-90,0,0])cylinder(r=3,h=30, $fn= 20);
	translate([0,30,29])rotate([-90,0,0])cylinder(r=3,h=30, $fn= 20);
	translate([-3,10,9.5])rotate([-90,0,0])cylinder(r=1.6,h=40, $fn= 20);
	translate([-3,10,24.5])rotate([-90,0,0])cylinder(r=1.6,h=40, $fn= 20);

}
module j_head()
{
	translate([-12,30.5,17])rotate([0,90,0])cylinder(r=16.8/2,h=15,$fn=50);//hueco j-head
	translate([0,30.5,17])rotate([0,90,0])cylinder(r1=2,r2=3,h=30,$fn=50);//hueco guia filamento abajo
	translate([30,30.5,17])rotate([0,90,0])cylinder(r=2.6,h=30,$fn=50);//hueco guia filamento abajo
}
module tensor()
{
	translate([45,27,20])cylinder(r=4.75,h=20,$fn=40);//hueco pivote superior
	translate([45,27,-1])cylinder(r=4.75,h=15,$fn=40);//hueco pivote inferior
	translate([43,30,27.2])cube([4,10,10]);//hueco recorte entrada tensor 1
	hull()
	{
		translate([45,27,25])rotate([-90,0,5])cylinder(r=2,h=20,$fn=40);//hueco guia tensor 1
		translate([45,27,25])rotate([-90,0,-25])cylinder(r=2,h=20,$fn=40);//hueco guia tensor 1
	}
	translate([43,30,-2])cube([4,10,10]);//hueco recorte entrada tensor 2
	hull()
	{
		translate([45,27,9])rotate([-90,0,5])cylinder(r=2,h=20,$fn=40);//hueco guia tensor 2
		translate([45,27,9])rotate([-90,0,-25])cylinder(r=2,h=20,$fn=40);//hueco guia tensor 2
	}

}
module hobbed_y_rodamientos()
{
		translate([28,26,-1])cylinder(r = 11.25,h = 8.5);//rodamiento parte engranaje
		translate([28,26,-1])cylinder(r = 8,h = 11);//rebaje rodamiento parte engranaje para evitar roce
		translate([28,26,26.5])cylinder(r = 11.25,h = 8.5);//rodamiento parte tuerca
		translate([28,26,24])cylinder(r = 8,h = 15);//rebaje rodamiento parte tuerca pare evitar roce
		hull()
		{
			translate([28,26,-1])cylinder(r = 5, h = 50, $fn = 20);//eje hobbed bolt
			translate([28,40,-1])cylinder(r = 10, h = 50, $fn = 20);//parte enfrente de eje hobbed bolt
		}
}
//comienzo del extrusor.
//29/09/2014
//Objetivo: extrusor que ocupe lo menos posible en en eje x para aprovechar el recorrido de la prusa I3
difference()
{
	union()//partes "positivas"
	{

		minkowski()
		{
			translate([60,0,5])cube([42-6+4,42-6,10],center=true);
			cylinder(r=3,$fn=20);
		}
		difference()
		{
		translate([-7,0,0])cube([59,43,34]);//cubo base principal
		union()
		{
			translate([11,37,-1])cube([50,10,40]); //rebaje frontal
			translate([11,43,-1])cylinder(r=6,h=40,$fn=20);//redondeo frontal
		}
		}
		translate([24,-13,0])cube([14,14,10.1]);//cubo refuerzo union principal con placa motor
		hull()
		{
			translate([11,43,10])cylinder(r=5,h=14,$fn=30);//bisagra eje tensor
			translate([5,35,10])cube([11,8,14]);
		}

	}
	union()//partes "negativas"
	{
		tornillos_frente();
		translate([60,0,0])cuatro_tornillos(4,20);
		j_head();
		tensor();
		hobbed_y_rodamientos();
		translate([24,-13,-1])cylinder(r=13,h=40);//redondeo refuerzo union principal con placa motor
		translate([11,43,5])cylinder(r=1.7,h=20,$fn=30);//bisagra eje tensor
		translate([60,0,0])rotate([0,90,0])cylinder(r=5,h=50);//hueco tornillo ajuste engranaje
		minkowski()//hueco del motor
		{
			translate([41.5,-17,10])cube([57,33.1,50]);
			cylinder(r=5,$fn=20);	
		}
		minkowski()//rebaje trasero
			{
			translate([10,-5,10])cube([50,13,50]);
			cylinder(r=5,$fn=20);
			}	
	}
}
/////////////////////////////////////////////////////////////////////////////////////////////////
//Aqui termina el extrusor y empiezan las ayudas a la impresion
//Se puede comentar todo si no se necesita



intersection()	//Soportes para impresion del hueco del rodamiento inferior
{
	union()
	{
	translate([28,26,0])cylinder(r = 7.8,h = 10);//rodamiento parte engranaje
	translate([28,26,0])cylinder(r = 11,h = 8);//rodamiento parte engranaje
	}
	union()
	{
	for (i= [16:1.5:33])
	{
	translate([0,i,0])cube([100,1,15]);
	}
}
}

intersection()//soporte bisagra tensor
{
	union()
	{
	translate([11,43,0])cylinder(r=5.8,h=10,$fn=30);
	}
	union()
	{
	for (i= [37.5:1.5:50])
	{
	translate([0,i,0])cube([100,1,15]);
	}
}
}
//orejas de ratón para evitar warping
difference()
{
	union()
	{
		translate([-7,0,0])cylinder(r=10,h=1);//orejas de raton
		translate([-7,43,0])cylinder(r=10,h=1);//orejas de raton
		translate([54,36,0])cylinder(r=10,h=1);//orejas de raton
		translate([38,-21,0])cylinder(r=10,h=1);//orejas de raton
		translate([83,-21,0])cylinder(r=10,h=1);//orejas de raton
		translate([83,20,0])cylinder(r=10,h=1);//orejas de raton
	}
	union()//a las orejas de raton se les restan los agujeros de los tornillos
	{
		translate([60,0,0])cuatro_tornillos(4,20);
		translate([43,30,-2])cube([5,15,10]);//hueco recorte entrada tensor 2
		translate([45,27,-1])cylinder(r=4.75,h=15,$fn=40);//hueco pivote inferior
	}
}


