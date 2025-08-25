//
//  EmojiVerticalGroupStackBar.swift
//  EmojiBarGraph
//
//  Created by AI 4LYF on 19/08/2025.
//

import SwiftUI

@available(iOS 17.0, *)
struct EmojiVerticalGroupStackBar: View {
    
    @Binding var yValues: [[[EmojiChartView.BarChart]]]
    
    var xValues: [String]
    var arealinesValues: [Double]
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
    
    @State var totalHeight: CGFloat = 0
    @State var totalWidth: CGFloat = 0
    
    @State var innerLinesWidth: CGFloat = 0
      
    @State var areaMarkSwiftUIColors:[Color] = []
    
    @State var showTooltip = false
    @State var tooltipJIndex = 0
    @State var tooltipIIndex = 0
    @State var selectedUUID = UUID()
    
    @State var selectedBarChart: EmojiChartView.BarChart? = nil
    @State var tooltipPosition: CGPoint = .zero
     
    @State var barCenters:[CGFloat] = []
     
    @State var lastJ = 0
    
    var body: some View {
        
        GeometryReader { geo in
            
            ZStack {
                
                VStack(alignment: .leading,spacing: 2) {
                    
                    YAxisTitle()
                    
                    Color.black.opacity(0.2)
                        .frame(height: 1)
                        .frame(width: CGFloat(totalHeight - CGFloat(innerLinesWidth / 2)) + 15, alignment: .top)
                    
                    YAxisValuesAndLines()
                        .padding(.leading, 10)
                    
                }
                
                ScrollView {
                    
                    GroupStackBarView()
                        .overlay(alignment: .topLeading) {
                            
                            AreaMarkLineChart()
                                .frame(width: geo.size.width - 42)
                                .background(.red.opacity(0.0))
                                .padding(.leading, 40)
                            
                        }
                    
                }.scrollIndicators(.hidden)
                    .scrollClipDisabled(false)
                
//                HStack {
//                    
//                    Text("\(totalHeight)")
//                    
//                    Text("\(innerLinesWidth)")
//                     
//                }
                
            }.frame(height: totalHeight, alignment: .top)
                .onChange(of: geo.size) { oldValue, newValue in
                    
                    totalHeight = geo.size.height
                    totalWidth = geo.size.width
                    
                }.onAppear{
                    
                    totalHeight = geo.size.height
                    totalWidth = geo.size.width
                    validate()
                    
                }.onChange(of: yValues) { oldValue, newValue in
                    
                    validate()
                    
                }.overlay {
                    
                    YAxisTextWidthOverlay()
                    
                }
            
        }.coordinateSpace(name: "ChartArea")
        
    }
    
    @ViewBuilder
    func YAxisTitle() -> some View {
        
        if let title = yAxisTitle, title != "" {
            
            Text(title)
                .font(.custom(fontName, size: CGFloat(yAxisTitleSize)))
                .rotationEffect(Angle(degrees: 270))
                .foregroundColor(valuesColor)
                .fixedSize()
                .frame(width: 20, height: totalHeight)
                .onAppear {
                    
                    hadTitle = true
                    
                }
            
        }
        
    }
    
