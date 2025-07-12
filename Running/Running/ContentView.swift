//
//  ContentView.swift
//  Running
//
//  Created by 류창휘 on 6/5/25.
//

import SwiftUI

import SwiftUI

struct ContentView: View {
    @StateObject private var manager = CadenceLiveManager()
    @StateObject var metronome = MetronomeManager()

    var body: some View {
        VStack(spacing: 20) {
            Text("👟 실시간 케이던스")
                .font(.title)

            Text("Cadence: \(String(format: "%.1f", manager.cadence)) spm")
                .font(.headline)

            Text("Steps: \(manager.stepCount)")
                .font(.subheadline)
            
            
            
            
            Text("🎵 목표 케이던스 메트로놈")
                .font(.title2)
            
            Stepper("목표 SPM: \(metronome.spm)", value: $metronome.spm, in: 100...240, step: 5)
            
            Button(metronome.isPlaying ? "멈추기" : "시작하기") {
                if metronome.isPlaying {
                    metronome.stop()
                } else {
                    metronome.start()
                }
            }
            .padding()
            .background(metronome.isPlaying ? .red : .green)
            .foregroundColor(.white)
            .cornerRadius(10)
        }
        .onAppear {
            manager.startCadenceUpdates()
        }
        .onDisappear {
            manager.stopUpdates()
        }
    }
}


#Preview {
    ContentView()
}
