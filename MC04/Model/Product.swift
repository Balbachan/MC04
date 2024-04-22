//
//  Product.swift
//  MC04
//
//  Created by Beatriz Andreucci on 22/04/24.
//

import Foundation

struct Product: Identifiable, Hashable {
    let id = UUID()
    let name: String
    let image: String
    let url: String
}

var products: [Product] = [
   
    Product(name: "Gel-creme facial Méner 5 em 1", image: "gelFacial", url: "https://www.mener.com.br/products/gel-creme-facial-5-em-1"),
    Product(name: "Sabonete em barra Méner hydra-detox", image: "saboneteDetox", url: "https://www.mener.com.br/products/sabonete-hidra-detox"),
    Product(name: "Sabonete em barra Méner oil control", image: "saboneteOilControl", url: "https://www.mener.com.br/products/sabonete"),
    Product(name: "Gel de barbear \n Méner", image: "gelBarbear", url: "https://www.mener.com.br/products/gel-de-barbear"),
    Product(name: "Creme Modelador de Cabelo Méner", image: "cremeModelador", url: "https://www.mener.com.br/products/creme-modelador-de-cabelo")
]