    @ViewBuilder
    func YAxisValuesAndLines() -> some View {
        
        HStack(alignment: .top,spacing: 0) {
            
            ForEach((0..<dataSet.count), id: \.self) { i in
                
                let isZero = i == dataSet.reversed().indices.first
                let lineHeight = isZero ? CGFloat(innerLinesWidth / 2) : CGFloat(innerLinesWidth)
                let bg = isZero ? Color.black.opacity(0.0) : Color.red.opacity(0.0)
                
                VStack(spacing: 4) {
                    
                    Text("\(dataSet[i])")
                        .font(.custom(fontName, size: CGFloat(yAxisTitleSize)))
                        .foregroundColor(valuesColor)
                        .frame(width: showYValues ? textWidth : 0)
                        .opacity(showYValues ? 1 : 0)
                        .offset(y: -8)
                    
                    
                    if isZero {
                        
                        Color.black.opacity(0.2)
                            .frame(width: 1)
                        
                        
                    } else {
                        
                        linesColor.opacity(0.2)
                            .frame(width: 1)
                            .opacity(showLines ? 1 : 0)
                        
                    }
                    
                }.frame(width: lineHeight,alignment: .top)
                    .background(bg)
                
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
    func GroupStackBarView() -> some View {
        
        VStack(spacing: 28) {
            
            var lastXValue = ""
            
            
            ForEach(0..<yValues.count, id: \.self) { i in
                
                let y2DValuesList = yValues[i]
                let xValue = xValues[i]
                
//                Spacer()
                
                HStack(spacing: 12) {
                    
                    if lastXValue != xValue {
                      
                        Text(xValue)
                            .font(.custom(fontName, size: 12))
                            .frame(width: 30, alignment: .center)
                        
                    }
                    
                    
                    VStack(alignment: .leading, spacing: 2) {

                        ForEach(0..<y2DValuesList.count,id: \.self) { j in
                            
                            let y1DValuesList = y2DValuesList[j]
                            
                            ZStack(alignment: .leading) {
                                
                                HStack(spacing: 1) {
                                     
                                    let nonZeroValues = y1DValuesList.enumerated()
                                        .filter { $0.element.progress > 0 }
                                        .map { $0 }
                                    
                                    let count = nonZeroValues.count
                                    let nonZeroMaxK = max(count - 1, 1) // Prevent division by zero
                                    let minOpacity = 0.5
                                    
                                    ForEach((0..<y1DValuesList.count).reversed(), id: \.self) { k in
                                        
                                        let barChart = y1DValuesList[k]
                                        let progress = barChart.progress
                                        let width = (Double(innerLinesWidth) * Double(progress)) / heightDivider
                                        let color = barChart.color
                                        
                                        if progress > 0 {
                                            
                                            let indexInNonZero = nonZeroValues.firstIndex(where: { $0.offset == k }) ?? 0
                                            
                                            let opacity: Double = count == 1 ? 1.0 : minOpacity + (Double(indexInNonZero) / Double(nonZeroMaxK)) * (1.0 - minOpacity)
                                            
                                            ProgressBarCell(width: width, color: color, opacity: opacity, i: i, j: j, k: k, barChart: barChart)
                                            
                                        }
                                        
                                    }
                                    
                                }
                                
                            }
                            
                        }
                        
                    }
                    
                    Spacer()
                   
                }.onAppear {
                    
                    lastXValue = xValue
                    
                }
                
            }
            
        }.padding(.leading, showYValues ? 16 : 0)
        
        
    }
    
    @ViewBuilder
    func ProgressBarCell(width: Double, color: String, opacity: Double,i: Int,j: Int,k: Int,barChart:EmojiChartView.BarChart) -> some View {
        
        GeometryReader { proxy in
            
            Capsule()
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
            
        }.frame(width: CGFloat(width.isFinite ? max(0, width) : 0), height: 12)
           
    }
    
    @ViewBuilder
    func AreaMarkLineChart() -> some View {
        GeometryReader { geo in
            Canvas { context, size in
                    // We now have a vertical chart, so the 'bars' are positioned on the Y-axis.
                    // We'll use the height to determine the center of each bar.
                var barCenters = stride(
                    from: 0,
                    to: size.height,
                    by: size.height / CGFloat(arealinesValues.count)
                ).map { $0 + size.height / CGFloat(arealinesValues.count) / 2 }
                
                    // tweak first & last
                if !barCenters.isEmpty {
                    barCenters[0] -= 40   // shift first upward
                    barCenters[barCenters.count - 1] += 40  // shift last downward
                }
                    // Replace 0 with 5 as a minimum value
                let adjustedValues = arealinesValues.map { $0 == 0 ? 5 : $0 }
                
                    // Scale to chart space (flipped: 5 -> left, 1 -> right)
                let scaledData = adjustedValues.map { value in
                    let normalized = (5.0 - CGFloat(value)) / 4.0
                    return size.width * normalized
                }
                
                    // Build the bezier paths with the new vertical orientation
                let (path, areaPath) = buildVerticalBezierPaths(
                    scaledData: scaledData,
                    barCenters: barCenters,
                    size: size
                )
                
                    // Define a vertical linear gradient for the area fill
                let stops: [Gradient.Stop] = areaMarkSwiftUIColors.enumerated().map { index, color in
                        // The fraction is now based on the y-position (barCenters) relative to the total height.
                    let fraction: CGFloat = size.height > 0 && index < barCenters.count
                    ? barCenters[index] / size.height
                    : 0
                    return .init(color: color.opacity(0.2), location: fraction)
                }
                
                let shading = GraphicsContext.Shading.linearGradient(
                    Gradient(stops: stops),
                    // Start and end points are now vertical.
                    startPoint: .zero,
                    endPoint: CGPoint(x: 0, y: size.height)
                )
                
                context.fill(areaPath, with: shading)
                context.stroke(path,
                               with: .color(arealinesColor),
                               style: StrokeStyle(lineWidth: 1.5, lineCap: .round))
            }
        }
    }
    
        /// Builds the bezier paths for a vertical chart.
        /// - Parameters:
        ///   - scaledData: The scaled x-values for each data point.
        ///   - barCenters: The y-coordinates for each data point.
        ///   - size: The size of the canvas.
        /// - Returns: A tuple containing the line path and the area path.
    func buildVerticalBezierPaths(scaledData: [CGFloat], barCenters: [CGFloat], size: CGSize) -> (Path, Path) {
        var linePath = Path()
        var areaPath = Path()
        
        guard scaledData.count == barCenters.count, !scaledData.isEmpty else {
            return (linePath, areaPath)
        }
        
            // The first point now uses the scaled data as the x-coordinate and bar center as the y-coordinate.
        let firstPoint = CGPoint(x: scaledData[0], y: barCenters[0])
        linePath.move(to: firstPoint)
        
            // The area path starts at the y-axis (x=0) and moves to the first point.
        areaPath.move(to: CGPoint(x: 0, y: barCenters[0]))
        areaPath.addLine(to: firstPoint)
        
        for i in 1..<scaledData.count {
                // Get the previous and current points with swapped coordinates.
            let p0 = CGPoint(x: scaledData[i-1], y: barCenters[i-1])
            let p1 = CGPoint(x: scaledData[i], y: barCenters[i])
            
            let midY = (p0.y + p1.y) / 2
            let cp1 = CGPoint(x: p0.x, y: midY)
            let cp2 = CGPoint(x: p1.x, y: midY)
            
            linePath.addCurve(to: p1, control1: cp1, control2: cp2)
            areaPath.addCurve(to: p1, control1: cp1, control2: cp2)
        }
        
            // Close the area path by moving back to the y-axis.
        if let lastY = barCenters.last {
            areaPath.addLine(to: CGPoint(x: 0, y: lastY))
            areaPath.closeSubpath()
        }
        
        return (linePath, areaPath)
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
        
        innerLinesWidth = (totalWidth / CGFloat(totalLines - 1)) - 10
        
        if barCenters.count != xValues.count {
            barCenters = Array(repeating: 0, count: xValues.count)
        }
         
        
        print("Max Value: \(maxValues), Max Value 1: \(maxValues1), Max Value 2: \(maxValues2), innerLinesWidth: \(innerLinesWidth), totalHeight: \(totalHeight)")
        
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
        dataSet = generateArray1(forX: mainMaxValue,maxValue: maxValues)
        
        lastValue = Double(dataSet[dataSet.count - 1]) ?? 0.0
        
        self.mainMaxValue = Int(lastValue)
        
        var valueToAddAreaMark: Double = 0
        
        if maxValues <= 3 {
            
            valueToAddAreaMark = 0
            
        }else{
            
            valueToAddAreaMark = 0.5
            
        }
         
            // Extract (sum, color) for each group per day
        let areaMarkColorList: [String] = yValues.map { dayArray in
            dayArray.map { group in
                let sum = group.map { bar in
                    bar.totalProgress > 0 ? bar.totalProgress + valueToAddAreaMark : 0
                }.reduce(0, +)
                
                    // Use first bar color in group (or fallback to default)
                let groupColor = group.first?.color ?? ""
                
                return (sum: sum, color: groupColor)
            }
                // Get the color of the group with the highest sum
            .max { $0.sum < $1.sum }?.color ?? ""
        }
        
        areaMarkSwiftUIColors = areaMarkColorList.map { Color(hex: $0) }
          
        isDataLoaded = true
        
    }
    
    func generateArray1(forX x: Int,maxValue: Double) -> [String] {
        let xValue = x
        
        var array = [Double](repeating: 1, count: totalLines)
        var stringArray: [String] = []
        
        let valueToAdd = (x - 1) / totalLines + 1
        
        print("Value to add: \(valueToAdd), X Value: \(xValue)")
        
        heightDivider = maxValue / Double((totalLines - 2))
        
        if xValue >= 3 && xValue < 6 {
            
            print("2")
            
            stringArray.removeAll()
            
            let step = Double(xValue) / Double(totalLines - 1)
            
            for i in 0..<array.count {
                
                let value = step * Double(i)
                array[i] = value
                
                stringArray.append(String(format: "%.1f", array[i]))
                
            }
            
        } else {
            
            print("3")
            
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
            
            
        }
        
        print("stringArray", stringArray)
        
        return stringArray
    }
    
    
}

 
@available(iOS 17.0, *)
#Preview {
    @Previewable @State var yValues: [[[EmojiChartView.BarChart]]] = [
        
        [   // Mon
            [.init(progress: 10, totalProgress: 10, color: "#2893D7", title: "Magnesium", type: "Supplement"),
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
            [.init(progress: 8, totalProgress: 8, color: "#2893D7", title: "Vitamin D", type: "Supplement"),
             .init(progress: 2, totalProgress: 2, color: "#2893D7", title: "Iron", type: "Supplement")],
            
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
    
//            @Previewable @State var yValues: [[[EmojiChartView.BarChart]]] = [
//        
//                [   // Mon
//                    []
//        
//                ],
//        
//                [   // Tue
//                    [.init(progress: 1, totalProgress: 1, color: "#7FD533", title: "Magnesium", type: "Supplement"),.init(progress: 1, totalProgress: 1, color: "#7FD533", title: "Magnesium", type: "Supplement")],
//                    [.init(progress: 1, totalProgress: 1, color: "#7FD533", title: "Magnesium", type: "Supplement"),.init(progress: 1, totalProgress: 1, color: "#7FD533", title: "Magnesium", type: "Supplement"),.init(progress: 1, totalProgress: 1, color: "#7FD533", title: "Magnesium", type: "Supplement")]
//                ],
//        
//                [   // Wed
//                    []
//                ],
//        
//                [   // Thu
//                    []
//                ]
//        
//            ]
    
    var xDataList: [String] = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]
//            var xDataList: [String] = ["Mon", "Tue", "Wed", "Thu"]
    
    var areaLinesValues: [Double] = [0.0, 1.0, 5.0, 5.0, 1.0, 0.0, 0.0]
//            var areaLinesValues: [Double] = [3.0, 4.0, 2.0, 5.0]
    VStack(spacing: 50) {
//        EmojiChartView(
//            chartType: .GroupStackChart,
//            yDataList: $yValues,
//            xDataList: xDataList,
//            areaLinesValues: areaLinesValues,
//            graphOrientation: .Horizontal,
//            showEmoji: false,
//            showYValues: false,
//            showLines: false,
//            showAreaMark: true,
//            yAxisTitle: "",
//            valuesColor: .black,
//            linesColor: .black,
//            arealinesColor: .black.opacity(0.4),
//            gradientColors: [.red.opacity(0.4), .red.opacity(0.3), .red.opacity(0.2), .red.opacity(0.1), .clear],
//            progressBGColor: .clear
//        ).frame(height: 300)
//     
        
        EmojiChartView(
            chartType: .GroupStackChart,
            yDataList: $yValues,
            xDataList: xDataList,
            areaLinesValues: areaLinesValues,
            graphOrientation: .Vertical,
            showEmoji: false,
            showYValues: false,
            showLines: false,
            showAreaMark: false,
            yAxisTitle: "Emoji Chart View",
            valuesColor: .black,
            linesColor: .black,
            arealinesColor: .black.opacity(0.4),
            gradientColors: [.red.opacity(0.4), .red.opacity(0.3), .red.opacity(0.2), .red.opacity(0.1), .clear],
            progressBGColor: .clear
        ).frame(height: 480)
        
    }
    
}


