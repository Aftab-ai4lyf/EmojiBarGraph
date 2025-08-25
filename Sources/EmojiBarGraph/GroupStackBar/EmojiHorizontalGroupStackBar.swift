//
//  EmojiHorizontalGroupStackBar.swift
//  EmojiBarGraph
//
//  Created by AI 4LYF on 19/08/2025.
//

import SwiftUI

@available(iOS 17.0, *)
struct EmojiHorizontalGroupStackBar: View {
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
    
    @State var innerLinesHeight: CGFloat = 0
    
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
    
    @State var paddingLeading:CGFloat = 50
    
    @State var barCenters:[CGFloat] = []
    
    public var body: some View {
        
        GeometryReader { geo in
            
            ZStack {
                
                GeometryReader { geoInner in
                    
                    HStack(alignment: .top,spacing: 2) {
                        
                        YAxisTitle()
                        
                        Color.black.opacity(0.2)
                            .frame(width: 1)
                            .frame(height: CGFloat(totalHeight - CGFloat(innerLinesHeight / 2)) + 15, alignment: .top)
                        
                        YAxisValuesAndLines()
                        
                    }
                    
                }
                
                ScrollView(.horizontal) {
                    
                    GroupStackBarView()
                        .overlay(alignment: .top) {
                            
                            AreaMarkLineChart()
                                .frame(height: geo.size.height - 30)
                            
                        }
                    
                }.scrollIndicators(.hidden)
                
                  
            }.frame(height: totalHeight, alignment: .top)
                .onAppear{
                    
                    totalHeight = geo.size.height
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
        
        VStack(spacing: 0) {
            
            ForEach((0..<dataSet.count).reversed(), id: \.self) { i in
                
                let isZero = i == dataSet.reversed().indices.first
                let lineHeight = isZero ? CGFloat(innerLinesHeight / 2) : CGFloat(innerLinesHeight)
                let bg = isZero ? Color.black.opacity(0.0) : Color.red.opacity(0.0)
                
                HStack(alignment: .top,spacing: 4) {
                    
                    Text("\(dataSet[i])")
                        .font(.custom(fontName, size: CGFloat(yAxisTitleSize)))
                        .foregroundColor(valuesColor)
                        .frame(width: showYValues ? textWidth : 0)
                        .opacity(showYValues ? 1 : 0)
                        .offset(y: -8)
                    
                    if isZero {
                        
                        Color.black.opacity(0.2)
                            .frame(height: 1)
                        
                    } else {
                        
                        Line()
                            .stroke(style: StrokeStyle(lineWidth: 0.5, dash: [2]))
                            .frame(height: 0.5)
                            .foregroundColor(linesColor)
                            .opacity(showLines ? 1 : 0)
                        
                    }
                    
                }.frame(height: lineHeight,alignment: .top)
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
        
        HStack(alignment: .bottom, spacing: 12) {
            
            var lastXValue = ""
            
            
            ForEach(0..<yValues.count, id: \.self) { i in
                
                let y2DValuesList = yValues[i]
                let xValue = xValues[i]
                
                Spacer()
                
                VStack(spacing: 0) {
                    
                    HStack(alignment: .bottom, spacing: 2) {
                        
                        ForEach(0..<y2DValuesList.count,id: \.self) { j in
                            
                            let y1DValuesList = y2DValuesList[j]
                            
                            ZStack(alignment: .bottom) {
                                
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
                                        let height = (Double(innerLinesHeight) * Double(progress)) / heightDivider
                                        let color = barChart.color
                                        
                                        if progress > 0 {
                                            
                                            let indexInNonZero = nonZeroValues.firstIndex(where: { $0.offset == k }) ?? 0
                                            
                                            let opacity: Double = count == 1 ? 1.0 : minOpacity + (Double(indexInNonZero) / Double(nonZeroMaxK)) * (1.0 - minOpacity)
                                            
                                            ProgressBarCell(height: height, color: color, opacity: opacity, i: i, j: j, k: k, barChart: barChart)
                                            
                                        }
                                        
                                    }
                                    
                                }
                                
                            }
                            
                        }
                        
                    }
                    
                    if lastXValue != xValue {
                        Text(xValue)
                            .font(.custom(fontName, size: 12))
                            .padding(.top, 17)
                        
                    }
                    
                }.background(
                    GeometryReader { geo in
                        Color.clear
                            .onAppear {
                                let frame = geo.frame(in: .named("ChartArea"))
                                
                                let valueToAdd: CGFloat
                                if i == 0 {
                                    valueToAdd = frame.minX   // startX
                                } else if i == xValues.count - 1 {
                                    valueToAdd = frame.maxX   // endX
                                } else {
                                    valueToAdd = frame.midX   // relativeX (center)
                                }
                                
                                if barCenters.count > i {
                                    barCenters[i] = valueToAdd
                                    
                                } else {
                                    barCenters.append(valueToAdd)
                                }
                                
                                lastXValue = xValue
                            }
                    }
                )
            }
            
        }.frame(height: totalHeight)
            .padding(.leading, showYValues ? 16 : 0)
        
    }
    
    
    @ViewBuilder
    func ProgressBarCell(height: Double, color: String, opacity: Double,i: Int,j: Int,k: Int,barChart:EmojiChartView.BarChart) -> some View {
        
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
            
        }.frame(width: 12, height: CGFloat(height.isFinite ? max(0, height) : 0), alignment: .bottom)
        
        
    }
    
    @ViewBuilder
    func AreaMarkLineChart() -> some View {
        GeometryReader { geo in
            Canvas { context, size in
                
                    // Replace 0 with 5
                let adjustedValues = arealinesValues.map { $0 == 0 ? 5 : $0 }
                
                    // Scale to chart space (1 at top, 5 at bottom)
                let scaledData = adjustedValues.map { value in
                    let normalized = (CGFloat(value) - 1) / 4.0
                    return size.height * normalized
                }
                
                let (path, areaPath) = buildBezierPaths(
                    scaledData: scaledData,
                    barCenters: barCenters,
                    size: size
                )
                
                let stops: [Gradient.Stop] = areaMarkSwiftUIColors.enumerated().map { index, color in
                    let fraction: CGFloat = size.width > 0 && index < barCenters.count
                    ? barCenters[index] / size.width
                    : 0
                    return .init(color: color.opacity(0.2), location: fraction)
                }
                
                let shading = GraphicsContext.Shading.linearGradient(
                    Gradient(stops: stops),
                    startPoint: .zero,
                    endPoint: CGPoint(x: size.width, y: 0)
                )
                
                context.fill(areaPath, with: shading)
                context.stroke(path,
                               with: .color(arealinesColor),
                               style: StrokeStyle(lineWidth: 1.5, lineCap: .round))
            }
        }
    }
    
        // updated buildBezierPaths — now expects *already scaled y-values*
    func buildBezierPaths(scaledData: [CGFloat], barCenters: [CGFloat], size: CGSize) -> (Path, Path) {
        var linePath = Path()
        var areaPath = Path()
        
        guard scaledData.count == barCenters.count, !scaledData.isEmpty else {
            return (linePath, areaPath)
        }
        
        let firstPoint = CGPoint(x: barCenters[0], y: scaledData[0])
        linePath.move(to: firstPoint)
        areaPath.move(to: CGPoint(x: barCenters[0], y: size.height))
        areaPath.addLine(to: firstPoint)
        
        for i in 1..<scaledData.count {
            let p0 = CGPoint(x: barCenters[i-1], y: scaledData[i-1])
            let p1 = CGPoint(x: barCenters[i],   y: scaledData[i])
            
            let midX = (p0.x + p1.x) / 2
            let cp1 = CGPoint(x: midX, y: p0.y)
            let cp2 = CGPoint(x: midX, y: p1.y)
            
            linePath.addCurve(to: p1, control1: cp1, control2: cp2)
            areaPath.addCurve(to: p1, control1: cp1, control2: cp2)
        }
        
        if let lastX = barCenters.last {
            areaPath.addLine(to: CGPoint(x: lastX, y: size.height))
            areaPath.closeSubpath()
        }
        
        return (linePath, areaPath)
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
        
        innerLinesHeight = (totalHeight / CGFloat(totalLines - 1)) - 10
        
        if barCenters.count != xValues.count {
            barCenters = Array(repeating: 0, count: xValues.count)
        }
        
        
        let firstValuesCount = yValues.first?.count ?? 0
        
        if firstValuesCount == 1 {
            
            paddingLeading = 50
            
        }else if firstValuesCount == 2 {
            
            paddingLeading = 30
            
        }else if firstValuesCount == 3 {
            
            paddingLeading = 10
            
        }
        
        print("Max Value: \(maxValues), Max Value 1: \(maxValues1), Max Value 2: \(maxValues2), innerLinesHeight: \(innerLinesHeight), totalHeight: \(totalHeight)")
        
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
        
        let newYValues2 = yValues.map { dayArray in
            dayArray.map { group in
                group.map { bar in
                    bar.totalProgress > 0 ? bar.totalProgress + valueToAddAreaMark : 0
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
        
            //        print("Area Mark SwiftUI Colors: \(areaMarkSwiftUIColors)")/]
        
        print("Area Mark Data set list: \(areaMarkDataSetList)")
        
        isDataLoaded = true
        
    }
    
    func generateArray1(forX x: Int,maxValue: Double) -> [String] {
        let xValue = x
        
        var array = [Double](repeating: 1, count: totalLines)
        var stringArray: [String] = []
        
        let valueToAdd = (x - 1) / totalLines + 1
        
        print("Value to add: \(valueToAdd), X Value: \(xValue)")
        
        heightDivider = maxValue / Double((totalLines - 1))
        
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
    
        //    @Previewable @State var yValues: [[[EmojiChartView.BarChart]]] = [
        //
        //        [   // Mon
        //            []
        //
        //        ],
        //
        //        [   // Tue
        //            [.init(progress: 1, totalProgress: 1, color: "#7FD533", title: "Magnesium", type: "Supplement"),.init(progress: 1, totalProgress: 1, color: "#7FD533", title: "Magnesium", type: "Supplement")],
        //            [.init(progress: 1, totalProgress: 1, color: "#7FD533", title: "Magnesium", type: "Supplement"),.init(progress: 1, totalProgress: 1, color: "#7FD533", title: "Magnesium", type: "Supplement"),.init(progress: 1, totalProgress: 1, color: "#7FD533", title: "Magnesium", type: "Supplement")]
        //        ],
        //
        //        [   // Wed
        //            []
        //        ],
        //
        //        [   // Thu
        //            []
        //        ]
        //
        //    ]
    
    var xDataList: [String] = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]
        //    var xDataList: [String] = ["Mon", "Tue", "Wed", "Thu"]
    
    var areaLinesValues: [Double] = [2.0, 4.0, 1.0, 5.0, 1.0, 0.0, 1.0]
        //    var areaLinesValues: [Double] = [3.0, 4.0, 2.0, 5.0]
    
    EmojiChartView(
        chartType: .GroupStackChart,
        yDataList: $yValues,
        xDataList: xDataList,
        areaLinesValues: areaLinesValues,
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
    ).frame(height: 300)
    
}
