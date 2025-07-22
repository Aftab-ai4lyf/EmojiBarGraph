    //
    //  EmojiGroupStackBarChart.swift
    //  EmojiBarGraph
    //
    //  Created by AI 4LYF on 21/07/2025.
    //

import Foundation
import SwiftUI
import Charts



@available(iOS 17.0, *)
public struct EmojiGroupStackBarChart: View {
    
    @Binding var yValues: [[[EmojiChartView.BarChart]]]
    
    var xValues: [String]
    var showEmoji: Bool
    var showYValues: Bool
    var showLines: Bool
    
    var valuesColor: Color = .black
    var linesColor: Color = .black.opacity(0.50)
    
    var progressBGColor = Color.gray.opacity(0.40)
    
    var fontName = ""
    
    var yAxisTitle: String?
    var yAxisTitleSize = 12
    
    var yAxisValuesSize = 12
    
    var emojiHeight = 8
    var emojiWidth = 8
    
    var showAreaMark: Bool
    
    var arealinesColor: Color
    var gradientColors: [Color]
    
    var enableHorizontalScroll:Bool = true
    
    var tempYValues: [[Int]] = [[0,0],[0,0],[0,0],[0,0],[0,0],[0,0],[0,0]]
    @State var tempMaxYValues: [[Int]] = [[0,0],[0,0],[0,0],[0,0],[0,0],[0,0],[0,0]]
    var tempXValues: [String] = ["Mon","Tue","Wed","Thu","Fri","Sat","Sun"]
    
    @State var dataSet: [String] = []
    @State var dataSet1: [String] = ["0", "3", "6", "9", "12", "15", "18"]
    
    @State var heightDivider: Double = 0
    @State var lastValue: Double = 0
    
    @State var mainMaxValue = 4
    
    @State var textWidth: CGFloat = .zero
    
    @State var isError = false
    @State var errorMessage = ""
    
    @State var isDataLoaded = false
    
    @State var hadTitle = false
    
    @State var totalLines = 4
    
    @State var totalHeight: CGFloat = 300
    
    @State var innerLinesHeight: Int = 50
    @State var bottomPadding: Double = 30.0
    
    @State var firstDataSetValue:Int = 0
    @State var lastDataSetValue:Int = 0
    
    @State var areaMarkDataSetList:[Double] = []
    @State var areaMarkSwiftUIColors:[Color] = []
    
    @State var showTooltip = false
    @State var tooltipJIndex = 0
    @State var tooltipIIndex = 0
    @State var selectedUUID = UUID()
    
    @State var selectedBarChart: EmojiChartView.BarChart? = nil
    @State var tooltipPosition: CGPoint = .zero
    
    @State var isPortrait = UIDevice.current.orientation.isPortrait ? true : false
    
