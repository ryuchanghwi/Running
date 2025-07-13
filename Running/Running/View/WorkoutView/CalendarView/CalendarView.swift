//
//  CalendarView.swift
//  Running
//
//  Created by 류창휘 on 7/13/25.
//
import SwiftUI

enum CalendarViewMode {
    case week
    case month
}

struct CalendarView: View {
    @Binding var viewMode: CalendarViewMode
    @Binding var selectedDate: Date

    let datesWithData: [Date]

    var calendarHeight: CGFloat {
        viewMode == .month ? 320 : 100
    }

    var body: some View {
        VStack(spacing: 0) {
            CalendarControlView(viewMode: $viewMode, selectedDate: $selectedDate)
            ZStack {
                MonthView(selectedDate: $selectedDate, datesWithData: datesWithData)
                    .opacity(viewMode == .month ? 1 : 0)
                WeekView(selectedDate: $selectedDate, datesWithData: datesWithData)
                    .opacity(viewMode == .week ? 1 : 0)
            }
            .frame(height: calendarHeight)
            .animation(.easeInOut, value: viewMode)
            CalendarModeControlView(viewMode: $viewMode)
        }
    }
}

struct MonthView: View {
    @Binding var selectedDate: Date
    let datesWithData: [Date]

    var body: some View {
        let days = generateMonthGrid(for: selectedDate)

        LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 7)) {
            ForEach(days, id: \.self) { date in
                DateCell(date: date,
                         isSelected: Calendar.current.isDate(date, inSameDayAs: selectedDate),
                         hasData: datesWithData.contains { Calendar.current.isDate($0, inSameDayAs: date) })
                .onTapGesture {
                    selectedDate = date
                }
            }
        }
        .padding()
    }

    private func generateMonthGrid(for date: Date) -> [Date] {
        guard let monthInterval = Calendar.current.dateInterval(of: .month, for: date) else { return [] }

        var dates: [Date] = []
        var current = monthInterval.start

        let weekdayOffset = Calendar.current.component(.weekday, from: current) - 1
        for _ in 0..<weekdayOffset {
            dates.append(Date.distantPast)
        }

        while current < monthInterval.end {
            dates.append(current)
            current = Calendar.current.date(byAdding: .day, value: 1, to: current)!
        }

        return dates
    }
}
struct DateCell: View {
    let date: Date
    let isSelected: Bool
    let hasData: Bool

    var body: some View {
        VStack {
            if date == Date.distantPast {
                Color.clear.frame(height: 40)
            } else {
                ZStack {
                    if isSelected {
                        Circle()
                            .fill(Color.blue.opacity(0.3))
                            .frame(width: 36, height: 36)
                    }
                    
                    Text("\(Calendar.current.component(.day, from: date))")
                        .foregroundColor(.primary)
                    
                    if hasData {
                        VStack {
                            Spacer()
                            Image(systemName: "circle.fill") // 데이터가 있을 때 표시할 이미지
                                .foregroundColor(.pink)
                                .font(.system(size: 6))
                                .padding(.bottom, 4)
                        }
                    }
                }
                .frame(height: 40)
            }
        }
    }
}
struct WeekView: View {
    @Binding var selectedDate: Date
    let datesWithData: [Date]

    var body: some View {
        let weekDates = getCurrentWeek(for: selectedDate)
        LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 7)) {
            ForEach(weekDates, id: \.self) { date in
                DateCell(date: date,
                         isSelected: Calendar.current.isDate(date, inSameDayAs: selectedDate),
                         hasData: datesWithData.contains { Calendar.current.isDate($0, inSameDayAs: date) })
                .onTapGesture {
                    selectedDate = date
                }
            }
        }

        .padding()
    }

    private func getCurrentWeek(for date: Date) -> [Date] {
        guard let weekInterval = Calendar.current.dateInterval(of: .weekOfMonth, for: date) else { return [] }

        var dates: [Date] = []
        var current = weekInterval.start
        for _ in 0..<7 {
            dates.append(current)
            current = Calendar.current.date(byAdding: .day, value: 1, to: current)!
        }

        return dates
    }
}
