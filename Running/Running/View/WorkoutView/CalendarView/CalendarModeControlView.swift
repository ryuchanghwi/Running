//
//  CalendarModeControlView.swift
//  Running
//
//  Created by 류창휘 on 7/13/25.
//

import SwiftUI

struct CalendarModeControlView: View {
    @Binding var viewMode: CalendarViewMode

    var body: some View {
        HStack(alignment: .center, spacing: 0) {
            Image(viewMode == .month ? "chevron.compact.up" : "chevron.compact.down")
                .onTapGesture {
                    withAnimation {
                        if viewMode == .month {
                            viewMode = .week
                            return
                        }
                        viewMode = .month
                    }
                }
                .padding(.bottom, 13)
        }
    }
}

#Preview {
    CalendarModeControlView(viewMode: .constant(.month))
}