    public var body: some View {
        
        GeometryReader { geo in
             
            let alignment: Alignment = isPortrait ? .center : .bottomLeading
            
            let screenWidth = geo.size.width
            let baseWidth = max(screenWidth, CGFloat(yValues.count) * 12)
            
            let contentWidth = baseWidth + (isPortrait ? 60 : -50)
            
            
            ZStack(alignment: .center) {
                 
                VStack(spacing: 0) {
                    
                    HStack(spacing: 0) {
                        
                        YAxisTitle()
                        
                        VStack(spacing: 0) {
                            
                            YAxisValuesAndLines()
                            
                        }
                        
                    }
                    
                }.padding(.leading, hadTitle ? 8 : 0)
                    .overlay {
                        
                        YAxisTextWidthOverlay()
                        
                    }.overlay(alignment: .bottom) {
                        
                        if !isError {
                            
                            
                            ScrollView(.horizontal) {
                                
                                ZStack(alignment: alignment) {
                                    
                                    GroupStackBarView()
                                        .background(
                                            
                                            Group {
                                                
                                                if showTooltip {
                                                    
                                                    Color.black.opacity(0.001)
                                                        .contentShape(Rectangle())
                                                        .onTapGesture {
                                                            
                                                            withAnimation {
                                                                
                                                                tooltipPosition = .zero
                                                                showTooltip = false
                                                                
                                                            }
                                                            
                                                        }
                                                    
                                                }
                                                
                                            }
                                            
                                        )
                                    
                                    if showAreaMark && !isError {
                                        
                                        AreaMarkLineChart()
                                            .frame(width: contentWidth)
                                            .frame(height: geo.size.height - (isPortrait ? 20 : 40))
                                            .padding(.leading, showYValues ? 26 : (isPortrait ? 13 : 56))
                                            .padding(.bottom, isPortrait ? 0 : 54)
                                    }
                                    
                                }
                                
                            }.scrollIndicators(.hidden)
                                .scrollDisabled(!enableHorizontalScroll)
                            
                        }else {
                            
                            ErrorBarsView()
                            
                        }
                        
                    }.overlay(alignment: .center) {
                        
                        ErrorView()
                        
                    }.overlay(alignment: .topLeading) {
                        
                        if showTooltip, selectedBarChart != nil {
                            
                            let y1dDataList = yValues[tooltipIIndex][tooltipJIndex]
                            
                            let type = y1dDataList.first?.type
                            
                            let titleColorArray = y1dDataList.reduce(into: [(String, String)]()) { result, bar in
                                
                                if !result.contains(where: { $0.0 == bar.title }) {
                                    
                                    result.append((bar.title, bar.color))
                                    
                                }
                                
                            }
                            
                            EmojiTooltipView(type: type, titleColorArray: titleColorArray, fontName: fontName)
                                .position(x: tooltipPosition.x, y: tooltipPosition.y)
                                .transition(.opacity.combined(with: .scale))
                            
                        }
                        
                    }
                
            }.coordinateSpace(name: "ChartArea")
                .padding()
                .offset(y: -58)
                .onOrientationChange { orientation in
                   
                    isPortrait = orientation.isPortrait
                    
                }.onChange(of: yValues) { oldValue, newValue in
                    
                    validate()
                    
                }.onAppear {
                      
                    totalHeight = geo.size.height
                    validate()
                    
                }
            
        }
        
    }
    
    
    
    @ViewBuilder
    func YAxisTitle() -> some View {
        
        if let title = yAxisTitle, title != "" {
            
            Text(title)
                .font(.custom(fontName, size: CGFloat(yAxisTitleSize)))
                .rotationEffect(Angle(degrees: 270))
                .foregroundColor(valuesColor)
                .fixedSize()
                .frame(width: 20, height: 0)
                .onAppear {
                    
                    hadTitle = true
                    
                }
            
        }
        
    }
    
