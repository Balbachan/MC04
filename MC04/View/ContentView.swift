//
//  ContentView.swift
//  MC04
//
//  Created by Laura C. Balbachan dos Santos on 27/03/24.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            VStack {
                CalendarView()
            }
        }
    }
}



#Preview {
    ContentView()
}
