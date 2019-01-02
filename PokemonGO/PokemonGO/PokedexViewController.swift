//
//  PokedexViewController.swift
//  PokemonGO
//
//  Created by Marcos Koch on 16/11/18.
//  Copyright © 2018 Marcos Koch. All rights reserved.
//

import UIKit

class PokedexViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var pokemonsCapturados: [Pokemon] = []
    var pokemonsNaoCapturados: [Pokemon] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let coreDataPokemon = CoreDataPokemon()
        
        self.pokemonsCapturados = coreDataPokemon.getPokemonByCapturado(capturado: true)
        self.pokemonsNaoCapturados = coreDataPokemon.getPokemonByCapturado(capturado: false)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Capturados"
        } else {
            return "Não Capturados"
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return self.pokemonsCapturados.count
        } else {
            return self.pokemonsNaoCapturados.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let pokemon: Pokemon
        
        if indexPath.section == 0 {
            pokemon =  self.pokemonsCapturados[ indexPath.row ]
        } else {
            pokemon =  self.pokemonsNaoCapturados[ indexPath.row ]
        }
        
        let celula = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "celula")
        
        celula.textLabel?.text = pokemon.nome
        celula.imageView?.image = UIImage(named: pokemon.nomeimagem!)
        
        return celula
    }

    @IBAction func backToMao(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