    @ViewBuilder
    func YAxisValuesAndLines() -> some View {
        
        ForEach((0..<dataSet.count).reversed(), id: \.self) { i in
            
            HStack(spacing: 4) {
                
                if showYValues {
                    
                    Text("\(dataSet[i])")
                        .font(.custom(fontName, size: CGFloat(yAxisTitleSize)))
                        .foregroundColor(valuesColor)
                        .frame(width: textWidth, height: CGFloat(innerLinesHeight), alignment: .trailing)
                    
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
    
    @ViewBuilder
    private func YAxisTextWidthOverlay() -> some View {
        
        Text(String(format: "%.1f", lastValue))
            .opacity(0)
            .font(.custom(fontName, size: CGFloat(yAxisTitleSize)))
            .background {
                
                GeometryReader { geo in
                    
                    Color.clear
                        .onAppear {
                            
                            textWidth = CGFloat(geo.size.width)
                            
                            if lastValue > 6 {
                                
                                textWidth -= 10
                                
                            }
                            
                        }
                    
                }
                
            }.id(lastValue)
        
    }
    
    @ViewBuilder
    private func ErrorView() -> some View {
        
        if isError {
            
            HStack {
                
                Spacer()
                
                Text(errorMessage)
                    .font(.custom(fontName, size: 14))
                    .foregroundColor(.red)
                    .multilineTextAlignment(.center)
                
                Spacer()
                
            }.padding(.horizontal)
                .padding(.leading, 32)
            
        }
        
    }
    
    @ViewBuilder
    private func ErrorBarsView() -> some View {
        
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
            
        }.padding(.leading, 28)
            .id(mainMaxValue)
            .onAppear {
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    
                    mainMaxValue = 12
                    
                }
                
                dataSet = ["0", "2", "4", "6", "8", "10", "12"]
                
            }
        
    }
    
    @ViewBuilder
    func GroupStackBarView() -> some View {
         
        HStack(alignment: .bottom, spacing: 8) {
            
            var lastXValue = ""
            
            ForEach(0..<yValues.count, id: \.self) { i in
                
                let y2DValuesList = yValues[i]
                let xValue = xValues[i]
                
                Spacer()
                
                VStack(spacing: 0) {
                    
                    HStack(spacing: 2) {
                        
                        ForEach(0..<y2DValuesList.count,id: \.self) { j in
                            
                            let y1DValuesList = y2DValuesList[j]
                            
                            ZStack(alignment: .bottom) {
                                
                                let totalMaxSum = Int(y1DValuesList.compactMap { $0 }.reduce(0) { $0 + $1.totalProgress })
                                let totalHeight = Double(innerLinesHeight * totalMaxSum)
                                
                                Capsule()
                                    .frame(width: 12, height: totalHeight / heightDivider)
                                    .foregroundColor(progressBGColor)
                                
                                VStack(spacing: 1) {
                                    
                                    Spacer()
                                    
                                    let nonZeroValues = y1DValuesList.enumerated()
                                        .filter { $0.element.progress > 0 }
                                        .map { $0 }
                                    
                                    let count = nonZeroValues.count
                                    let nonZeroMaxK = max(count - 1, 1) // Prevent division by zero
                                    let minOpacity = 0.5
                                    
                                    ForEach(0..<y1DValuesList.count, id: \.self) { k in
                                        
                                        let barChart = y1DValuesList[k]
                                        let progress = barChart.progress
                                        let height = Double(innerLinesHeight) * Double(progress)
                                        let color = barChart.color
                                        
                                        if progress > 0 {
                                            
                                            let indexInNonZero = nonZeroValues.firstIndex(where: { $0.offset == k }) ?? 0
                                            
                                            let opacity: Double = count == 1 ? 1.0 : minOpacity + (Double(indexInNonZero) / Double(nonZeroMaxK)) * (1.0 - minOpacity)
                                            
                                            ProgressBarCell(height: height, color: color, opacity: opacity, i: i, j: j, k: k, barChart: barChart)
                                            
                                        }
                                        
                                    }
                                    
                                }
                                
                            }.padding(.bottom, CGFloat(bottomPadding))
                            
                        }
                        
                    }
                    
                    if lastXValue != xValue {
                        
                        Text("\n\n" + xValue)
                            .font(.custom(fontName, size: 12))
                            .padding(.bottom, -4)
                            .offset(y: -30)
                            .onAppear {
                                
                                lastXValue = xValue
                                
                            }
                        
                    }
                    
                }
                
            }
            
        }.padding(.leading, showYValues ? 16 : 0)
            .id(mainMaxValue)
        
    }
    
    @ViewBuilder
    func ProgressBarCell(height: Double, color: String, opacity: Double,i: Int,j: Int,k: Int,barChart:EmojiChartView.BarChart) -> some View {
        
        GeometryReader { proxy in
            
            Capsule()
                .frame(width: 12, height: height / heightDivider)
                .foregroundColor(Color(hex: color).opacity(opacity))
                .onTapGesture {
                    
                    let localFrame = proxy.frame(in: .named("ChartArea"))
                    
                    withAnimation {
                        
                        tooltipIIndex = i
                        tooltipJIndex = j
                        selectedBarChart = barChart
                        tooltipPosition = CGPoint(x: localFrame.midX, y: localFrame.minY - 10)
                        showTooltip = true
                        
                    }
                    
                }
            
        }.frame(width: 12, height: height / heightDivider)
        
    }
    
    @ViewBuilder
    func AreaMarkLineChart() -> some View {
        
        let gradientStops = areaMarkSwiftUIColors.enumerated().map { index, color in
            
            let baseOpacity = 0.15
            let minOpacity = 0.1
            
            let opacity = baseOpacity - (Double(index) / Double(areaMarkSwiftUIColors.count - 1)) * (baseOpacity - minOpacity)
            
            return Gradient.Stop(color: color.opacity(opacity), location: Double(index) / Double(areaMarkSwiftUIColors.count - 1))
        }
        
        let gradient = LinearGradient(
            gradient: Gradient(stops: gradientStops),
            startPoint: .leading,
            endPoint: .trailing
        )
        
        Chart {
            
            ForEach(Array(areaMarkDataSetList.enumerated()), id: \.offset) { item in
                
                let i = item.offset
                let progress = item.element
                
                AreaMark(
                    x: .value("Day", Double(i)),
                    y: .value("Line", progress)
                )
                .interpolationMethod(.catmullRom)
                .foregroundStyle(gradient)
                
                LineMark(
                    x: .value("Day", Double(i)),
                    y: .value("Line", progress)
                )
                .interpolationMethod(.catmullRom)
                .foregroundStyle(arealinesColor)
            }
        }
        .chartXScale(domain: 0.0...Double(xValues.count - 1))
        .chartYScale(domain: firstDataSetValue...lastDataSetValue)
        .chartPlotStyle { plot in
            plot.background(.clear)
        }
        .chartXAxis(.hidden)
        .chartYAxis(.hidden)
        .background(.clear)
        .allowsHitTesting(false)
        
    }
    
        // Validate the data if both xDataList and yDataList had same length
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
            
        }else if xValuesCount == yValuesCount {
            
            if !isError {
                
                findMaxValue()
                
            }
            
        }
        
    }
    
