//
//  ProgressLine.swift
//  PizzaApp
//
//  Created by Виталий Багаутдинов on 31.01.2026.
//

import SwiftUI
import UIKit

struct ProgressLine: View {
    let currentStep: Int
    let totalSteps: Int
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Шаг \(self.currentStep) из \(self.totalSteps)")
                .font(.system(size: 12, weight: .medium))
                .foregroundColor(.primary)
                .padding(.horizontal)
            
            GeometryReader { geo in
                ZStack(alignment: .leading) {
                    Capsule()
                        .fill(Color.gray.opacity(0.3))
                        .frame(height: 6)
                    Capsule()
                        .fill(Color.green)
                        .frame(width: geo.size.width * self.progress, height: 6)
                }
            }
            .frame(height: 6)
        }
    }
}

private extension ProgressLine {
    private var progress: CGFloat {
        guard totalSteps > 0 else { return 0 }
        let value = CGFloat(currentStep) / CGFloat(totalSteps)
        return min(max(value, 0), 1)
    }
}
