//
//  EmojiGroupBarChart.swift
//
//
//  Created by ai4lyf on 16/05/2024.
//


import Foundation
import SwiftUI
import Charts

@available(iOS 17.0, *)
extension Int {
    func formatUsingAbbreviation() -> String {
        let num = abs(Double(self))
        let sign = (self < 0) ? "-" : ""
        
        switch num {
        case 1_000_000_000...:
            let formatted = num / 1_000_000_000
            return "\(sign)\(formatted.rounded(toPlaces: 1))B"
        case 1_000_000...:
            let formatted = num / 1_000_000
            return "\(sign)\(formatted.rounded(toPlaces: 1))M"
        case 1_000...:
            let formatted = num / 1_000
            return "\(sign)\(formatted.rounded(toPlaces: 1))K"
        case 0...:
            return "\(self)"
            
        default:
            return "\(sign)\(self)"
        }
    }
}

@available(iOS 17.0, *)
extension Double {
    func rounded(toPlaces places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}

@available(iOS 17.0, *)
public struct EmojiGroupBarChart: View {
    
    @Binding var yValues: [[EmojiChartView.BarChart]]
    var xValues: [String]
    var showEmoji: Bool
    var tempYValues: [[Int]] = [[0,0],[0,0],[0,0],[0,0]]
    @State var tempMaxYValues: [[Int]] = [[0,0],[0,0],[0,0],[0,0]]
    var tempXValues: [String] = ["15m","30m","45m","60m"]
    
    @State var dataSet: [String] = []
    
    var valuesColor: Color = .black
    var linesColor: Color = .black.opacity(0.50)
    
    var progressBGColor = Color.gray.opacity(0.40)
    
    var fontName = ""
    
    var yAxisTitle: String?
    var yAxisTitleSize = 12
    var yAxisValuesSize = 12
    
    var showYValues: Bool
    var showLines: Bool
    var emojiHeight = 8
    var emojiWidth = 8
    
    var showAreaMark: Bool
    
    var arealinesColor: Color
    var gradientColors: [Color]
    
    var showDecimalValues = true
    
    @State var textWidth: CGFloat = .zero
    @State var totalYValues = 0
    
    @State var heightDivider: Double = 0
    @State var lastValue: Double = 0
    
    @State var mainMaxValue = 4
    @State var updateGraph = 1
    
    @State var isError = false
    @State var errorMessage = ""
    
    @State var isDataLoaded = false
    
    @State var showTooltip = false
    @State var tooltipJIndex = 0
    @State var tooltipIIndex = 0
    
    @State var xOffset: CGFloat = .zero
    @State var yOffset: CGFloat = .zero
    
    @State private var tooltipPosition: CGPoint = .zero
    
    @State var hadTitle = false
    
    @State var isAbbreviated = false
    
    @State var progressBarWidth = 8
    @State var progressSpacing = 4.0
    
    @State var leadingGraphSpacing = 16.0
    
    @State var heightPlus = 16.0
    @State var selectedUUID = UUID()
    
    @State var totalLines = 6
    
    @State var totalHeight: CGFloat = 300
    
    @State var innerLinesHeight: Int = 60
    @State var bottomPadding: Double = 30.0
    
    @State var firstDataSetValue:Int = 0
    @State var lastDataSetValue:Int = 0
    
    public var body: some View {
        GeometryReader { geo in
            
            ZStack(alignment: .bottom) {
                
                yAxisView()
                    .padding(.leading, hadTitle ? 8 : 0)
                    .overlay {
                        
                        yAxisTextWidthOverlay()
                        
                    }.overlay(alignment: .bottom) {
                        
                        barsView()
                        
                    }.overlay {
                        
                        GeometryReader { geo in
                            
                            areaMarkView()
                                .frame(width: geo.size.width - 48)
                                .frame(height: geo.size.height - CGFloat(innerLinesHeight + 2))
                                .padding(.top, CGFloat((innerLinesHeight / 2)))
                                .offset(x: 48)
                                .onAppear{
                                    
                                    print("height: \(geo.size.height), height divider: \(heightDivider)")
                                    
                                }.onChange(of: geo.size.height) { oldValue, newValue in
                                    
                                    print("on change height: \(geo.size.height), height divider: \(heightDivider)")
                                    
                                }
                            
                        }
                        
                    }
                
            }.padding()
                .onChange(of: yValues) { oldValue, newValue in
                    
                    validate()
                    
                }.onAppear {
                    
                    totalHeight = geo.size.height
                    
                    print("Total height: \(totalHeight)")
                    
                    validate()
                    
                }.onTapGesture {
                    
                    showTooltip = false
                    
                }
            
        }
        
    }
    