    func findMaxValue() {
        
        let maxValues1 = yValues.map { dayArray in
            dayArray.flatMap { $0 }.reduce(0) { $0 + $1.totalProgress }
        }.max() ?? 0
        
        let maxValues2 = yValues.map { dayArray in
            dayArray.flatMap { $0 }.reduce(0) { $0 + $1.progress }
        }.max() ?? 0
        
        var maxValues = 0.0
        
        if maxValues1 > maxValues2 {
            
            maxValues = maxValues1
            
        } else {
            
            maxValues = maxValues2
            
        }
        
        innerLinesHeight = (Int(totalHeight) / totalLines) + 18
        
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
        
        dataSet.removeAll()
        dataSet = generateArray1(forX: mainMaxValue)
        
        lastValue = Double(dataSet[dataSet.count - 1]) ?? 0.0
        
        self.mainMaxValue = Int(lastValue)
        
        let newYValues2 = yValues.map { dayArray in
            dayArray.map { group in
                group.map { bar in
                    bar.totalProgress > 0 ? bar.totalProgress + 0.5 : 0
                }.reduce(0, +)
            }.max() ?? 0
        }
        
        let firstValue = dataSet[0].replacingOccurrences(of: "K", with: "").replacingOccurrences(of: "M", with: "").replacingOccurrences(of: "B", with: "")
        let lastValueNew = dataSet[dataSet.count - 1].replacingOccurrences(of: "K", with: "").replacingOccurrences(of: "M", with: "").replacingOccurrences(of: "B", with: "")
        
        firstDataSetValue = Int(Double(firstValue) ?? 0.0)
        lastDataSetValue = Int(Double(lastValueNew) ?? 0.0)
        
        areaMarkDataSetList = newYValues2
        
            // Extract (sum, color) for each group per day
        let areaMarkColorList: [String] = yValues.map { dayArray in
            dayArray.map { group in
                let sum = group.map { bar in
                    bar.totalProgress > 0 ? bar.totalProgress + 0.5 : 0
                }.reduce(0, +)
                
                    // Use first bar color in group (or fallback to default)
                let groupColor = group.first?.color ?? "#000000"
                
                return (sum: sum, color: groupColor)
            }
                // Get the color of the group with the highest sum
            .max { $0.sum < $1.sum }?.color ?? "#000000"
        }
        
        areaMarkSwiftUIColors = areaMarkColorList.map { Color(hex: $0) }
        
        print("Area Mark SwiftUI Colors: \(areaMarkSwiftUIColors)")
        
        print("Area Mark Data set list: \(areaMarkDataSetList)")
        
        isDataLoaded = true
        
    }
    
