//
//  TabView.swift
//  Running
//
//  Created by 류창휘 on 7/12/25.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            Tab("운동하기", image: "tray.and.arrow.down.fill") {
                WorkoutView()

            }
        }
    }
}

#Preview {
    MainTabView()
}
