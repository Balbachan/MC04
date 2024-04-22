//
//  ProductDetailsView.swift
//  MC04
//
//  Created by Beatriz Andreucci on 22/04/24.
//
import SwiftUI
import Foundation

struct ProductDetailsView: View {
    let product: Product
    var viewModel: ViewModel = ViewModel()
    
    var body: some View {
        
        VStack() {
            Image("cremeModelador")
            Text(product.name)
                .font(.custom(FontType.t1.font, size: 15))
                .frame(width: 150)
                .bold()
                .padding(.bottom)
        }.background(.appBeige)
            .clipShape(RoundedRectangle(cornerRadius: 20))
           
           
     }
}

#Preview {
    ProductDetailsView(product: Product( name: "Creme Modelador de cabelo Méner", description:"", image: "cremeModelador") )
}