    // MARK: - Y-Axis View
    
    @ViewBuilder
    private func yAxisView() -> some View {
       
        VStack(spacing: 0) {
          
            HStack(spacing: 0) {
                
                if let title = yAxisTitle, title != "" {
                    
                    Text(title)
                        .font(.custom(fontName, size: CGFloat(yAxisTitleSize)))
                        .rotationEffect(Angle(degrees: 270))
                        .foregroundColor(valuesColor)
                        .fixedSize()
                        .frame(width: 20, height: 0)
                        .onTapGesture {
                            
                            let i = yValues[1][1].totalProgress
                            yValues[1][1].totalProgress = i + 1
                            
                        }.onAppear {
                            
                            hadTitle = true
                            
                        }
                }
                
                VStack(spacing: 0) {
                    
                    ForEach((0..<dataSet.count).reversed(), id: \.self) { i in
                        
                        HStack(spacing: 4) {
                            
                            if showYValues {
                                
                                Text(removeTrailingZero(from: dataSet[i]))
                                    .font(.custom(fontName, size: CGFloat(yAxisTitleSize)))
                                    .foregroundColor(valuesColor)
                                    .frame(width: textWidth, height: CGFloat(innerLinesHeight), alignment: .trailing)
                                    .opacity(i == 0 ? 0 : 1)
                                
                            } else {
                                
                                Spacer()
                                    .frame(width: 0, height: CGFloat(innerLinesHeight))
                                
                            }
                            
                            Line()
                                .stroke(style: StrokeStyle(lineWidth: 0.5, dash: [2]))
                                .frame(height: 0.5)
                                .foregroundColor(linesColor)
                                .opacity(showLines ? 1 : 0)
                            
                        }
                        
                    }
                    
                }
                
            }
       
        }
        
    }
    
    // MARK: - Y-Axis Text Width Overlay
    
    @ViewBuilder
    private func yAxisTextWidthOverlay() -> some View {
        
        Text(String(format: "%.1f", lastValue))
            .opacity(0)
            .font(.custom(fontName, size: CGFloat(yAxisTitleSize)))
            .background {
            
                GeometryReader { geo in
                
                    Color.clear
                        .onAppear {
                     
                            textWidth = CGFloat(geo.size.width)
                      
                            if isAbbreviated {
                      
                                textWidth -= 10
                       
                            }
                       
                        }
                    
                }
                
            }.id(lastValue)
        
    }
    
    // MARK: - Bars View
    
