//
//  SuggestionsView.swift
//  MC04
//
//  Created by Beatriz Andreucci on 03/04/24.
//

import SwiftUI
import SwiftData

struct SuggestionsView: View {
    var viewModel: ViewModel = ViewModel()
    @Environment(\.horizontalSizeClass) var horizontalSizeClass: UserInterfaceSizeClass?
    
    
    var body: some View {
        
//        GeometryReader { geometry in
            VStack {
                // Título da Seção
                HStack {
                    Text("Hábitos")
                        .font(.custom("Digitalt", size: 28))
                        .fontWeight(.bold)
                    Spacer()
                }
                
                
                ScrollView {
                    VStack(alignment: .center) {
                        ForEach(viewModel.habits) { habit in
                            NavigationLink(destination: EditTaskView(habitModel: habit)) {
                                Text("\(habit.name)")
                                    .font(.custom("Digitalt", size: 25))
                                    .foregroundColor(.black)
                                    .padding(30)
                                
                                    .background (
                                        RoundedRectangle(cornerRadius: 20)
//                                            .frame(width: geometry.size.width * 0.9, height: geometry.size.height * 0.1)
                                    )
                            }
                        }
                    }
                    
                }
            }
            .padding(20)
//        }
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Habits.self, configurations: config)
        return SuggestionsView()
            .modelContainer(container)
    } catch {
        fatalError("Alguém me desconfigurou")
    }
}
