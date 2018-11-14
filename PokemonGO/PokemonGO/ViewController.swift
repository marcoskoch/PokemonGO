//
//  ViewController.swift
//  PokemonGO
//  
//  Created by Marcos Koch on 13/11/18.
//  Copyright © 2018 Marcos Koch. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var mapa: MKMapView!
    var gerenciadorLocalizacao = CLLocationManager()
    var counter = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapa.delegate = self
        gerenciadorLocalizacao.delegate = self
        gerenciadorLocalizacao.requestWhenInUseAuthorization()
        gerenciadorLocalizacao.startUpdatingLocation()
        
        Timer.scheduledTimer(withTimeInterval: 8, repeats: true) { (timer) in
            if let coordinates = self.gerenciadorLocalizacao.location?.coordinate {
                let annotation = MKPointAnnotation()
                
                let latitudeRandom = (Double(arc4random_uniform(400)) - 200) / 100000.0
                let longitudeRandom = (Double(arc4random_uniform(400)) - 200) / 100000.0
                
                annotation.coordinate = coordinates
                annotation.coordinate.latitude += latitudeRandom
                annotation.coordinate.longitude += longitudeRandom
                
                self.mapa.addAnnotation(annotation)
            }
        }
        
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: nil)
        
        annotationView.image = UIImage(named: "pikachu-2")
        
        if annotation is MKUserLocation {
            annotationView.image = UIImage(named: "player")
        }
        
        var frame = annotationView.frame
        frame.size.width = 40
        frame.size.height = 40
        
        annotationView.frame = frame
        
        return annotationView
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        if status != .authorizedWhenInUse && status != .notDetermined {
            let alertController = UIAlertController(title: "Permissão de Localização", message: "Precisamos da Localização", preferredStyle: .alert)
            
            let acaoConfiguracoes = UIAlertAction(title: "Abrir Configurações", style: .default, handler: {
                (alertaConfiguracoes) in
                
                if let configuracoes = NSURL( string: UIApplication.openSettingsURLString ) {
                    UIApplication.shared.open(configuracoes as URL)
                }
            })
            
            let acaoCancelar = UIAlertAction(title: "Cancelar", style: .default, handler: nil)
            
            alertController.addAction(acaoConfiguracoes)
            alertController.addAction(acaoCancelar)
            
            present(alertController, animated: true, completion: nil)
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if counter < 3 {
            self.centerPlayerOnMap()
            counter += 1
        } else {
            gerenciadorLocalizacao.stopUpdatingLocation()
        }
        
    }
    
    func centerPlayerOnMap(){
        if let coordinates = gerenciadorLocalizacao.location?.coordinate {
            let region = MKCoordinateRegion(center: coordinates, latitudinalMeters: 300, longitudinalMeters: 300)
            mapa.setRegion(region, animated: true)
        }
    }
    
    @IBAction func centerPlayer(_ sender: Any) {
        self.centerPlayerOnMap()
    }
    
    @IBAction func openPokedex(_ sender: Any) {
    }
}

