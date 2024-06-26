//
//  SuggestionsView.swift
//  MC04
//
//  Created by Beatriz Andreucci on 03/04/24.
//

import SwiftUI
import SwiftData
import Aptabase

struct SuggestionsView: View {
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.horizontalSizeClass) var horizontalSizeClass: UserInterfaceSizeClass?
    @State var dismissToHome: Bool = false
    
    var viewModel: ViewModel = ViewModel()
    
    private func dismiss() {
        presentationMode.wrappedValue.dismiss()
    }
    
    func backToHome(){
        if dismissToHome == true{
            dismissToHome.toggle()
            dismiss()
        }
    }
    
    var body: some View {
        VStack {
            ScrollView {
                VStack(alignment: .center) {
                    ForEach(viewModel.habits) { habit in
                        NavigationLink(destination: EditTaskView(dismissToHome: $dismissToHome, habitModel: habit)
                            .onAppear(perform: {
                            Aptabase.shared.trackEvent("Habitos", with: ["nome": habit.name]) // An event with a custom property
                        })) {
                            Text("\(habit.name)")
                        }
                        .buttonStyle(SuggestionButtonStyle())
                        .padding(.top, 10)
                    }
                }
                .buttonStyle(DandiButtonStyle())
                .padding(.top, 22)
            }
            .scrollIndicators(.hidden)
            .padding(.horizontal, 40)
        }
        .navigationTitle("Hábitos")
        .navigationBarTitleDisplayMode(.large)
        .background(.appWhite)
        .onAppear(){
            backToHome()
        }
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Habit.self, configurations: config)
        return SuggestionsView()
            .modelContainer(container)
    } catch {
        fatalError("Alguém me desconfigurou")
    }
}
