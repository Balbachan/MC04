//
//  SuggestionsView.swift
//  MC04
//
//  Created by Beatriz Andreucci on 03/04/24.
//

import SwiftUI
import SwiftData

struct SuggestionsView: View {
    //    @Bindable var habits: Habits
    var vm: ViewModel = ViewModel()
    
    var body: some View {
        VStack(spacing: 60){
            ForEach(vm.habits, id: \.self) { habit in
                SuggestionCard(habits: habit)

            }
        }
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