    @ViewBuilder
    private func barsView() -> some View {
        
        if !isError {
         
            HStack(alignment: .bottom, spacing: 0) {
                
                var lastXValue = ""
                
                ForEach(0..<yValues.count, id: \.self) { i in
                    
                    let yValue = yValues[i]
                    let xValue = xValues[i]
                    
                    Spacer()
                    
                    VStack(spacing: 0) {
                        
                        HStack(alignment: .bottom, spacing: CGFloat(progressSpacing)) {
                            
                            ForEach(0..<yValue.count, id: \.self) { j in
                                
                                let maxValue = yValue[j].totalProgress
                                let progress = yValue[j].progress
                                
                                let height = Double(Double(innerLinesHeight) * max(progress, maxValue))
                             
                                let progressColor = yValue[j].color
                              
                                let emoji = yValue[j].emoji
                                let title = yValue[j].title
                                let uuid = yValue[j].id
                                
                                if maxValue > 0 {
                                    
                                    GeometryReader { geometry in
                                        
                                        VStack {
                                            
                                            Spacer()
                                            
                                            VerticalProgressBar(
                                                progress: Double(progress) / Double(maxValue),
                                                totalProgress: maxValue,
                                                width: CGFloat(progressBarWidth),
                                                height: height / heightDivider,
                                                progressColor: progressColor,
                                                progressBGColor: progressBGColor,
                                                j: j,
                                                i: i,
                                                minValue: progress,
                                                maxValue: maxValue,
                                                xValue: xValue,
                                                title: title,
                                                fontName: fontName,
                                                id: uuid,
                                                showDecimalValues: showDecimalValues,
                                                tooltipJIndex: $tooltipJIndex,
                                                tooltipIIndex: $tooltipIIndex,
                                                showToolTip: $showTooltip,
                                                totalYValues: $totalYValues,
                                                selectedUUID: $selectedUUID
                                            ).overlay(alignment: .top) {
                                                
                                                if showEmoji {
                                                    
                                                    Image(emoji)
                                                        .resizable()
                                                        .frame(width: CGFloat(emojiWidth), height: CGFloat(emojiHeight))
                                                        .padding(.top, -10)
                                                    
                                                }
                                                
                                            }.onTapGesture {
                                                
                                                withAnimation {
                                                    
                                                    tooltipJIndex = j
                                                    tooltipIIndex = i
                                                    
                                                    if selectedUUID == uuid {
                                                        
                                                        showTooltip.toggle()
                                                        
                                                    } else {
                                                        
                                                        showTooltip = true
                                                        
                                                    }
                                                    
                                                    selectedUUID = uuid
                                                    
                                                }
                                                
                                            }
                                            
                                        }
                                        
                                    }.frame(width: 8, height: height / heightDivider + heightPlus)
                                        .zIndex(Double(-j))
                                    
                                }
                                
                            }
                            
                        }.padding(.bottom, 8)
                        
                        if lastXValue != xValue {
                            
                            Text("\n\n" + xValue)
                                .font(.custom(fontName, size: 8))
                                .foregroundColor(valuesColor)
                                .padding(.bottom, -4)
                                .onAppear {
                                    
                                    lastXValue = xValue
                                    
                                }
                            
                        }
                        
                    }
                    
                }.id(updateGraph)
                
            }.padding(.leading, CGFloat(leadingGraphSpacing))
            .id(updateGraph)
            
        } else {
           
            HStack(alignment: .bottom, spacing: 0) {
             
                var lastXValue = ""
             
                ForEach(0..<tempYValues.count, id: \.self) { i in
              
                    let xValue = tempXValues[i]
               
                    Spacer()
                 
                    VStack(spacing: 0) {
                   
                        if lastXValue != xValue {
                        
                            Text("\n\n" + xValue)
                                .font(.custom(fontName, size: 8))
                                .padding(.bottom, -4)
                                .onAppear {
                                    
                                    lastXValue = xValue
                                    
                                }
                            
                        }
                        
                    }
                    
                }
                
            }.padding(.leading, showYValues ? 8 : 0)
            .id(mainMaxValue)
            .onAppear {
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    
                    mainMaxValue = 12
                    
                }
                
                dataSet = ["0", "2", "4", "6", "8", "10", "12"]
                
            }

        }

    }
    
    // MARK: - Area Mark View
    
    @ViewBuilder
    private func areaMarkView() -> some View {
        
        let newYValues1 = yValues.flatMap { innerArray in
        
            innerArray.map { bar in
                bar.totalProgress > 0 ? bar.totalProgress + 0.5 : 0
         
            }
            
        }
        
        let newYValues2 = yValues.map { dayArray in
            let total = dayArray.map { bar in
                bar.totalProgress > 0 ? bar.totalProgress + 1 : 0
            }.reduce(0, +)
            
            return min(total, Double(mainMaxValue))
        }
        
        let newYValues = newYValues2
        
        let repeatedXValues = xValues.flatMap { day in
            Array(repeating: day, count: 2) // Because each day has 2 bars/points
        }
        
        if showAreaMark && !isError {
            
            Chart {
                
                ForEach(0..<newYValues.count, id: \.self) { i in
                    
                    let progress = newYValues[i]
                    
                    AreaMark(
                        x: .value("Day", i),
                        y: .value("Line", progress)
                    )
                    .interpolationMethod(.catmullRom)
                    .foregroundStyle(
                        .linearGradient(
                            colors: gradientColors,
                            startPoint: .top,
                            endPoint: .bottom
                        )
                    )
                    
                    LineMark(
                        x: .value("Day", i),
                        y: .value("Line", progress)
                    )
                    .interpolationMethod(.catmullRom)
                    .foregroundStyle(arealinesColor)
                    
                }
                 
            }.chartYScale(domain: firstDataSetValue...lastDataSetValue)
                .chartPlotStyle { plot in
                    
                    plot.background(.clear)
                    
                }.chartXAxis(.hidden)
                .chartYAxis(.hidden)
                .background(.clear)
//                .padding(.leading, showYValues ? textWidth + 40 : 40)
                .onAppear{
                    
                    print("new y values: \(newYValues), firstDataSetValue: \(firstDataSetValue), lastDataSetValue: \(lastDataSetValue)")
                    
                }
            
        }
        
    }
    
    func validate() {
        
        withAnimation {
            
            isDataLoaded = false
            
        }
        
        let xValuesCount = xValues.count
        let yValuesCount = yValues.count
        
        if xValuesCount != yValuesCount {
            
            withAnimation {
                
                isError = true
                errorMessage = "X and Y values had different size"
                
            }
            
        } else if xValuesCount == yValuesCount {
            
            if !isError {
                
                findMaxValue()
                
            }

        }
        
    }
    
