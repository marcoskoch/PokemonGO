//
//  PokemonAnnotation.swift
//  PokemonGO
//
//  Created by Marcos Koch on 16/11/18.
//  Copyright © 2018 Marcos Koch. All rights reserved.
//

import UIKit
import MapKit

class PokemonAnnotation: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var pokemon: Pokemon
    
    init(coordinate: CLLocationCoordinate2D, pokemon: Pokemon) {
        self.coordinate = coordinate
        self.pokemon = pokemon
    }
}
