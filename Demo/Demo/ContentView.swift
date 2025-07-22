//
//  ContentView.swift
//  Demo
//
//  Created by AI4LYF on 14/07/2025.
//
//


import SwiftUI
import EmojiBarGraph

struct ContentView: View {
    
    @State var yDataList: [[[EmojiChartView.BarChart]]] = [
        
        [   // Mon
            [.init(progress: 2, totalProgress: 2, color: "#2893D7", title: "Magnesium", type: "Supplement"),
             .init(progress: 1, totalProgress: 1, color: "#2893D7", title: "Zinc", type: "Supplement")],
            
            [.init(progress: 1, totalProgress: 1, color: "#A980FF", title: "Vitamin C", type: "Medication"),
             .init(progress: 3, totalProgress: 3, color: "#A980FF", title: "Pycnogenol", type: "Medication"),
             .init(progress: 3, totalProgress: 3, color: "#A980FF", title: "Ibuprofen", type: "Medication")],
            
            [.init(progress: 2, totalProgress: 2, color: "#7FD533", title: "Broccoli", type: "Food")]
        ],
        
        [   // Tue
            [.init(progress: 1, totalProgress: 1, color: "#2893D7", title: "Magnesium", type: "Supplement"),
             .init(progress: 1, totalProgress: 1, color: "#2893D7", title: "Zinc", type: "Supplement"),
             .init(progress: 1, totalProgress: 1, color: "#2893D7", title: "Calcium", type: "Supplement")],
            
            [.init(progress: 1, totalProgress: 1, color: "#A980FF", title: "Aspirin", type: "Medication"),
             .init(progress: 1, totalProgress: 1, color: "#A980FF", title: "Vitamin D", type: "Medication")],
            
            [.init(progress: 2, totalProgress: 2, color: "#7FD533", title: "Apple", type: "Food")]
        ],
        
        [   // Wed
            [.init(progress: 1, totalProgress: 1, color: "#2893D7", title: "Fish Oil", type: "Supplement")],
            
            [.init(progress: 1, totalProgress: 1, color: "#A980FF", title: "Paracetamol", type: "Medication"),
             .init(progress: 1, totalProgress: 1, color: "#A980FF", title: "Cough Syrup", type: "Medication")],
            
            [.init(progress: 1, totalProgress: 1, color: "#7FD533", title: "Carrot", type: "Food"),
             .init(progress: 1, totalProgress: 1, color: "#7FD533", title: "Spinach", type: "Food")]
        ],
        
        [   // Thu
            [.init(progress: 1, totalProgress: 1, color: "#2893D7", title: "Omega-3", type: "Supplement"),
             .init(progress: 1, totalProgress: 1, color: "#2893D7", title: "Calcium", type: "Supplement")],
            
            [.init(progress: 8, totalProgress: 8, color: "#A980FF", title: "Metformin", type: "Medication")],
            
            [.init(progress: 1, totalProgress: 1, color: "#7FD533", title: "Tomato", type: "Food")]
        ],
        
        [   // Fri
            [.init(progress: 1, totalProgress: 1, color: "#2893D7", title: "Vitamin D", type: "Supplement"),
             .init(progress: 1, totalProgress: 1, color: "#2893D7", title: "Iron", type: "Supplement")],
            
            [.init(progress: 1, totalProgress: 1, color: "#7FD533", title: "Orange", type: "Food"),
             .init(progress: 1, totalProgress: 1, color: "#7FD533", title: "Banana", type: "Food"),
             .init(progress: 1, totalProgress: 1, color: "#7FD533", title: "Grapes", type: "Food")],
            
            [.init(progress: 1, totalProgress: 1, color: "#A980FF", title: "Lisinopril", type: "Medication")]
        ],
        
        [   // Sat
            [.init(progress: 5, totalProgress: 5, color: "#2893D7", title: "Magnesium", type: "Supplement")],
            
            [.init(progress: 1, totalProgress: 1, color: "#A980FF", title: "Amlodipine", type: "Medication"),
             .init(progress: 1, totalProgress: 1, color: "#A980FF", title: "Ibuprofen", type: "Medication")],
            
            [.init(progress: 1, totalProgress: 1, color: "#7FD533", title: "Apple", type: "Food")]
        ],
        
        [   // Sun
            [.init(progress: 1, totalProgress: 1, color: "#2893D7", title: "Zinc", type: "Supplement"),
             .init(progress: 1, totalProgress: 1, color: "#2893D7", title: "Fish Oil", type: "Supplement")],
            
            [.init(progress: 1, totalProgress: 1, color: "#A980FF", title: "Aspirin", type: "Medication")],
            
            [.init(progress: 1, totalProgress: 1, color: "#7FD533", title: "Spinach", type: "Food"),
             .init(progress: 1, totalProgress: 1, color: "#7FD533", title: "Tomato", type: "Food")]
        ]
    ]
    
    var xDataList: [String] =  ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]
    
    let severityColors: [String: Color] = [
        "Best": Color(hex: "#A7E3A1"),
        "Mild": Color(hex: "#FFD166"),
        "Moderate": Color(hex: "#FF8C42"),
        "Severe": Color(hex: "#EF8089"),
        "Worst": Color(hex: "#E63946")
    ]

    var body: some View {
        
        VStack(spacing: 8) {
            
            HStack {
                
                Text("Best")
                    .font(.system(size: 10))
                    .foregroundColor(.black)
                
                Spacer()
                
            }
            
            GeometryReader { geometry in
                
                HStack(alignment: .top, spacing: 8) {
                    
                    Rectangle()
                        .fill(
                            LinearGradient(
                                gradient: Gradient(colors: [
                                    severityColors["Best", default: .gray],
                                    severityColors["Mild", default: .gray],
                                    severityColors["Moderate", default: .gray],
                                    severityColors["Severe", default: .gray],
                                    severityColors["Worst", default: .gray]
                                ]),
                                startPoint: .top,
                                endPoint: .bottom
                            )
                        )
                        .frame(width: 12)
                        .frame(maxHeight: .infinity)
                        .cornerRadius(12)
                        .padding(.bottom, 16)
                    
                    VStack {
                        
                        ForEach(1...5, id: \.self) { level in
                            
                            if level > 1 {
                                
                                Spacer()
                                
                            }
                            
                            Text("\(level)")
                                .font(.system(size: 11))
                                .foregroundColor(.black)
                            
                        }
                        
                    }
                    .frame(maxHeight: .infinity)
                    .padding(.bottom, 16)
                    
                    EmojiChartView(chartType: .GroupStackChart, yDataList: $yDataList, xDataList: xDataList, showEmoji: false, showYValues: false, showLines: true, showAreaMark: true)
                    
                }
                
            }.frame(height: 300)
                .padding(.leading, 6)
            
            HStack {
                
                Text("Worst")
                    .font(.system(size: 10))
                    .foregroundColor(.black)
                
                Spacer()
                
            }.offset(y: -15)
            
        }
    }
    
}



#Preview {
    ContentView()
}


extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
            case 3: // RGB (12-bit)
                (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
            case 6: // RGB (24-bit)
                (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
            case 8: // ARGB (32-bit)
                (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
            default:
                (a, r, g, b) = (1, 1, 1, 0)
        }
        
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}