    func findMaxValue() {
       
        if let title = yAxisTitle {
        
            if title != "" {
                
                hadTitle = true
                
            } else {
                
                hadTitle = false
                
            }
            
        }else {
            
            hadTitle = false
            
        }
        
        let maxValues1 = yValues.flatMap { $0.map { $0.totalProgress } }.max() ?? 0
        let maxValues2 = yValues.flatMap { $0.map { $0.progress } }.max() ?? 0
        
        yValues.forEach { barChartArray in
        
            let arrayCount = barChartArray.count
            
            if arrayCount == 4 {
                
                progressBarWidth = 6
                progressSpacing = 0.5
                
            } else if arrayCount == 3 {
                
                progressBarWidth = 6
                progressSpacing = 2
                
            } else {
                
                progressBarWidth = 8
                progressSpacing = 4
                
            }
            
        }
        
        let xArrayCount = xValues.count
        
        if xArrayCount >= 6 && hadTitle {
            
            leadingGraphSpacing = 40
            
        } else if xArrayCount == 4 && hadTitle {
            
            leadingGraphSpacing = 26
            
        } else {
            
            leadingGraphSpacing = 16
            
        }
        
        var maxValues = 0.0
        
        if maxValues1 > maxValues2 {
            
            maxValues = maxValues1
            
        } else {
            
            maxValues = maxValues2
            
        }
        
        innerLinesHeight = Int(totalHeight - 40) / totalLines
        
        bottomPadding = 0.5 * Double(innerLinesHeight) - 36
        
        
        print("Max Value: \(maxValues), Max Value 1: \(maxValues1), Max Value 2: \(maxValues2), Bottom Padding: \(bottomPadding), innerLinesHeight: \(innerLinesHeight), totalHeight: \(totalHeight)")
        
        
        withAnimation {
        
            if maxValues >= 6 {
                
                mainMaxValue = Int(maxValues)
                
            } else if maxValues > 3 && maxValues < 6 {
                
                mainMaxValue = Int(maxValues)
                
            } else {
                
                mainMaxValue = 3
                
            }
            
        }
        
        dataSet = generateArray1(forX: mainMaxValue)
        
        
       
        var lastValueString = dataSet[dataSet.count - 1]
        
        if lastValueString.contains("K") {
            
            lastValueString = lastValueString.replacingOccurrences(of: "K", with: "")
            lastValue = Double(lastValueString) ?? 0.0
            lastValue *= 1000
            isAbbreviated = true
            
        } else if lastValueString.contains("M") {
            
            lastValueString = lastValueString.replacingOccurrences(of: "M", with: "")
            lastValue = Double(lastValueString) ?? 0.0
            lastValue *= 100000
            isAbbreviated = true
            
        } else if lastValueString.contains("B") {
            
            lastValueString = lastValueString.replacingOccurrences(of: "B", with: "")
            lastValue = Double(lastValueString) ?? 0.0
            lastValue *= 1000000000
            isAbbreviated = true
            
        } else {
            
            lastValue = Double(lastValueString) ?? 0.0
            isAbbreviated = false
            
        }
        
        let firstValue = dataSet[0].replacingOccurrences(of: "K", with: "").replacingOccurrences(of: "M", with: "").replacingOccurrences(of: "B", with: "")
        let lastValueNew = lastValueString.replacingOccurrences(of: "K", with: "").replacingOccurrences(of: "M", with: "").replacingOccurrences(of: "B", with: "")
        
        firstDataSetValue = Int(Double(firstValue) ?? 0.0)
        lastDataSetValue = Int(lastValue)
        
        print("FirstDataSetValue: \(firstDataSetValue), LastDataSetValue: \(lastDataSetValue)")
        
        
        self.mainMaxValue = Int(lastValue)
        
        isDataLoaded = true
        updateGraph += 1
        
    }
    
