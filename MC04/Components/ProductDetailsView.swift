//
//  ProductDetailsView.swift
//  MC04
//
//  Created by Beatriz Andreucci on 22/04/24.
//
import SwiftUI
import Foundation
import Aptabase

struct ProductDetailsView: View {
    let product: Product
    var viewModel: ViewModel = ViewModel()
    
    var body: some View {
        
        VStack {
            Link(destination: URL(string: product.url)!, label: {
                VStack {
                    Image(product.image)
                    
                    Text(product.name)
                        .multilineTextAlignment(.center)
                        .font(.custom(FontType.t1.font, size: 15))
                        .frame(width: 150)
                        .bold()
                        .padding(.bottom)
                        .foregroundColor(.black)
                }
            })
            .environment(\.openURL, OpenURLAction(handler: { url in
                print(product.name)
                Aptabase.shared.trackEvent("Mener", with: ["nome": product.name])
                return .systemAction
            }))
        }
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}

#Preview {
    ProductDetailsView(product: Product(name: "Creme Modelador da Menér", image: "cremeModelador", url: "https://www.mener.com.br/products/creme-modelador-de-cabelo"))
}