        // MARK: - Generate Array
    
    func generateArray1(forX x: Int) -> [String] {
        let xValue = x
        
        var array = [Double](repeating: 1, count: totalLines)
        var stringArray: [String] = []
        
        let valueToAdd = (x - 1) / 5
        
        print("Value to add: \(valueToAdd)")
        
        if xValue == 3 {
            
            stringArray.removeAll()
            let parts = 6
            heightDivider = Double(0.5)
            let step = Double(xValue) / Double(parts)
            
            for i in 0...parts {
                
                let value = step * Double(i)
                
                stringArray.append(String(format: "%.1f", value))
                
            }
            
        } else if xValue > 3 && xValue < 6 {
            
            stringArray.removeAll()
            
            let parts = 6
            
            let step = Double(xValue) / Double(parts)
            
            if xValue == 4 {
                
                heightDivider = 0.673
                
            } else if xValue == 5 {
                
                heightDivider = 0.842
                
            }
            
            for i in 0...parts {
                
                let value = step * Double(i)
                stringArray.append(String(format: "%.1f", value))
                
            }
            
        } else {
            
            heightDivider = Double(valueToAdd + 1)
            
            for i in 0..<array.count {
                
                var oldValue = array[i]
                
                if i > 0 {
                    
                    oldValue = array[i-1]
                    oldValue += Double(valueToAdd)
                    array[i] += oldValue
                    stringArray.append(String(format: "%.0f", array[i]))
                    
                } else {
                    
                    array[i] = 0
                    stringArray.append("0")
                    
                }
                
            }
            
            print("array", array)
        }
        
        return stringArray
    }
    
}

@available(iOS 17.0, *)
struct EmojiTooltipView: View {
    var type: String?
    var titleColorArray: [(String, String)]
    var fontName: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            
            if let type {
                
                Text(type)
                    .font(.custom(fontName, size: 12))
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                
            }
            
            let count = titleColorArray.count
            let nonZeroMaxK = max(count - 1, 1)
            let minOpacity = 0.5
            
            ForEach(0..<titleColorArray.count, id: \.self) { index in
                
                let (title, color) = titleColorArray[index]
                
                let opacity: Double = count == 1
                ? 1.0
                : minOpacity + (Double(index) / Double(nonZeroMaxK)) * (1.0 - minOpacity)
                
                HStack {
                    Circle()
                        .fill(Color(hex: color).opacity(opacity))
                        .frame(width: 8, height: 8)
                    
                    Text(title)
                        .font(.custom(fontName, size: 10))
                        .foregroundColor(.black)
                        .fixedSize(horizontal: false, vertical: false)
                        .lineLimit(1)
                    
                    Spacer()
                }
                
            }
            
        }
        .padding(.horizontal, 8)
        .frame(width: 95)
        .padding(.vertical, 8)
        .background(Color.white)
        .cornerRadius(8)
        .shadow(radius: 4)
        
    }
}

@available(iOS 17.0, *)
#Preview {
    @Previewable @State var yValues: [[[EmojiChartView.BarChart]]] = [
        
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
    
    var xDataList: [String] = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]
    
    EmojiChartView(
        chartType: .GroupStackChart,
        yDataList: $yValues,
        xDataList: xDataList,
        showEmoji: false,
        showYValues: false,
        showLines: true,
        showAreaMark: true,
        yAxisTitle: "",
        valuesColor: .black,
        linesColor: .black,
        arealinesColor: .black.opacity(0.4),
        gradientColors: [.red.opacity(0.4), .red.opacity(0.3), .red.opacity(0.2), .red.opacity(0.1), .clear],
        progressBGColor: .clear
    ).frame(height: 350)
    
}

