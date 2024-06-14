//
//  ContentView.swift
//  clock
//
//  Created by Scholar on 6/7/24.
//iyb
import SwiftUI

struct ContentView: View {
    @State private var duration = "---"
    private let desiredDuration = Calendar.current.date(byAdding: .minute, value: 25, to: Date())!
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    static var duratioinFormatter: DateComponentsFormatter = {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute, .second]
        formatter.unitsStyle = .abbreviated
        formatter.zeroFormattingBehavior = .dropLeading
        return formatter
    }()
    
    var body: some View {
        VStack {
            HStack(spacing: 12) {
                Spacer()
                Text(duration)
                    .font(.system(size: 18, weight: .bold))
                    .padding()
                    .foregroundStyle(Color.black)
                    .background(Color.green)
                    .opacity(0.3)
                    .cornerRadius(15)
                Spacer()
            }
        }
        .frame(width: 300, height: 34)
        .onReceive(timer) { _ in
            var delta = desiredDuration.timeIntervalSince(Date())
            if delta <= 0 {
                delta = 0
                timer.upstream.connect().cancel()
            }
            duration = ContentView.duratioinFormatter.string(from: delta) ?? "---"
        }
    }
}

#Preview {
    ContentView()
}
