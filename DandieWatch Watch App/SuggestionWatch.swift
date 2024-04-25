//
//  SuggestionsView.swift
//  MC04
//
//  Created by Beatriz Andreucci on 03/04/24.
//

import SwiftUI
import SwiftData

struct SuggestionWatch: View {
    var viewModel: ViewModel = ViewModel()
    @Environment(\.horizontalSizeClass) var horizontalSizeClass: UserInterfaceSizeClass?
    
    
    var body: some View {
        VStack {
            ScrollView {
                HStack {
                    Text("Hábitos")
                        .font(.system(size: 20))
                        .fontWeight(.bold)
                        .foregroundStyle(.black)
                    Spacer()
                }
                
                VStack(alignment: .center) {
                    ForEach(viewModel.habits) { habit in
                        NavigationLink(destination: EditTaskWatch(habitTemplate: habit)) {
                            Text("\(habit.name)")
                        }
                        .buttonStyle(SuggestionButtonWatch())
                        .padding(.top, 10)
                    }
                    
                }
            } .background(Color("AppWhite"))
            
        }
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Habit.self, configurations: config)
        return SuggestionWatch()
            .modelContainer(container)
    } catch {
        fatalError("Alguém me desconfigurou")
    }
}