    func generateArray1(forX x: Int) -> [String] {
   
        let xValue = x
   
        var array = [Double](repeating: 1, count: 7)
    
        var stringArray: [String] = []
        let valueToAdd = (x - 1) / 5
     
        if xValue == 3 {
       
            stringArray.removeAll()
       
            let parts = 6
            heightPlus = 14
            heightDivider = Double(0.5)
            
            let step = Double(xValue) / Double(parts)
            
            for i in 0...parts {
            
                let value = step * Double(i)
                
                if showDecimalValues {
                    
                    stringArray.append(String(format: "%.1f", value))
                    
                } else {
                    
                    stringArray.append(String(format: "%.0f", value))
                    
                }
                
            }
            
        } else if xValue > 3 && xValue < 6 {
            
            stringArray.removeAll()
            
            let parts = 6
            let step = Double(xValue) / Double(parts)
            
            heightPlus = 16
            
            if xValue == 4 {
                
                heightDivider = 0.673
                
            } else if xValue == 5 {
                
                heightDivider = 0.842
                
            }
            
            for i in 0...parts {
            
                let value = step * Double(i)
                
                if showDecimalValues {
                    
                    stringArray.append(String(format: "%.1f", value))
                    
                } else {
                    
                    stringArray.append(String(format: "%.0f", value))
                    
                }
                
            }
            
        } else {
            
            heightPlus = 16
            heightDivider = Double(valueToAdd + 1)
            
            for i in 0..<array.count {
                
                var oldValue = array[i]
                
                if i > 0 {
                    
                    oldValue = array[i-1]
                    oldValue += Double(valueToAdd)
                    array[i] += oldValue
                    let newValue = array[i]
                    var newString = ""
                    let num = abs(Double(newValue))
                    let sign = (newValue < 0) ? "-" : ""
                    
                    switch num {
                        case 1_000_000_000...:
                            let formatted = num / 1_000_000_000
                            newString = "\(sign)\(formatted.rounded(toPlaces: 1))B"
                        case 1_000_000...:
                            let formatted = num / 1_000_000
                            newString = "\(sign)\(formatted.rounded(toPlaces: 1))M"
                        case 1_000...:
                            let formatted = num / 1_000
                            newString = "\(sign)\(formatted.rounded(toPlaces: 1))K"
                        case 0...:
                            if showDecimalValues {
                                newString = String(format: "%.1f", newValue)
                            } else {
                                newString = String(format: "%.0f", newValue)
                            }
                        default:
                            newString = "\(sign)\(newValue)"
                    }
                    
                    stringArray.append(newString)
                    
                } else {
                    
                    array[i] = 0
                    stringArray.append("0")
                    
                }
                
            }
            
        }
        
        let newArray = convertToKFormat(stringArray)
        return newArray
    }
    
    func convertToKFormat(_ array: [String]) -> [String] {
      
        let containsK = array.contains { $0.contains("K") }
       
        if containsK {
        
            return array.map { value in
            
                if let number = Double(value.replacingOccurrences(of: "K", with: "")) {
                    
                    return value.contains("K") ? value : String(format: "%.1fK", number / 1000)
                    
                } else {
                    
                    return value
                    
                }
                
            }
            
        } else {
            
            return array
            
        }
        
    }
    
    func removeTrailingZero(from numberString: String) -> String {
    
        if numberString.hasSuffix(".0") {
            
            return String(numberString.dropLast(2))
            
        }
        
        return numberString
        
    }
    
}

    
@available(iOS 17.0, *)
struct Line: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: rect.width, y: 0))
        return path
    }
}

@available(iOS 17.0, *)
struct VerticalProgressBar: View {
    var progress: Double
    var totalProgress: Double
    var width: Double
    var height: Double
    var progressColor: String
    var progressBGColor: Color
    var j: Int
    var i: Int
    var minValue: Double
    var maxValue: Double
    var xValue: String
    var title: String
    var fontName: String
    var id: UUID
    var showDecimalValues: Bool
    @Binding var tooltipJIndex: Int
    @Binding var tooltipIIndex: Int
    @Binding var showToolTip: Bool
    @Binding var totalYValues: Int
    @Binding var selectedUUID: UUID
    
    @State var paddingTrailing = CGFloat(0)
    
