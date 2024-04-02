//
//  EditTaskView.swift
//  MC04
//
//  Created by Laura C. Balbachan dos Santos on 02/04/24.
//

import SwiftUI

struct EditTaskView: View {
    @Bindable var habit: Habits
    
    var body: some View {
        Form {
            TextField("Name", text: $habit.name)
        }
        .navigationTitle("Edit Destination")
        .navigationBarTitleDisplayMode(.inline)
    }
}

