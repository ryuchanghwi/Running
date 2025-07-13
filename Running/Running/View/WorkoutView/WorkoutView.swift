//
//  WorkoutView.swift
//  Running
//
//  Created by 류창휘 on 7/12/25.
//

import SwiftUI

struct WorkoutView: View {
    @State private var selectedDate = Date()
    @State private var viewMode: CalendarViewMode = .month
    var datesWithData: [Date] = [
        Calendar.current.date(byAdding: .day, value: -1, to: Date())!,
        Calendar.current.date(byAdding: .day, value: 2, to: Date())!
    ]

    var calendarHeight: CGFloat {
        viewMode == .month ? 320 : 100
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                // 캘린더 높이에 따라 애니메이션 적용
                CalendarView(viewMode: $viewMode,
                             selectedDate: $selectedDate,
                             datesWithData: datesWithData)
                    .animation(.easeInOut(duration: 0.3), value: calendarHeight)
                    .padding(.top, 50)
                    .background(content: {
                        Color(hex: 0x7442FF)
                    })
                    .cornerRadius(20, corners: [.bottomLeft, .bottomRight])

                
                Spacer()
            }
        }
        .ignoresSafeArea(.all)
    }
}

#Preview {
    WorkoutView()
}
