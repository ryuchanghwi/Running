//
//  CadenceLiveManager.swift
//  Running
//
//  Created by 류창휘 on 6/5/25.
//

import Foundation
import CoreMotion

class CadenceLiveManager: ObservableObject {
    private let pedometer = CMPedometer()

    @Published var cadence: Double = 0.0
    @Published var stepCount: Int = 0

    func startCadenceUpdates() {
        guard CMPedometer.isCadenceAvailable() else {
            print("Cadence not available")
            return
        }

        pedometer.startUpdates(from: Date()) { [weak self] data, error in
            guard let self = self, let data = data, error == nil else { return }

            DispatchQueue.main.async {
                self.cadence = (data.currentCadence?.doubleValue ?? 0.0) * 60
                self.stepCount = data.numberOfSteps.intValue
            }
        }
    }

    func stopUpdates() {
        pedometer.stopUpdates()
    }
    

}
