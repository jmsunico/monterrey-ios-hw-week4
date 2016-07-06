//
//  ViewController.swift
//  marcandoRuta
//
//  Created by José-María Súnico on 20160706.
//  Copyright © 2016 José-María Súnico. All rights reserved.

// Proyecto
// Hacer una aplicación en Swift que se pueda correr en el simulador de iOS usando Xcode que permita:
//   1. Poner un mapa en la pantalla.
//   2. Escoger el tipo de mapa (normal, satélite o híbrido) mediante 3 botones o el mecanismo que usted desee.
//   3. El mapa debe estar centrado en la posición actual del dispositivo.
//   4. El mapa debe tener un zoom in en el que se puedan ver las calles de la ciudad (usted decide cuánto es).
//   5. Pedir autorización para leer la posición del dispositivo.
//   6. Mostrar la posición actual del dispositivo en todo momento (punto azul).
//   7. Cada vez que el dispositivo se mueva a más de 50 metros del punto actual, deberá colocar un pin.
//   8. El pin debe tener como título, la posición en (longitud, latitud).
//   9. El pin debe tener como subtítulo, la distancia recorrida hasta el momento.
//		NOTA: Como el programa corre en el simulador se debe seleccionar la opción de “Paseo en bicicleta”, 
//		lo que supondrá que la posición actual del dispositivo es Cupertino, CA, USA. 
//		Si el programa se corre en un dispositivo, marcará la ruta real seguida por el usuario.

import UIKit

class ViewController: UIViewController {

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

}

