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
import CoreLocation
import MapKit


class ViewController: UIViewController, CLLocationManagerDelegate {
	var userBefore : CLLocation?
	var userNow : CLLocation?
	var lastMarker : CLLocation?
	var cumDistance = 0.0
	var minSep = 100

	@IBOutlet weak var latitudeLabel: UILabel!
	@IBOutlet weak var latitudeValue: UILabel!

	@IBOutlet weak var longitudeLabel: UILabel!
	@IBOutlet weak var longitudeValue: UILabel!
	
	@IBOutlet weak var precisionLabel: UILabel!
	@IBOutlet weak var precisionValue: UILabel!
	
	@IBOutlet weak var magNorthLabel: UILabel!
	@IBOutlet weak var magNorthValue: UILabel!

	@IBOutlet weak var geoNorthLabel: UILabel!
	@IBOutlet weak var geoNorthValue: UILabel!
	
	@IBOutlet weak var distanceLabel: UILabel!
	@IBOutlet weak var distanceValue: UILabel!
	
	@IBOutlet weak var myMap: MKMapView!
	
	private let locationHandler = CLLocationManager()

	
	@IBAction func standardMap(sender: UIButton) {
		myMap.mapType = MKMapType.Standard
	}
	@IBAction func hybridMap(sender: UIButton) {
		myMap.mapType = MKMapType.Hybrid
	}
	@IBAction func satelliteMap(sender: UIButton) {
		myMap.mapType = MKMapType.Satellite
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		self.latitudeValue.text = ""
		self.longitudeValue.text = ""
		self.precisionValue.text = ""

		locationHandler.delegate = self
		locationHandler.desiredAccuracy = kCLLocationAccuracyBest
		locationHandler.requestWhenInUseAuthorization()
		let a = CLLocationCoordinate2DMake(40.4124251380939, -3.71823010035205)
		addMarker(a, title: "DREAMSIFIED", subtitle: "Google Campus @ MAdrid, Spain")
	}

	func addMarker(location : CLLocationCoordinate2D, title: String, subtitle: String){
		let locationPin = MKPointAnnotation()
		locationPin.title = title
		locationPin.subtitle = subtitle
		locationPin.coordinate = location
		//locationPin.imageName = ""
		myMap.addAnnotation(locationPin)
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

	// Implementing LocationManager Basic Protocol
	
	func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
		if status == .AuthorizedWhenInUse{
			locationHandler.startUpdatingLocation()
			locationHandler.startUpdatingHeading()
			myMap.showsUserLocation = true
		}
		else{
			locationHandler.stopUpdatingLocation()
			locationHandler.stopUpdatingHeading()
			myMap.showsUserLocation = false
		}
		
		myMap.setCenterCoordinate(myMap.userLocation.coordinate, animated: true)
		myMap.showsScale = true
		myMap.showsCompass = true
		myMap.showsTraffic = true
		myMap.showsTraffic = true
		myMap.showsBuildings = true
	}
	
	func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
		userNow = locations.last!
		if (userBefore == nil) || (lastMarker == nil){
			userBefore = userNow
			lastMarker = userNow
		}
		if (userNow != userBefore){
			cumDistance += userNow!.distanceFromLocation(userBefore!)
			if lastMarker!.distanceFromLocation(userBefore!) > 49{
				addMarker(userBefore!.coordinate, title: "( \(String(userBefore!.coordinate.latitude)), \(String(userBefore!.coordinate.longitude)))", subtitle: String(cumDistance))
				lastMarker = userBefore
			}
		}
		userBefore = userNow
		
		
		
		self.latitudeValue.text = String(userNow!.coordinate.latitude)
		self.longitudeValue.text = String(userNow!.coordinate.longitude)
		self.precisionValue.text = String(userNow!.horizontalAccuracy)
		
		self.distanceValue.text = String(Int(cumDistance))

		let center = CLLocationCoordinate2D(latitude: userNow!.coordinate.latitude, longitude: userNow!.coordinate.longitude)
		let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
		self.myMap.setRegion(region, animated: true)
		
		
	}
	
	func locationManager(manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
		self.magNorthValue.text = String(newHeading.magneticHeading)
		self.geoNorthValue.text = String(newHeading.trueHeading)
	}
	
	func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
		let alert = UIAlertController(title: "ERROR!!!", message: "error: \(error.code)", preferredStyle: .Alert)
		let okAction = UIAlertAction(title: "OK", style: .Default, handler: {
			action in
			print("Any action, if needed")
		})
		alert.addAction(okAction)
		self.presentViewController(alert, animated: true, completion: nil)
	}
	
}

class CustomPointAnnotation: MKPointAnnotation {
	
}