    var body: some View {
        VStack {
          
            ZStack(alignment: .bottom) {
                
                Capsule()
                    .frame(width: width, height: height)
                    .foregroundColor(progressBGColor)
                
                Capsule()
                    .frame(width: width, height: CGFloat(progress) * height)
                    .foregroundColor(Color(hex: progressColor))
                
            }.tooltip(alignment: .top, visible: $showToolTip, paddingTrailing: $paddingTrailing, backgroundColor: .white) {
             
                if id == selectedUUID {
                
                    VStack(alignment: .leading, spacing: 4) {
                    
                        if title != "" {
                            
                            Text("\(title)")
                                .font(.custom(fontName, size: 11))
                                .fontWeight(.semibold)
                                .foregroundColor(Color(hex: progressColor))
                            
                        }
                        
                        HStack {
                            
                            Text("Taken:")
                                .font(.custom(fontName, size: 11))
                                .foregroundColor(.black.opacity(0.50))
                            
                            Text(String(format: showDecimalValues ? "%.1f" : "%.0f", minValue))
                                .font(.custom(fontName, size: 11))
                                .fontWeight(.semibold)
                                .foregroundColor(Color(hex: progressColor))
                            
                        }
                        
                        HStack {
                            
                            Text("Total:")
                                .font(.custom(fontName, size: 11))
                                .foregroundColor(.black.opacity(0.50))
                            
                            Text(String(format: showDecimalValues ? "%.1f" : "%.0f", totalProgress))
                                .font(.custom(fontName, size: 11))
                                .fontWeight(.semibold)
                                .foregroundColor(.black)
                            
                        }
                        
                        HStack {
                            
                            Text("Timeline:")
                                .font(.custom(fontName, size: 11))
                                .foregroundColor(.black.opacity(0.50))
                            
                            Text("\(xValue)")
                                .font(.custom(fontName, size: 11))
                                .fontWeight(.semibold)
                                .foregroundColor(.black)
                            
                        }
                        
                    }.frame(width: 95)
                    .padding(.vertical, 4)
                    .onAppear {
                     
                        if i == totalYValues - 1 {
                            
                            paddingTrailing = CGFloat(80)
                            
                        } else {
                            
                            paddingTrailing = CGFloat(0)
                            
                        }
                        
                    }
                    
                }
                
            }
            
        }
        
    }
    
}

@available(iOS 17.0, *)
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
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}

@available(iOS 17.0, *)
extension EmojiGroupBarChart {
    func setYAxisTitle(_ title: String) -> EmojiGroupBarChart {
        EmojiGroupBarChart(
            yValues: $yValues,
            xValues: xValues,
            showEmoji: showEmoji,
            yAxisTitle: title,
            showYValues: showYValues,
            showLines: showLines,
            showAreaMark: showAreaMark,
            arealinesColor: arealinesColor,
            gradientColors: gradientColors
        )
    }
    
    func setValuesColor(_ color: Color) -> EmojiGroupBarChart {
        EmojiGroupBarChart(
            yValues: $yValues,
            xValues: xValues,
            showEmoji: showEmoji,
            valuesColor: color,
            yAxisTitle: yAxisTitle,
            showYValues: showYValues,
            showLines: showLines,
            showAreaMark: showAreaMark,
            arealinesColor: arealinesColor,
            gradientColors: gradientColors
        )
    }
    
    func setLinesColor(_ color: Color) -> EmojiGroupBarChart {
        EmojiGroupBarChart(
            yValues: $yValues,
            xValues: xValues,
            showEmoji: showEmoji,
            valuesColor: valuesColor,
            linesColor: color,
            yAxisTitle: yAxisTitle,
            showYValues: showYValues,
            showLines: showLines,
            showAreaMark: showAreaMark,
            arealinesColor: arealinesColor,
            gradientColors: gradientColors
        )
    }
    
    func setBarBackgroundColor(_ color: Color) -> EmojiGroupBarChart {
        EmojiGroupBarChart(
            yValues: $yValues,
            xValues: xValues,
            showEmoji: showEmoji,
            valuesColor: valuesColor,
            linesColor: linesColor,
            progressBGColor: color,
            yAxisTitle: yAxisTitle,
            showYValues: showYValues,
            showLines: showLines,
            showAreaMark: showAreaMark,
            arealinesColor: arealinesColor,
            gradientColors: gradientColors
        )
    }
    
    func setFontName(_ name: String) -> EmojiGroupBarChart {
        EmojiGroupBarChart(
            yValues: $yValues,
            xValues: xValues,
            showEmoji: showEmoji,
            valuesColor: valuesColor,
            linesColor: linesColor,
            progressBGColor: progressBGColor,
            fontName: name,
            yAxisTitle: yAxisTitle,
            showYValues: showYValues,
            showLines: showLines,
            showAreaMark: showAreaMark,
            arealinesColor: arealinesColor,
            gradientColors: gradientColors
        )
    }
    
    func setYAxisTitleSize(_ size: Int) -> EmojiGroupBarChart {
        EmojiGroupBarChart(
            yValues: $yValues,
            xValues: xValues,
            showEmoji: showEmoji,
            valuesColor: valuesColor,
            linesColor: linesColor,
            progressBGColor: progressBGColor,
            fontName: fontName,
            yAxisTitle: yAxisTitle,
            yAxisTitleSize: size,
            showYValues: showYValues,
            showLines: showLines,
            showAreaMark: showAreaMark,
            arealinesColor: arealinesColor,
            gradientColors: gradientColors
        )
    }
    
