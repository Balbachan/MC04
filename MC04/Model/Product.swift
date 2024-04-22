//
//  Product.swift
//  MC04
//
//  Created by Beatriz Andreucci on 22/04/24.
//

import Foundation

struct Product: Identifiable {
    let id = UUID ()
    let name: String
    let description: String
    let image: String
}

var products: [Product] = [
Product(name: "Creme Modelador de cabelo Méner", description:"", image: ""),
Product(name: "Creme Modelador de cabelo Méner", description:"", image: ""),
Product(name: "Creme Modelador de cabelo Méner", description:"", image: ""),
Product(name: "Creme Modelador de cabelo Méner", description:"", image: "")
]
