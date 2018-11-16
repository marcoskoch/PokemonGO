//
//  CoreDataPokemon.swift
//  PokemonGO
//
//  Created by Marcos Koch on 16/11/18.
//  Copyright © 2018 Marcos Koch. All rights reserved.
//

import UIKit
import CoreData

class CoreDataPokemon {
    
    func getContext() -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        let context = appDelegate?.persistentContainer.viewContext
        return context!
    }
    
    func getAllPokemons() -> [Pokemon] {
        let context = self.getContext()
        
        do {
            let pokemons = try context.fetch( Pokemon.fetchRequest() ) as! [Pokemon]
            
            if pokemons.count == 0 {
                self.addAllPokemons()
                return self.getAllPokemons()
            }
            
            return pokemons
        } catch {}
        
        return []
    }
    
    func addAllPokemons() {
        let context = self.getContext()
        
        self.createPokemon(nome: "Pikachu", nomeimagem: "pikachu-2", capturado: true)
        self.createPokemon(nome: "Mew", nomeimagem: "mew", capturado: false)
        self.createPokemon(nome: "Abra", nomeimagem: "abra", capturado: false)
        self.createPokemon(nome: "Bullbasaur", nomeimagem: "bullbasaur", capturado: false)
        self.createPokemon(nome: "Charmander", nomeimagem: "charmander", capturado: false)
        self.createPokemon(nome: "Dratini", nomeimagem: "dratini", capturado: false)
        self.createPokemon(nome: "Eevee", nomeimagem: "eevee", capturado: false)
        self.createPokemon(nome: "Mankey", nomeimagem: "mankey", capturado: false)
        self.createPokemon(nome: "Meowth", nomeimagem: "meowth", capturado: false)
        self.createPokemon(nome: "Pidgey", nomeimagem: "pidgey", capturado: false)
        self.createPokemon(nome: "Psyduck", nomeimagem: "psyduck", capturado: false)
        self.createPokemon(nome: "Rattata", nomeimagem: "rattata", capturado: false)
        self.createPokemon(nome: "Snorlax", nomeimagem: "snorlax", capturado: false)
        self.createPokemon(nome: "Zubat", nomeimagem: "zubat", capturado: false)
        
        do {
            try context.save()
        } catch {}
    }
    
    func createPokemon(nome: String, nomeimagem: String, capturado: Bool) {
        let context = self.getContext()
        let pokemon = Pokemon(context: context)
        pokemon.nome = nome
        pokemon.nomeimagem = nomeimagem
        pokemon.capturado = capturado
    }
    
    func getPokemonByCapturado(capturado: Bool) -> [Pokemon] {
        let context = self.getContext()
        
        let requisicao = Pokemon.fetchRequest() as NSFetchRequest<Pokemon>
        requisicao.predicate = NSPredicate(format: "capturado = %@", NSNumber(value: capturado) )
        
        do{
            let pokemons = try context.fetch( requisicao ) as [Pokemon]
            return pokemons
        }catch{}
        
        return []
    }
}