    func setYAxisValuesSize(_ size: Int) -> EmojiGroupBarChart {
        EmojiGroupBarChart(
            yValues: $yValues,
            xValues: xValues,
            showEmoji: showEmoji,
            valuesColor: valuesColor,
            linesColor: linesColor,
            progressBGColor: progressBGColor,
            fontName: fontName,
            yAxisTitle: yAxisTitle,
            yAxisTitleSize: yAxisTitleSize,
            yAxisValuesSize: size,
            showYValues: showYValues,
            showLines: showLines,
            showAreaMark: showAreaMark,
            arealinesColor: arealinesColor,
            gradientColors: gradientColors
        )
    }
    
    func setEmojiHeight(_ size: Int) -> EmojiGroupBarChart {
        EmojiGroupBarChart(
            yValues: $yValues,
            xValues: xValues,
            showEmoji: showEmoji,
            valuesColor: valuesColor,
            linesColor: linesColor,
            progressBGColor: progressBGColor,
            fontName: fontName,
            yAxisTitle: yAxisTitle,
            yAxisTitleSize: yAxisTitleSize,
            yAxisValuesSize: yAxisValuesSize,
            showYValues: showYValues,
            showLines: showLines,
            emojiHeight: size,
            showAreaMark: showAreaMark,
            arealinesColor: arealinesColor,
            gradientColors: gradientColors
        )
    }
    
    func setEmojiWidth(_ size: Int) -> EmojiGroupBarChart {
        EmojiGroupBarChart(
            yValues: $yValues,
            xValues: xValues,
            showEmoji: showEmoji,
            valuesColor: valuesColor,
            linesColor: linesColor,
            progressBGColor: progressBGColor,
            fontName: fontName,
            yAxisTitle: yAxisTitle,
            yAxisTitleSize: yAxisTitleSize,
            yAxisValuesSize: yAxisValuesSize,
            showYValues: showYValues,
            showLines: showLines,
            emojiHeight: emojiHeight,
            emojiWidth: size,
            showAreaMark: showAreaMark,
            arealinesColor: arealinesColor,
            gradientColors: gradientColors
        )
    }
    
    func showLine(_ show: Bool) -> EmojiGroupBarChart {
        EmojiGroupBarChart(
            yValues: $yValues,
            xValues: xValues,
            showEmoji: showEmoji,
            valuesColor: valuesColor,
            linesColor: linesColor,
            showYValues: showYValues,
            showLines: show,
            showAreaMark: showAreaMark,
            arealinesColor: arealinesColor,
            gradientColors: gradientColors
        )
    }
    
    func showYValue(_ show: Bool) -> EmojiGroupBarChart {
        EmojiGroupBarChart(
            yValues: $yValues,
            xValues: xValues,
            showEmoji: showEmoji,
            valuesColor: valuesColor,
            linesColor: linesColor,
            showYValues: show,
            showLines: showLines,
            showAreaMark: showAreaMark,
            arealinesColor: arealinesColor,
            gradientColors: gradientColors
        )
    }
}

@available(iOS 17.0, *)
extension View {
    func tooltip(alignment: Edge, visible: Binding<Bool>, paddingTrailing: Binding<CGFloat> = .constant(CGFloat(0)), backgroundColor: Color = .white, @ViewBuilder tooltip: @escaping () -> some View) -> some View {
        modifier(TooltipDisplayingModifier(alignment: alignment, visible: visible, paddingTrailing: paddingTrailing, backgroundColor: backgroundColor, tooltip: tooltip))
    }
}

@available(iOS 17.0, *)
private struct TooltipDisplayingModifier<Tooltip: View>: ViewModifier {
    private let alignment: Edge
    private let backgroundColor: Color
    @ViewBuilder private let tooltip: () -> Tooltip
    @Binding private var visible: Bool
    @Binding var paddingTrailing: CGFloat
    
    init(alignment: Edge, visible: Binding<Bool>, paddingTrailing: Binding<CGFloat>, backgroundColor: Color = .white, @ViewBuilder tooltip: @escaping () -> Tooltip) {
        self.alignment = alignment
        self.backgroundColor = backgroundColor
        self.tooltip = tooltip
        _visible = visible
        _paddingTrailing = paddingTrailing
    }
    
    func body(content: Content) -> some View {
        TooltipPopup(content: content, alignment: alignment, visible: $visible, paddingTrailing: $paddingTrailing, backgroundColor: backgroundColor, tooltip: tooltip)
    }
}

@available(iOS 17.0, *)
struct ChildSizeReader<Content: View>: View {
    var body: some View {
        content()
            .background(GeometryReader {
                Color.clear.preference(key: SizePreferenceKey.self, value: $0.size)
            })
            .onPreferenceChange(SizePreferenceKey.self) { size = $0 }
    }
    
