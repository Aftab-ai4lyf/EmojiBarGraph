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
    
    @State private var yDataList: [[[EmojiChartView.BarChart]]] = []
    @State private var areaLine: [Double] = []
    
    var xDataList: [String] =  ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]
    
    let severityColors: [String: Color] = [
        "Best": Color(hex: "#A7E3A1"),
        "Mild": Color(hex: "#FFD166"),
        "Moderate": Color(hex: "#FF8C42"),
        "Severe": Color(hex: "#EF8089"),
        "Worst": Color(hex: "#E63946")
    ]
    
    @State var graphOrientation: EmojiChartView.ChartOrientation = .Horizontal
    
    @State var height: CGFloat = 300
    
    var body: some View {
        
        VStack(spacing: 8) {
              
            EmojiChartView(
                chartType: .GroupStackChart,
                yDataList: $yDataList,
                xDataList: xDataList,
                areaLinesValues: areaLine,
                graphOrientation: graphOrientation,
                showEmoji: false,
                showYValues: false,
                showLines: false,
                showAreaMark: true,
                yAxisTitle: "",
                valuesColor: .black,
                linesColor: .black,
                arealinesColor: .black.opacity(0.4),
                gradientColors: [.red.opacity(0.4), .red.opacity(0.3), .red.opacity(0.2), .red.opacity(0.1), .clear],
                progressBGColor: .clear
            ).frame(height: height)
            
            
            Button("Change Orientation") {
                
                withAnimation {
                    
                    graphOrientation = graphOrientation == .Horizontal ? .Vertical : .Horizontal
                    
                    if graphOrientation == .Horizontal {
                        
                        height = 300
                        
                    }else {
                        
                        height = 480
                        
                    }
                    
                }
                
                
            }
            
            Button("Regenerate Graph") {
                let newData = generateRandomGraphData()
                yDataList = newData.0
                areaLine = newData.1
            }
            .padding(.top, 20)
            
            
        }.padding(.horizontal)
            .onAppear {
            
            let initialData = generateRandomGraphData()
            yDataList = initialData.0
            areaLine = initialData.1
            
        }.onChange(of: areaLine) { oldValue, newValue in
            
            print("area line changed: \(areaLine)")
            
        }.onChange(of: yDataList) { oldValue, newValue in
            
            for (dayIndex, categories) in yDataList.enumerated() {
                print("📅 Day \(dayIndex + 1):")
                
                for (catIndex, items) in categories.enumerated() {
                    print("   ▸ Category \(catIndex + 1):")
                    
                    for (itemIndex, item) in items.enumerated() {
                        print("      • Item \(itemIndex + 1): \(item.title) [progress: \(item.progress), color: \(item.color)]")
                    }
                }
            }
            
        }
        
    }
    
    func generateRandomGraphData() -> ([[[EmojiChartView.BarChart]]], [Double]) {
        let days = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]
        
        let randomYValuesNew: [[[EmojiChartView.BarChart]]] = days.map { _ in
            let numCategories = Int.random(in: 1...3)
            
            return (0..<numCategories).map { _ in
                
                let numItems = Int.random(in: 0...2)
                
                return (0..<numItems).map { _ in
                    
                    let progress = Double(Int.random(in: 1...2))
                    
                    let colors = ["#A980FF", "#7FD533", "#2893D7"]
                    let types  = ["Food", "Medication", "Supplement"]
                    
                    let color = colors.randomElement()!
                    let type = types.randomElement()!
                    let title = (type == "Supplement") ? "Fish Oil" : type
                    
                    return EmojiChartView.BarChart(
                        progress: progress,
                        totalProgress: progress,
                        color: color,
                        title: title,
                        type: type
                    )
                }
            }
        }
        
            // Random Y area line values (1–5 range)
        let randomAreaLine = days.map { _ in
            
            let value = Int.random(in: 1...5)
            return Double(value)
            
        }
        
        return (randomYValuesNew, randomAreaLine)
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
