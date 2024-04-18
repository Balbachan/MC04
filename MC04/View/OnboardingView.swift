//
//  OnboardingView.swift
//  Dandie
//
//  Created by Laura C. Balbachan dos Santos on 11/04/24.
//

import SwiftUI
import Aptabase

struct OnboardingView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @Binding var isPresented: Bool
    
    @State private var introIndex: Int = 0
    
    var body: some View {
        GeometryReader { geometry in
            NavigationStack {
                VStack {
                    // Instruções e imagens do Onboarding
                    TabView(selection: $introIndex) {
                        ForEach(0..<OnboardingModel().introduction.count, id: \.self) { index in
                            VStack {
                                Image("\(OnboardingModel().introImagesLight[index])")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: geometry.size.width, height: geometry.size.height * 0.5)
                                    .padding(.bottom, 40)
                                
                                Text("\(OnboardingModel().introduction[index])")
                                    .multilineTextAlignment(.center)
                            }
                        }
                    }
                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                    .ignoresSafeArea()
                    
                    // Index em cículos personalizado
                    VStack {
                        HStack {
                            ForEach(0..<OnboardingModel().introduction.count, id: \.self) { index in
                                Circle()
                                    .fill(introIndex == index ? Color.appYellow : Color.appLightGray)
                                    .frame(width: 22)
                                    .onTapGesture {
                                        introIndex = index
                                    }
                            }
                            .padding(.bottom, 10)
                        }
                        
                        
                        // Condição para os botões certos aparecerem nas etapas do Onboarding
                        if(introIndex == (OnboardingModel().introduction.count - 1)) {
                            Button("Vamos começar") {
                                // MARK: Aqui daria um dissmiss para ir para o calendar view
                                isPresented = false
                                Aptabase.shared.trackEvent("Vamos comecar") 
                                dismiss()
                            }
                            .buttonStyle(OnboardingButtonStyle())
                            .padding(.bottom, 71)
                            
                            
                        } else {
                            Button("Prosseguir") {
                                introIndex += 1
                                Aptabase.shared.trackEvent("Prosseguir OnBoarding") // An event with a custom property
                            }
                            .buttonStyle(OnboardingButtonStyle())
                            
                            Button("Pular") {
                                introIndex = (OnboardingModel().introduction.count - 1)
                                Aptabase.shared.trackEvent("Pular OnBoarding") 
                            }
                            .buttonStyle(OnboardingButtonStyle(isOrange: false))
                        }
                    }
                }
                .background(.appWhite)
            }
        }
    }
}

#Preview {
    OnboardingView(isPresented: .constant(true))
}