    private let content: () -> Content
    @Binding private var size: CGSize
    
    init(size: Binding<CGSize>, content: @escaping () -> Content) {
        self.content = content
        _size = size
    }
}

@available(iOS 17.0, *)
private struct SizePreferenceKey: PreferenceKey {
    static var defaultValue: CGSize = .zero
    static func reduce(value _: inout Value, nextValue: () -> Value) { }
}

@available(iOS 17.0, *)
private struct TooltipPopup<Content: View, Tooltip: View>: View {
    var body: some View {
        ChildSizeReader(size: $contentSize) {
            content
        }
        .overlay {
            hint
                .drawingGroup()
                .frame(maxWidth: .infinity)
                .opacity(visible ? 1.0 : .zero)
                .animation(.bouncy, value: visible)
                .shadow(radius: 5)
                .offset(x: (alignment == .leading) ? (-hintSize.width / 2.0) - (contentSize.width / 2.0) : .zero)
                .offset(x: (alignment == .trailing) ? (hintSize.width / 2.0) + (contentSize.width / 2.0) : .zero)
                .offset(y: (alignment == .top) ? (-hintSize.height / 2.0) - (contentSize.height / 2.0) : .zero)
                .offset(y: (alignment == .bottom) ? (hintSize.height / 2.0) + (contentSize.height / 2.0) : .zero)
                .padding(.trailing, paddingTrailing)
        }
    }
    
    private let alignment: Edge
    private let backgroundColor: Color
    private let content: Content
    @ViewBuilder private let tooltip: () -> Tooltip
    @State private var contentSize = CGSize.zero
    private var hint: some View {
        ChildSizeReader(size: $hintSize) {
            tooltip()
                .background(backgroundColor)
                .cornerRadius(4)
        }
    }
    @State private var hintSize = CGSize.zero
    private var oppositeAlignment: Alignment {
        switch alignment {
        case .top:
            .bottom
        case .bottom:
            .top
        case .leading:
            .trailing
        case .trailing:
            .leading
        }
    }
    @Binding private var visible: Bool
    @Binding var paddingTrailing: CGFloat
    
    init(content: Content, alignment: Edge, visible: Binding<Bool>, paddingTrailing: Binding<CGFloat>, backgroundColor: Color = .white, @ViewBuilder tooltip: @escaping () -> Tooltip) {
        self.content = content
        self.alignment = alignment
        self.backgroundColor = backgroundColor
        self.tooltip = tooltip
        _visible = visible
        _paddingTrailing = paddingTrailing
    }
}

@available(iOS 17.0, *)
#Preview {
    
    @Previewable @State var yValues:[[EmojiChartView.BarChart]] = [[.init(progress: 1,totalProgress: 1,color: "#FA6418"),.init(progress: 3,totalProgress: 4,color: "#BD013C",emoji: "love")],
                                                                   [.init(progress: 4,totalProgress: 4,color: "#FA6418"),.init(progress: 2,totalProgress: 2,color: "#BD013C",emoji: "love")],
                                                                   [.init(progress: 1,totalProgress: 1,color: "#FA6418"),.init(progress: 1,totalProgress: 4,color: "#BD013C",emoji: "love")],
                                                                   [.init(progress: 1,totalProgress: 3,color: "#FA6418"),.init(progress: 1,totalProgress: 1,color: "#BD013C",emoji: "love")],
                                                                   [.init(progress: 1,totalProgress: 1,color: "#FA6418"),.init(progress: 1,totalProgress: 1,color: "#BD013C",emoji: "love")],
                                                                   [.init(progress: 3,totalProgress: 3,color: "#FA6418"),.init(progress: 3,totalProgress: 3,color: "#BD013C",emoji: "love")],
                                                                   [.init(progress: 3,totalProgress: 3,color: "#FA6418"),.init(progress: 4,totalProgress: 4,color: "#BD013C",emoji: "love")]]
    
    var xDataList: [String] = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]
    
    EmojiChartView(
        chartType: .GroupChart,
        yDataList: $yValues,
        xDataList: xDataList,
        showEmoji: false,
        showYValues: true,
        showLines: false,
        showAreaMark: true,
        yAxisTitle: .none,
        valuesColor: .black,
        linesColor: .red,
        arealinesColor: .black.opacity(0.4),
        gradientColors: [.red.opacity(0.4), .red.opacity(0.3), .red.opacity(0.2), .red.opacity(0.1), .clear]
    ).frame(height: 400)
        .background(.clear.opacity(0.1))
    
} 


