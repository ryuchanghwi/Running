//
//  CalendarTopView.swift
//  Running
//
//  Created by 류창휘 on 7/13/25.
//

import SwiftUI

struct CalendarControlView: View {
    func moveToPrevious() {
        withAnimation {
            switch viewMode {
            case .month:
                selectedDate = Calendar.current.date(byAdding: .month, value: -1, to: selectedDate)!
            case .week:
                selectedDate = Calendar.current.date(byAdding: .weekOfYear, value: -1, to: selectedDate)!
            }
        }
    }
    func moveToNext() {
        withAnimation {
            switch viewMode {
            case .month:
                selectedDate = Calendar.current.date(byAdding: .month, value: 1, to: selectedDate)!
            case .week:
                selectedDate = Calendar.current.date(byAdding: .weekOfYear, value: 1, to: selectedDate)!
            }
        }
    }
    @Binding var viewMode: CalendarViewMode
    @Binding var selectedDate: Date

    var body: some View {
        HStack {
            
            Spacer()

            Button {
                moveToPrevious()
            } label: {
                Image("chevron.left")
            }

            Text(dateToMonthYearString(selectedDate))
                .font(.headline)

            Button {
                moveToNext()
            } label: {
                Image("chevron.right")
            }
            
            Spacer()

        }
        .padding(.horizontal)

    }
    private func dateToMonthYearString(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy년 MM월"
        return formatter.string(from: date)
    }
    
}

#Preview {
    CalendarControlView(viewMode: .constant(.month), selectedDate: .constant(Date()))
}
