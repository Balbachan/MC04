//
//  ContentView.swift
//  MC04
//
//  Created by Laura C. Balbachan dos Santos on 27/03/24.
//

import SwiftData
import SwiftUI
import UserNotifications 

struct ContentView: View {
    
//    @Binding var dismissToHome: Bool
    
    var body: some View {
        NavigationStack {
            VStack {
                CalendarView()
            }.onAppear{
                UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                                if success {
                                    print("Permission approved!")
                                } else if let error = error {
                                    print(error.localizedDescription)
                                }
                            }
            }
        }
    }
}



//#Preview {
//    ContentView()
//}
