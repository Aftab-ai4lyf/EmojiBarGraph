//
//  EmojiStackBarChart.swift
//
//
//  Created by ai4lyf on 16/05/2024.
//

//import Foundation
//import SwiftUI
//import Charts
//
//@available(iOS 17.0, *)
//public struct EmojiStackBarChart: View {
//    
//    @Binding var yValues:[[EmojiChartView.BarChart]]
//    
//    var xValues:[String]
//    var showEmoji:Bool
//    var showYValues: Bool
//    var showLines: Bool
//    
//    var tempYValues:[[Int]] = [[0,0],[0,0],[0,0],[0,0],[0,0],[0,0],[0,0]]
//    @State var tempMaxYValues:[[Int]] = [[0,0],[0,0],[0,0],[0,0],[0,0],[0,0],[0,0]]
//    var tempXValues:[String] = ["Mon","Tue","Wed","Thu","Fri","Sat","Sun"]
//    
//    @State var dataSet:[String] = []
//    @State var dataSet1:[String] = ["0", "3", "6", "9", "12", "15", "18"]
//    
//    var valuesColor:Color = .black
//    var linesColor:Color = .black.opacity(0.50)
//    
//    var progressBGColor = Color.gray.opacity(0.40)
//    
//    var fontName = ""
//    
//    var yAxisTitle:String?
//    var yAxisTitleSize = 12
//    
//    var yAxisValuesSize = 12
//    
//    var emojiHeight = 8
//    var emojiWidth = 8
//    
//    var showAreaMark: Bool
//    
//    var arealinesColor: Color
//    var gradientColors: [Color]
//    
//    @State var heightDivider:Double = 0
//    @State var lastValue:Double = 0
//    
//    @State var mainMaxValue = 4
//
//    @State var textWidth:CGFloat = .zero
//    
//    @State var isError = false
//    @State var errorMessage = ""
//    
//    @State var isDataLoaded = false
//
//    @State var hadTitle = false
//    
//    public var body: some View {
//        
//        ZStack(alignment: .bottom) {
//            
//     
//        
//            VStack(spacing: 0) {
//                
//                
//                HStack(spacing: 0){
//                    
//                    
//                    
//                    if let title = yAxisTitle {
//                        
//                        if title != "" {
//                            
//                            Text(title)
//                                .font(.custom(fontName, size: CGFloat(yAxisTitleSize)))
//                                .rotationEffect(Angle(degrees: 270))
//                                .foregroundColor(valuesColor)
//                                .fixedSize()
//                                .frame(width: 20, height: 0)
//                                .onTapGesture {
//                                    
//                                    let i = yValues[1][1].totalProgress
//                                    yValues[1][1].totalProgress = i+1
//                                    
//                                }.onAppear{
//                                    
//                                    hadTitle = true
//                                    
//                                }
//                            
//                            
//                            
//                        }
//                        
//                    }
//                    
//                    VStack(spacing: 0){
//                        
//                        
//                        ForEach((0..<dataSet.count).reversed(),id: \.self){ i in
//                            
//                            HStack(spacing: 4) {
//                                if showYValues{
//                                    Text("\(dataSet[i])")
//                                        .font(.custom(fontName, size: CGFloat(yAxisTitleSize)))
//                                        .foregroundColor(valuesColor)
//                                        .frame(width: textWidth,height: 30,alignment: .trailing)
//                                } else{
//                                    Spacer()
//                                        .frame(width: 0,height: 30)
//                                        
//                                }
//                                
//                              Line()
//                                    .stroke(style: StrokeStyle(lineWidth: 0.5, dash: [2]))
//                                    .frame(height: 0.5)
//                                    .foregroundColor(linesColor)
//                                    .opacity(showLines ? 1 : 0)
//                                   
//                                
//                                    
//                                }
//                                
//                            }
//                            
//                        }
//                        
//                    
//                        .padding(.leading,hadTitle ? 8 : 0)
//                    
//                    
//                
//                
//            }
//                
//            }.overlay{
//                
//                Text(String(format: "%.1f" ,lastValue))
//                    .opacity(0)
//                    .font(.custom(fontName, size: CGFloat(yAxisTitleSize)))
//                    .background{
//                        
//                        GeometryReader { geo in
//                            
//                    
//                            
//                            Color.clear
//                                .onAppear{
//                                    
//                                    textWidth = CGFloat(geo.size.width)
//                                    
//                                    if(lastValue > 6){
//                                        
//                                        textWidth-=10
//                                        
//                                    }
//                                    
//                                }
//                            
//                        }
//                        
//                    }.id(lastValue)
//                
//            }
//            .overlay(alignment: .bottom) {
//                
//                if(!isError){
//                    // Center
//                    HStack(alignment: .bottom,spacing: 0) {
//                        
//                        var lastXValue = ""
//                        
//                        ForEach(0..<yValues.count,id: \.self){ i in
//                            
//                            let yValue = yValues[i]
//                            let xValue = xValues[i]
//                            
//                            Spacer()
//                            
//                            VStack(spacing: 0) {
//                                
//                                ZStack(alignment: .bottom){
//                                    
//                                    let totalMaxSum = Int(yValue.compactMap { $0 }.reduce(0) { $0 + $1.totalProgress })
//                                    let totalHeight = Double(30 * totalMaxSum)
//                                    
//                                    Capsule()
//                                        .frame(width: 12, height: totalHeight / heightDivider)
//                                        .foregroundColor(progressBGColor)
//                                    
//                                    
//                                    
//                                    VStack(spacing: 1) {
//                                        
//                                        Spacer()
//                                        
//                                        
//                                        ForEach(0..<yValue.count,id: \.self){ j in
//                                            
//                                            let maxValue = yValue[j].totalProgress
//                                            let progress = yValue[j].progress
//                                            let height = Double(30 * progress)
//                                            let color = yValue[j].color
//                                            
//                                            VStack{
//                                                
//                                                if(maxValue>0){
//                                                    
//                                                    Capsule()
//                                                        .frame(width: 12, height: height / heightDivider)
//                                                        .foregroundColor(Color(hex: color))
//                                                    
//                                                    
//                                                }
//                                                
//                                            }
//                                            
//                                            
//                                        }
//                                        
//                                    }
//                                    
//                                }.padding(.bottom,-20)
//                                
//                                
//                                if(lastXValue != xValue){
//                                    
//                                    Text("\n\n"+xValue)
//                                        .font(.custom(fontName, size: 12))
//                                        .padding(.bottom,-4)
//                                        .onAppear{
//                                            
//                                            lastXValue = xValue
//                                            
//                                        }
//                                    
//                                }
//                                
//                                
//                                
//                            }
//                            
//                            
//                            
//                            
//                        }
//                        
//                        
//                    }
//                    .padding(.leading, showYValues ? 16 : 0)
//              //      .padding(.leading,16)
//                      .id(mainMaxValue)
//                    
//                }else{
//                    
//                    HStack(alignment: .bottom,spacing: 0) {
//                        
//                        var lastXValue = ""
//                        
//                        ForEach(0..<tempYValues.count,id: \.self){ i in
//                            
//                            let yValue = tempYValues[i]
//                            let xValue = tempXValues[i]
//                            
//                            Spacer()
//                            
//                            VStack(spacing: 0) {
//                                
//                                HStack(alignment: .bottom,spacing: 4) {
//                                    
//                                    ForEach(0..<yValue.count,id: \.self){ j in
//                                        
//                                        let maxValue = tempMaxYValues[i][j]
//                                        let progress = yValue[j]
//                                        let height = Double(30 * maxValue)
//                                        
//                                        
//                                        
//                                        if(maxValue>0){
//                                            
//                                            
//                                          
//                                            
//                                        }
//                                        
//                                    }
//                                    
//                                }.padding(.bottom,-8)
//                                
//                                
//                                if(lastXValue != xValue){
//                                    
//                                    Text("\n\n"+xValue)
//                                        .font(.custom(fontName, size: 8))
//                                        .padding(.bottom,-4)
//                                        .onAppear{
//                                            
//                                            lastXValue = xValue
//                                            
//                                        }
//                                    
//                                }
//                                
//                                
//                                
//                            }
//                            
//                            
//                            
//                            
//                        }
//                        
//                        
//                    } .padding(.leading,28)
//                        .id(mainMaxValue)
//                        .onAppear{
//                            
//                            DispatchQueue.main.asyncAfter(deadline: .now()+0.5){
//                                
//                                mainMaxValue = 12
//                                
//                            }
//                            
//                            dataSet = ["0","2","4","6","8","10","12"]
//                            
//                        }
//                    
//                }
//                
//            }
//            .overlay(alignment: .center) {
//                
//                if(isError){
//                    
//                    HStack{
//                        
//                        Spacer()
//                        
//                        Text(errorMessage)
//                            .font(.custom(fontName, size: 14))
//                            .foregroundColor(.red)
//                            .multilineTextAlignment(.center)
//                        
//                        Spacer()
//                        
//                    }.padding(.horizontal)
//                        .padding(.leading,32)
//                }
//                
//                
//            }.overlay{
//                
//                let newYValues = yValues.enumerated().map{ index, barStack in
//                    
//                    return barStack.map(\.totalProgress).reduce(0, +) + 7
//                    
//                }
//                
//                
////                Chart {
////                    
////                    ForEach(0..<newYValues.count, id: \.self) { i in
////                        
////                        let progress = newYValues[i]
////                        
////                        LineMark(x: .value("Day", i), y: .value("Line",progress))
////                        
////                    }.interpolationMethod(.catmullRom)
////
////                    
////                       
////                }
////                .padding(.leading, showYValues ? 54 : 0)
////                
//                
//                
////                Chart {
////                    ForEach(0..<newYValues.count, id: \.self) { i in
////                        let progress = newYValues[i]
////                        LineMark(x: .value("Day", i), y: .value("Line", progress))
////                    }
////                    .interpolationMethod(.catmullRom)
////                    .foregroundColor(.red)
////                }
////                .chartPlotStyle { plot in
////                    plot
////                        .background(.clear)
////                }
////                .chartXAxis(.hidden)
////                .chartYAxis(.hidden)
////                .background(.clear)
////                .padding(.leading, showYValues ? 54 : 0)
////
////                
//                if showAreaMark {
//                    
//                    Chart {
//                       
//                        ForEach(0..<newYValues.count, id: \.self) { i in
//                            let progress = newYValues[i]
//                            AreaMark(
//                                x: .value("Day", i),
//                                y: .value("Line", progress)
//                            )
//                            .interpolationMethod(.catmullRom)
//                            .foregroundStyle(
//                                .linearGradient(
//                                                            colors: gradientColors,
//                                                            startPoint: .top,
//                                                            endPoint: .bottom
//                                                        )
//                                )
//                            
//                    }
//                        
//                        ForEach(0..<newYValues.count, id: \.self) { i in
//                            let progress = newYValues[i]
//                            LineMark(
//                                x: .value("Day", i),
//                                y: .value("Line", progress)
//                            )
//                            .interpolationMethod(.catmullRom)
//                            .foregroundStyle(arealinesColor)
//                        }
//                    }
//                    .chartPlotStyle { plot in
//                        plot.background(.clear)
//                    }
//                    .chartXAxis(.hidden)
//                    .chartYAxis(.hidden)
//                    .background(.clear)
//                    .padding(.leading, showYValues ? 54 : 0)
//                }
//                
////                    ForEach(0..<newYValues.count, id: \.self) { i in
////
////                        let progress = newYValues[i]
////
////                        AreaMark(x: .value("Day", i), yStart: .value("Line", 1), yEnd: .value("Line",progress))
////
////                    }.interpolationMethod(.catmullRom)
//             
//                
//                
//                
//                
//                
////                GeometryReader { geo in
////                    if showAreaMark {
////                        let chartWidth = geo.size.width
////                        let chartHeight = geo.size.height
////                        
////                        let barCount = yValues.count
////                        let stepX = chartWidth / CGFloat(barCount)
////                        
////                        let maxTotalProgress = yValues.map {
////                            $0.map(\.totalProgress).reduce(0, +)
////                        }.max() ?? 1
////                        
////                        
////                        
////                        
////                        let curvePoints: [CGPoint] = yValues.enumerated().map { index, barStack in
////                            let total = barStack.map(\.totalProgress).reduce(0, +)
////                            let normalized = CGFloat(total) / CGFloat(maxTotalProgress)
////                            let x = stepX * (CGFloat(index) + 0.5)
////                            
////                            // Dynamic offset: 4% of chart height, scaled slightly by normalized
////                            let baseOffset = chartHeight * 0.04 // Base offset (e.g., 8 for chartHeight = 200)
////                            let dynamicOffset = baseOffset * (1 + 0.3 * normalized) // Adjust offset based on normalized
////                            
////                            // Special offset for the last point
////                            let finalOffset = index == yValues.count - 1 ? chartHeight * 0.06 : dynamicOffset
////                            let y = chartHeight * (1 - normalized) - finalOffset
////                            
////                            // Dynamic x adjustment for the last point
////                            let finalX = index == yValues.count - 1 ? x + chartHeight * 0.04 : x
////                            
////                            return CGPoint(x: finalX, y: y)
////                        }
////                        
////                        SmoothSpline(points: curvePoints)
////                            .stroke(Color.purple.opacity(0.8), lineWidth: 2.5)
////                            .offset(x: 25)
////                        
////                        SmoothSpline(points: curvePoints, isFilled: true)
////                            .fill(
////                                LinearGradient(colors: [.purple.opacity(0.25), .clear],
////                                               startPoint: .top,
////                                               endPoint: .bottom)
////                            )
////                            .offset(x: 25)
////                    }
////                }
//            }
//        }.padding()
//            .onChange(of: yValues) { oldValue, newValue in
//                
//                validate()
//                
//                
//            }.onAppear{
//                
//                validate()
//                
//                
//                
//            }
//        
//        
//    }
//    
//    
//    //MARK: - Validate
//    // ViewBuilder
//    
//    func validate(){
//        
//        withAnimation {
//            
//            isDataLoaded = false
//            
//        }
//        
//        
//        let xValuesCount = xValues.count
//        let yValuesCount = yValues.count
//        
//        if(xValuesCount != yValuesCount){
//            
//            withAnimation {
//                
//                isError = true
//                errorMessage = "X and Y values had different size"
//                
//            }
//            
//        }else if((xValuesCount == yValuesCount)){
//            
//            
//            if(!isError){
//                
//                findMaxValue()
//                
//            }
//            
//            
//        }
//        
//        
//        
//    }
//    
//    //ViewBuilder .....>
//    //MARK: - FindMaxValue
//    
//    
//     func findMaxValue(){
//         
//        let maxValues1 = yValues.flatMap { $0.map { $0.totalProgress } }.max() ?? 0
//        let maxValues2 = yValues.flatMap { $0.map { $0.progress } }.max() ?? 0
//        
//        var maxValues = 0.0
//        
//        if(maxValues1>maxValues2){
//            
//            maxValues = maxValues1
//            
//        }else{
//            
//            maxValues = maxValues2
//            
//        }
//         
//        
//        withAnimation {
//            
//            if maxValues >= 6 {
//                
//                mainMaxValue = Int(maxValues)
//                
//            }else if(maxValues > 3 && maxValues < 6){
//                
//                mainMaxValue = Int(maxValues)
//                
//            }else{
//                
//                mainMaxValue = 3
//                
//            }
//            
//        }
//        
//        dataSet.removeAll()
//        
//        dataSet = generateArray1(forX: mainMaxValue)
//
//          
//        lastValue = Double(dataSet[dataSet.count - 1]) ?? 0.0
//       
//        
//        self.mainMaxValue = Int(lastValue)
//         
//         
//        
//        isDataLoaded = true
//        
//        
//    }
//    
//    //ViewBuilder ...>
//    //MARK: GenerateArray
//    
//    func generateArray1(forX x: Int) -> [String] {
//        
//        let xValue = x
//        
//        var array = [Double](repeating: 1, count: 7)
//        var stringArray:[String] = []
//        
//        let valueToAdd = (x - 1) / 5
//        
//        
//        
//        if(xValue == 3){
//            
//            stringArray.removeAll()
//            
//            let parts = 6
//            
//            heightDivider = Double(0.5)
//            
//            let step = Double(xValue) / Double(parts)
//            
//            for i in 0...parts {
//                
//                let value = step * Double(i)
//                
//                stringArray.append(String(format: "%.1f" ,value))
//                
//            }
//            
//            
//        }else if(xValue > 3 && xValue < 6){
//            
//            stringArray.removeAll()
//            
//            let parts = 6
//            
//            let step = Double(xValue) / Double(parts)
//            
//            
//            if(xValue == 4){
//                
//                heightDivider = 0.673
//                
//            }else if(xValue == 5){
//                
//                heightDivider = 0.842
//                
//            }
//            
//            for i in 0...parts {
//                
//                let value = step * Double(i)
//                
//                stringArray.append(String(format: "%.1f" ,value))
//                
//            }
//            
//            
//        }else{
//             
//            print("we")
//            heightDivider = Double(valueToAdd + 1)
//            
//            for i in 0..<array.count {
//                
//                var oldValue = array[i]
//                
//                if i > 0 {
//                    
//                    oldValue = array[i-1]
//                    oldValue += Double(valueToAdd)
//                    array[i] += oldValue
//                    
//                    stringArray.append(String(format: "%.0f" ,array[i]))
//                    
//                } else {
//                    
//                    array[i] = 0
//                    stringArray.append("0")
//                }
//                
//            }
//            
//            print("array",array)
//            
//        }
//        
//        
//        
//        return stringArray
//    }
//    
//    
//
//    func generateArray2(forX x: Int) -> [Int] {
//        var array = [Int](repeating: 1, count: 7) // Initializing an array with six 1s
//        
//        // Determine the value to add based on the value of x
//        let valueToAdd: Int
//        switch x {
//        case 4, 5, 6: valueToAdd = 0 // Difference 0
//        case 7...11: valueToAdd = 1 // Difference 2
//        case 12...17: valueToAdd = 2 // Difference 3
//        case 18...23: valueToAdd = 3 // Difference 4
//        case 24...29: valueToAdd = 4 // Difference 5
//        case 30...35: valueToAdd = 5 // Difference 6
//        case 36...39: valueToAdd = 6 // Difference 7
//        case 40...45: valueToAdd = 7 // Difference 8
//        case 46...49: valueToAdd = 8 // Difference 9
//        case 50...55: valueToAdd = 9 // Difference 10
//        case 56...59: valueToAdd = 10 // Difference 11
//        case 60...65: valueToAdd = 11 // Difference 12
//        case 66...69: valueToAdd = 12 // Difference 13
//        case 70...75: valueToAdd = 13 // Difference 14
//        case 76...79: valueToAdd = 14 // Difference 15
//        case 80...85: valueToAdd = 15 // Difference 16
//        case 86...89: valueToAdd = 16 // Difference 17
//        case 90...95: valueToAdd = 17 // Difference 18
//        case 96...99: valueToAdd = 18 // Difference 19
//        case 100...105: valueToAdd = 19 // Difference 20
//        case 106...109: valueToAdd = 20 // Difference 21
//        default: valueToAdd = 0
//            
//        }
//        
//        heightDivider = Double(valueToAdd+1)
//        
//        // Update the array elements with the computed value
//        for i in 0..<array.count {
//            
//            var oldValue = array[i]
//            
//            if i > 0 {
//                
//                oldValue = array[i-1]
//                oldValue+=valueToAdd
//                array[i]+=oldValue
//                
//            }else{
//                
//                array[i] = 0
//                
//            }
//            
//        }
//        
//        print("array",array)
//        
//        return array
//    }
//}
//
//
//@available(iOS 17.0, *)
//
//#Preview {
//    @State var yValues:[[EmojiChartView.BarChart]] = [
//        [.init(progress: 3,totalProgress: 8,color: "#2893D7"), .init(progress: 2,totalProgress: 3,color: "#BD013C",emoji: "love")],
//        [.init(progress: 8,totalProgress: 8,color: "#2893D7"), .init(progress: 2,totalProgress: 2,color: "#BD013C",emoji: "love")],
//        [.init(progress: 4,totalProgress: 4,color: "#2893D7"), .init(progress: 1,totalProgress: 3,color: "#BD013C",emoji: "love")],
//        [.init(progress: 5,totalProgress: 5,color: "#2893D7"), .init(progress: 3,totalProgress: 5,color: "#BD013C",emoji: "love")],
//        [.init(progress: 6,totalProgress: 6,color: "#2893D7"), .init(progress: 2,totalProgress: 6,color: "#BD013C",emoji: "love")],
//        [.init(progress: 7,totalProgress: 7,color: "#2893D7"), .init(progress: 4,totalProgress: 5,color: "#BD013C",emoji: "love")],
//        [.init(progress: 8,totalProgress: 8,color: "#2893D7"), .init(progress: 3,totalProgress: 3,color: "#BD013C",emoji: "love")]
//    ]
//    var xDataList: [String] = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]
//    EmojiChartView(
//        chartType: .StackChart,
//        yDataList: $yValues,
//        xDataList: xDataList,
//        showEmoji: true,
//        showYValues: true,
//        showLines: true,
//    showAreaMark: true,
//        yAxisTitle: .none,
//        valuesColor: .black,
//        linesColor: .black,
//        arealinesColor: .black.opacity(0.4),
//           gradientColors: [.purple.opacity(0.4), .clear]
//    )
//    
//    
//}
//
////MARK: - SmoothSpline
//// ViewBuilder : -
//
//@available(iOS 17.0, *)
//struct SmoothSpline: Shape {
//    var points: [CGPoint]
//    var isFilled: Bool = false
//
//    func path(in rect: CGRect) -> Path {
//        guard points.count > 1 else { return Path() }
//
//        var path = Path()
//
//        if isFilled {
//            path.move(to: CGPoint(x: points[0].x, y: rect.height))
//            path.addLine(to: points[0])
//        } else {
//            path.move(to: points[0])
//        }
//
//        for i in 0..<points.count - 1 {
//            let p0 = i > 0 ? points[i - 1] : points[i]
//            let p1 = points[i]
//            let p2 = points[i + 1]
//            let p3 = i + 2 < points.count ? points[i + 2] : p2
//
//            let tension: CGFloat = 0.4
//            let cp1 = CGPoint(
//                x: p1.x + (p2.x - p0.x) / 6 * tension,
//                y: p1.y + (p2.y - p0.y) / 6 * tension
//            )
//            let cp2 = CGPoint(
//                x: p2.x - (p3.x - p1.x) / 6 * tension,
//                y: p2.y - (p3.y - p1.y) / 6 * tension
//            )
//
//            path.addCurve(to: p2, control1: cp1, control2: cp2)
//        }
//
//        if isFilled {
//            path.addLine(to: CGPoint(x: points.last!.x, y: rect.height))
//            path.closeSubpath()
//        }
//
//        return path
//    }
//}
//
////Extension
//
//@available(iOS 17.0, *)
//extension EmojiStackBarChart {
//    // ViewBuilder
//    func setYAxisTitle(_ title: String) -> EmojiStackBarChart {
//        EmojiStackBarChart(
//            yValues: $yValues,
//            xValues: xValues,
//            showEmoji: showEmoji,
//            showYValues: showYValues,
//            showLines: showLines,
//            yAxisTitle: title,
//            showAreaMark: showAreaMark,
//            arealinesColor: arealinesColor,
//            gradientColors:gradientColors
//        )
//    }
//    // ViewBuilder
//    func setValuesColor(_ color: Color) -> EmojiStackBarChart {
//        EmojiStackBarChart(
//            yValues: $yValues,
//            xValues: xValues,
//            showEmoji: showEmoji,
//            showYValues: showYValues,
//            showLines: showLines,
//            valuesColor: color,
//            yAxisTitle: yAxisTitle,
//            showAreaMark: showAreaMark,
//            arealinesColor: arealinesColor,
//            gradientColors:gradientColors
//            
//        )
//    }
//    // ViewBuilder
//    func setLinesColor(_ color: Color) -> EmojiStackBarChart {
//        EmojiStackBarChart(
//            yValues: $yValues,
//            xValues: xValues,
//            showEmoji: showEmoji,
//            showYValues: showYValues,
//            showLines: showLines,
//            valuesColor: valuesColor,
//            linesColor: color,
//            yAxisTitle: yAxisTitle,
//            showAreaMark: showAreaMark,
//            arealinesColor: arealinesColor,
//            gradientColors:gradientColors
//        )
//    }
//    // ViewBuilder
//    func setAreaMarkColor(_ color: Color) -> EmojiStackBarChart {
//        EmojiStackBarChart(
//            yValues: $yValues,
//            xValues: xValues,
//            showEmoji: showEmoji,
//            showYValues: showYValues,
//            showLines: showLines,
//            valuesColor: valuesColor,
//            linesColor: linesColor,
//            showAreaMark: showAreaMark,
//            arealinesColor: color ,
//            gradientColors:gradientColors
//            )
//    }
//    // ViewBuilder
//    func setBarBackgroundColor(_ color: Color) -> EmojiStackBarChart {
//        EmojiStackBarChart(
//            yValues: $yValues,
//            xValues: xValues,
//            showEmoji: showEmoji,
//            showYValues: showYValues,
//            showLines: showLines,
//            valuesColor: valuesColor,
//            linesColor: linesColor,
//            progressBGColor: color,
//            yAxisTitle: yAxisTitle,
//            showAreaMark: showAreaMark ,
//            arealinesColor: arealinesColor,
//            gradientColors:gradientColors
//        )
//    }
//    // ViewBuilder
//    func setFontName(_ name: String) -> EmojiStackBarChart {
//        EmojiStackBarChart(
//            yValues: $yValues,
//            xValues: xValues,
//            showEmoji: showEmoji,
//            showYValues: showYValues,
//            showLines: showLines,
//            valuesColor: valuesColor,
//            linesColor: linesColor,
//            progressBGColor: progressBGColor,
//            fontName: name,
//            yAxisTitle: yAxisTitle,
//            showAreaMark: showAreaMark ,
//            arealinesColor: arealinesColor ,
//            gradientColors:gradientColors
//        )
//    }
//    // ViewBuilder
//    func setYAxisTitleSize(_ size: Int) -> EmojiStackBarChart {
//        EmojiStackBarChart(
//            yValues: $yValues,
//            xValues: xValues,
//            showEmoji: showEmoji,
//            showYValues: showYValues,
//            showLines: showLines,
//            valuesColor: valuesColor,
//            linesColor: linesColor,
//            progressBGColor: progressBGColor,
//            fontName: fontName,
//            yAxisTitle: yAxisTitle,
//            yAxisTitleSize: size ,
//            showAreaMark: showAreaMark,
//            arealinesColor: arealinesColor ,
//            gradientColors:gradientColors
//        )
//    }
//    // ViewBuilder
//    func setYAxisValuesSize(_ size: Int) -> EmojiStackBarChart {
//        EmojiStackBarChart(
//            yValues: $yValues,
//            xValues: xValues,
//            showEmoji: showEmoji,
//            showYValues: showYValues,
//            showLines: showLines,
//            valuesColor: valuesColor,
//            linesColor: linesColor,
//            progressBGColor: progressBGColor,
//            fontName: fontName,
//            yAxisTitle: yAxisTitle,
//            yAxisTitleSize: yAxisTitleSize,
//            yAxisValuesSize: size ,
//            showAreaMark: showAreaMark ,
//            arealinesColor: arealinesColor ,
//            gradientColors:gradientColors
//        )
//    }
//    // ViewBuilder
//    func setEmojiHeight(_ size: Int) -> EmojiStackBarChart {
//        EmojiStackBarChart(
//            yValues: $yValues,
//            xValues: xValues,
//            showEmoji: showEmoji,
//            showYValues: showYValues,
//            showLines: showLines,
//            valuesColor: valuesColor,
//            linesColor: linesColor,
//            progressBGColor: progressBGColor,
//            fontName: fontName,
//            yAxisTitle: yAxisTitle,
//            yAxisTitleSize: yAxisTitleSize,
//            yAxisValuesSize: yAxisValuesSize,
//            emojiHeight: size ,
//            showAreaMark: showAreaMark ,
//            arealinesColor: arealinesColor ,
//            gradientColors:gradientColors
//        )
//    }
//    // ViewBuilder
//    func setEmojiWidth(_ size: Int) -> EmojiStackBarChart {
//        EmojiStackBarChart(
//            yValues: $yValues,
//            xValues: xValues,
//            showEmoji: showEmoji,
//            showYValues: showYValues,
//            showLines: showLines,
//            valuesColor: valuesColor,
//            linesColor: linesColor,
//            progressBGColor: progressBGColor,
//            fontName: fontName,
//            yAxisTitle: yAxisTitle,
//            yAxisTitleSize: yAxisTitleSize,
//            yAxisValuesSize: yAxisValuesSize,
//            emojiHeight: emojiHeight,
//            emojiWidth: size ,
//            showAreaMark: showAreaMark ,
//            arealinesColor: arealinesColor ,
//            gradientColors:gradientColors
//        )
//    }
//    
//    // ViewBuilder
//    // MARK: - Values Color Clear
//    func showYValues(_ show: Bool) -> EmojiStackBarChart {
//            EmojiStackBarChart(
//                yValues: $yValues,
//                xValues: xValues,
//                showEmoji: showEmoji,
//                showYValues: show,
//                showLines: showLines,
//                valuesColor: valuesColor,
//                linesColor: linesColor,
//                progressBGColor: progressBGColor,
//                fontName: fontName,
//                yAxisTitle: yAxisTitle,
//                yAxisTitleSize: yAxisTitleSize,
//                yAxisValuesSize: yAxisValuesSize,
//                emojiHeight: emojiHeight,
//                emojiWidth: emojiWidth ,
//                showAreaMark: showAreaMark ,
//                arealinesColor: arealinesColor ,
//                gradientColors:gradientColors
//            )
//        }
//    
//    // ViewBuilder
//    // MARK: - Lines Color Clear
//    func showLines(_ show: Bool) -> EmojiStackBarChart {
//        EmojiStackBarChart(
//            yValues: $yValues,
//            xValues: xValues,
//            showEmoji: showEmoji,
//            showYValues: showYValues,
//            showLines: show,
//            valuesColor: valuesColor,
//            linesColor: .clear,
//            progressBGColor: progressBGColor,
//            fontName: fontName,
//            yAxisTitle: yAxisTitle,
//            yAxisTitleSize: yAxisTitleSize,
//            yAxisValuesSize: yAxisValuesSize,
//            emojiHeight: emojiHeight,
//            emojiWidth: emojiWidth ,
//            showAreaMark: showAreaMark ,
//            arealinesColor: arealinesColor ,
//            gradientColors:gradientColors
//        )
//    }
//
//}
//
//


import Foundation
import SwiftUI
import Charts

@available(iOS 17.0, *)
public struct EmojiStackBarChart: View {
    
    @Binding var yValues: [[EmojiChartView.BarChart]]
    
    var xValues: [String]
    var showEmoji: Bool
    var showYValues: Bool
    var showLines: Bool
    
    var tempYValues: [[Int]] = [[0,0],[0,0],[0,0],[0,0],[0,0],[0,0],[0,0]]
    @State var tempMaxYValues: [[Int]] = [[0,0],[0,0],[0,0],[0,0],[0,0],[0,0],[0,0]]
    var tempXValues: [String] = ["Mon","Tue","Wed","Thu","Fri","Sat","Sun"]
    
    @State var dataSet: [String] = []
    @State var dataSet1: [String] = ["0", "3", "6", "9", "12", "15", "18"]
    
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
    
    @State var heightDivider: Double = 0
    @State var lastValue: Double = 0
    
    @State var mainMaxValue = 4
    
    @State var textWidth: CGFloat = .zero
    
    @State var isError = false
    @State var errorMessage = ""
    
    @State var isDataLoaded = false
    
    @State var hadTitle = false
    
    public var body: some View {
        ZStack(alignment: .bottom) {
            yAxisView()
                .padding(.leading, hadTitle ? 8 : 0)
                .overlay { yAxisTextWidthOverlay() }
                .overlay(alignment: .bottom) { barsView() }
                .overlay(alignment: .center) { errorView() }
                .overlay { areaMarkView() }
        }
        .padding()
        .onChange(of: yValues) { oldValue, newValue in
            validate()
        }
        .onAppear {
            validate()
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
                        }
                        .onAppear {
                            hadTitle = true
                        }
                }
                VStack(spacing: 0) {
                    ForEach((0..<dataSet.count).reversed(), id: \.self) { i in
                        HStack(spacing: 4) {
                            if showYValues {
                                Text("\(dataSet[i])")
                                    .font(.custom(fontName, size: CGFloat(yAxisTitleSize)))
                                    .foregroundColor(valuesColor)
                                    .frame(width: textWidth, height: 30, alignment: .trailing)
                            } else {
                                Spacer()
                                    .frame(width: 0, height: 30)
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
                            if lastValue > 6 {
                                textWidth -= 10
                            }
                        }
                }
            }
            .id(lastValue)
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
                        ZStack(alignment: .bottom) {
                            let totalMaxSum = Int(yValue.compactMap { $0 }.reduce(0) { $0 + $1.totalProgress })
                            let totalHeight = Double(30 * totalMaxSum)
                            Capsule()
                                .frame(width: 12, height: totalHeight / heightDivider)
                                .foregroundColor(progressBGColor)
                            VStack(spacing: 1) {
                                Spacer()
                                ForEach(0..<yValue.count, id: \.self) { j in
                                    let maxValue = yValue[j].totalProgress
                                    let progress = yValue[j].progress
                                    let height = Double(30 * progress)
                                    let color = yValue[j].color
                                    VStack {
                                        if maxValue > 0 {
                                            Capsule()
                                                .frame(width: 12, height: height / heightDivider)
                                                .foregroundColor(Color(hex: color))
                                        }
                                    }
                                }
                            }
                        }
                        .padding(.bottom, -20)
                        if lastXValue != xValue {
                            Text("\n\n" + xValue)
                                .font(.custom(fontName, size: 12))
                                .padding(.bottom, -4)
                                .onAppear {
                                    lastXValue = xValue
                                }
                        }
                    }
                }
            }
            .padding(.leading, showYValues ? 16 : 0)
            .id(mainMaxValue)
        } else {
            HStack(alignment: .bottom, spacing: 0) {
                var lastXValue = ""
                ForEach(0..<tempYValues.count, id: \.self) { i in
                    let yValue = tempYValues[i]
                    let xValue = tempXValues[i]
                    Spacer()
                    VStack(spacing: 0) {
                        HStack(alignment: .bottom, spacing: 4) {
                            ForEach(0..<yValue.count, id: \.self) { j in
                                let maxValue = tempMaxYValues[i][j]
                                let progress = yValue[j]
                                let height = Double(30 * maxValue)
                                if maxValue > 0 {
                                    // Placeholder for empty branch as per original
                                }
                            }
                        }
                        .padding(.bottom, -8)
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
            }
            .padding(.leading, 28)
            .id(mainMaxValue)
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    mainMaxValue = 12
                }
                dataSet = ["0", "2", "4", "6", "8", "10", "12"]
            }
        }
    }
    
    // MARK: - Error View
    
    @ViewBuilder
    private func errorView() -> some View {
        if isError {
            HStack {
                Spacer()
                Text(errorMessage)
                    .font(.custom(fontName, size: 14))
                    .foregroundColor(.red)
                    .multilineTextAlignment(.center)
                Spacer()
            }
            .padding(.horizontal)
            .padding(.leading, 32)
        }
    }
    
    // MARK: - Area Mark View
    
    @ViewBuilder
    private func areaMarkView() -> some View {
        let newYValues = yValues.enumerated().map { index, barStack in
            barStack.map(\.totalProgress).reduce(0, +) + 7
        }
        if showAreaMark {
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
                }
                ForEach(0..<newYValues.count, id: \.self) { i in
                    let progress = newYValues[i]
                    LineMark(
                        x: .value("Day", i),
                        y: .value("Line", progress)
                    )
                    .interpolationMethod(.catmullRom)
                    .foregroundStyle(arealinesColor)
                }
            }
            .chartPlotStyle { plot in
                plot.background(.clear)
            }
            .chartXAxis(.hidden)
            .chartYAxis(.hidden)
            .background(.clear)
            .padding(.leading, showYValues ? 50 : 40)
        }
    }
    
    // MARK: - Validate
    
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
    
    // MARK: - Find Max Value
    
    func findMaxValue() {
        let maxValues1 = yValues.flatMap { $0.map { $0.totalProgress } }.max() ?? 0
        let maxValues2 = yValues.flatMap { $0.map { $0.progress } }.max() ?? 0
        var maxValues = 0.0
        if maxValues1 > maxValues2 {
            maxValues = maxValues1
        } else {
            maxValues = maxValues2
        }
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
        isDataLoaded = true
    }
    
    // MARK: - Generate Array
    
    func generateArray1(forX x: Int) -> [String] {
        let xValue = x
        var array = [Double](repeating: 1, count: 7)
        var stringArray: [String] = []
        let valueToAdd = (x - 1) / 5
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
            print("we")
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
    
    func generateArray2(forX x: Int) -> [Int] {
        var array = [Int](repeating: 1, count: 7)
        let valueToAdd: Int
        switch x {
        case 4, 5, 6: valueToAdd = 0
        case 7...11: valueToAdd = 1
        case 12...17: valueToAdd = 2
        case 18...23: valueToAdd = 3
        case 24...29: valueToAdd = 4
        case 30...35: valueToAdd = 5
        case 36...39: valueToAdd = 6
        case 40...45: valueToAdd = 7
        case 46...49: valueToAdd = 8
        case 50...55: valueToAdd = 9
        case 56...59: valueToAdd = 10
        case 60...65: valueToAdd = 11
        case 66...69: valueToAdd = 12
        case 70...75: valueToAdd = 13
        case 76...79: valueToAdd = 14
        case 80...85: valueToAdd = 15
        case 86...89: valueToAdd = 16
        case 90...95: valueToAdd = 17
        case 96...99: valueToAdd = 18
        case 100...105: valueToAdd = 19
        case 106...109: valueToAdd = 20
        default: valueToAdd = 0
        }
        heightDivider = Double(valueToAdd + 1)
        for i in 0..<array.count {
            var oldValue = array[i]
            if i > 0 {
                oldValue = array[i-1]
                oldValue += valueToAdd
                array[i] += oldValue
            } else {
                array[i] = 0
            }
        }
        print("array", array)
        return array
    }
}

// MARK: - SmoothSpline

@available(iOS 17.0, *)
struct SmoothSpline: Shape {
    var points: [CGPoint]
    var isFilled: Bool = false

    func path(in rect: CGRect) -> Path {
        guard points.count > 1 else { return Path() }

        var path = Path()

        if isFilled {
            path.move(to: CGPoint(x: points[0].x, y: rect.height))
            path.addLine(to: points[0])
        } else {
            path.move(to: points[0])
        }

        for i in 0..<points.count - 1 {
            let p0 = i > 0 ? points[i - 1] : points[i]
            let p1 = points[i]
            let p2 = points[i + 1]
            let p3 = i + 2 < points.count ? points[i + 2] : p2

            let tension: CGFloat = 0.4
            let cp1 = CGPoint(
                x: p1.x + (p2.x - p0.x) / 6 * tension,
                y: p1.y + (p2.y - p0.y) / 6 * tension
            )
            let cp2 = CGPoint(
                x: p2.x - (p3.x - p1.x) / 6 * tension,
                y: p2.y - (p3.y - p1.y) / 6 * tension
            )

            path.addCurve(to: p2, control1: cp1, control2: cp2)
        }

        if isFilled {
            path.addLine(to: CGPoint(x: points.last!.x, y: rect.height))
            path.closeSubpath()
        }

        return path
    }
}

// MARK: - Extension

@available(iOS 17.0, *)
extension EmojiStackBarChart {
    func setYAxisTitle(_ title: String) -> EmojiStackBarChart {
        EmojiStackBarChart(
            yValues: $yValues,
            xValues: xValues,
            showEmoji: showEmoji,
            showYValues: showYValues,
            showLines: showLines,
            yAxisTitle: title,
            showAreaMark: showAreaMark,
            arealinesColor: arealinesColor,
            gradientColors: gradientColors
        )
    }
    
    func setValuesColor(_ color: Color) -> EmojiStackBarChart {
        EmojiStackBarChart(
            yValues: $yValues,
            xValues: xValues,
            showEmoji: showEmoji,
            showYValues: showYValues,
            showLines: showLines,
            valuesColor: color,
            yAxisTitle: yAxisTitle,
            showAreaMark: showAreaMark,
            arealinesColor: arealinesColor,
            gradientColors: gradientColors
        )
    }
    
    func setLinesColor(_ color: Color) -> EmojiStackBarChart {
        EmojiStackBarChart(
            yValues: $yValues,
            xValues: xValues,
            showEmoji: showEmoji,
            showYValues: showYValues,
            showLines: showLines,
            valuesColor: valuesColor,
            linesColor: color,
            yAxisTitle: yAxisTitle,
            showAreaMark: showAreaMark,
            arealinesColor: arealinesColor,
            gradientColors: gradientColors
        )
    }
    
    func setAreaMarkColor(_ color: Color) -> EmojiStackBarChart {
        EmojiStackBarChart(
            yValues: $yValues,
            xValues: xValues,
            showEmoji: showEmoji,
            showYValues: showYValues,
            showLines: showLines,
            valuesColor: valuesColor,
            linesColor: linesColor,
            showAreaMark: showAreaMark,
            arealinesColor: color,
            gradientColors: gradientColors
        )
    }
    
    func setBarBackgroundColor(_ color: Color) -> EmojiStackBarChart {
        EmojiStackBarChart(
            yValues: $yValues,
            xValues: xValues,
            showEmoji: showEmoji,
            showYValues: showYValues,
            showLines: showLines,
            valuesColor: valuesColor,
            linesColor: linesColor,
            progressBGColor: color,
            yAxisTitle: yAxisTitle,
            showAreaMark: showAreaMark,
            arealinesColor: arealinesColor,
            gradientColors: gradientColors
        )
    }
    
    func setFontName(_ name: String) -> EmojiStackBarChart {
        EmojiStackBarChart(
            yValues: $yValues,
            xValues: xValues,
            showEmoji: showEmoji,
            showYValues: showYValues,
            showLines: showLines,
            valuesColor: valuesColor,
            linesColor: linesColor,
            progressBGColor: progressBGColor,
            fontName: name,
            yAxisTitle: yAxisTitle,
            showAreaMark: showAreaMark,
            arealinesColor: arealinesColor,
            gradientColors: gradientColors
        )
    }
    
    func setYAxisTitleSize(_ size: Int) -> EmojiStackBarChart {
        EmojiStackBarChart(
            yValues: $yValues,
            xValues: xValues,
            showEmoji: showEmoji,
            showYValues: showYValues,
            showLines: showLines,
            valuesColor: valuesColor,
            linesColor: linesColor,
            progressBGColor: progressBGColor,
            fontName: fontName,
            yAxisTitle: yAxisTitle,
            yAxisTitleSize: size,
            showAreaMark: showAreaMark,
            arealinesColor: arealinesColor,
            gradientColors: gradientColors
        )
    }
    
    func setYAxisValuesSize(_ size: Int) -> EmojiStackBarChart {
        EmojiStackBarChart(
            yValues: $yValues,
            xValues: xValues,
            showEmoji: showEmoji,
            showYValues: showYValues,
            showLines: showLines,
            valuesColor: valuesColor,
            linesColor: linesColor,
            progressBGColor: progressBGColor,
            fontName: fontName,
            yAxisTitle: yAxisTitle,
            yAxisTitleSize: yAxisTitleSize,
            yAxisValuesSize: size,
            showAreaMark: showAreaMark,
            arealinesColor: arealinesColor,
            gradientColors: gradientColors
        )
    }
    
    func setEmojiHeight(_ size: Int) -> EmojiStackBarChart {
        EmojiStackBarChart(
            yValues: $yValues,
            xValues: xValues,
            showEmoji: showEmoji,
            showYValues: showYValues,
            showLines: showLines,
            valuesColor: valuesColor,
            linesColor: linesColor,
            progressBGColor: progressBGColor,
            fontName: fontName,
            yAxisTitle: yAxisTitle,
            yAxisTitleSize: yAxisTitleSize,
            yAxisValuesSize: yAxisValuesSize,
            emojiHeight: size,
            showAreaMark: showAreaMark,
            arealinesColor: arealinesColor,
            gradientColors: gradientColors
        )
    }
    
    func setEmojiWidth(_ size: Int) -> EmojiStackBarChart {
        EmojiStackBarChart(
            yValues: $yValues,
            xValues: xValues,
            showEmoji: showEmoji,
            showYValues: showYValues,
            showLines: showLines,
            valuesColor: valuesColor,
            linesColor: linesColor,
            progressBGColor: progressBGColor,
            fontName: fontName,
            yAxisTitle: yAxisTitle,
            yAxisTitleSize: yAxisTitleSize,
            yAxisValuesSize: yAxisValuesSize,
            emojiHeight: emojiHeight,
            emojiWidth: size,
            showAreaMark: showAreaMark,
            arealinesColor: arealinesColor,
            gradientColors: gradientColors
        )
    }
    
    func showYValues(_ show: Bool) -> EmojiStackBarChart {
        EmojiStackBarChart(
            yValues: $yValues,
            xValues: xValues,
            showEmoji: showEmoji,
            showYValues: show,
            showLines: showLines,
            valuesColor: valuesColor,
            linesColor: linesColor,
            progressBGColor: progressBGColor,
            fontName: fontName,
            yAxisTitle: yAxisTitle,
            yAxisTitleSize: yAxisTitleSize,
            yAxisValuesSize: yAxisValuesSize,
            emojiHeight: emojiHeight,
            emojiWidth: emojiWidth,
            showAreaMark: showAreaMark,
            arealinesColor: arealinesColor,
            gradientColors: gradientColors
        )
    }
    
    func showLines(_ show: Bool) -> EmojiStackBarChart {
        EmojiStackBarChart(
            yValues: $yValues,
            xValues: xValues,
            showEmoji: showEmoji,
            showYValues: showYValues,
            showLines: show,
            valuesColor: valuesColor,
            linesColor: .clear,
            progressBGColor: progressBGColor,
            fontName: fontName,
            yAxisTitle: yAxisTitle,
            yAxisTitleSize: yAxisTitleSize,
            yAxisValuesSize: yAxisValuesSize,
            emojiHeight: emojiHeight,
            emojiWidth: emojiWidth,
            showAreaMark: showAreaMark,
            arealinesColor: arealinesColor,
            gradientColors: gradientColors
        )
    }
}


@available(iOS 17.0, *)

#Preview {
    @State var yValues:[[EmojiChartView.BarChart]] = [
        [.init(progress: 3,totalProgress: 8,color: "#2893D7"), .init(progress: 2,totalProgress: 3,color: "#BD013C",emoji: "love")],
        [.init(progress: 8,totalProgress: 8,color: "#2893D7"), .init(progress: 2,totalProgress: 2,color: "#BD013C",emoji: "love")],
        [.init(progress: 4,totalProgress: 4,color: "#2893D7"), .init(progress: 1,totalProgress: 3,color: "#BD013C",emoji: "love")],
        [.init(progress: 5,totalProgress: 5,color: "#2893D7"), .init(progress: 3,totalProgress: 5,color: "#BD013C",emoji: "love")],
        [.init(progress: 6,totalProgress: 6,color: "#2893D7"), .init(progress: 2,totalProgress: 6,color: "#BD013C",emoji: "love")],
        [.init(progress: 7,totalProgress: 7,color: "#2893D7"), .init(progress: 4,totalProgress: 5,color: "#BD013C",emoji: "love")],
        [.init(progress: 2,totalProgress: 2,color: "#2893D7"), .init(progress: 3,totalProgress: 3,color: "#BD013C",emoji: "love")]
    ]
    var xDataList: [String] = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]
    EmojiChartView(
        chartType: .StackChart,
        yDataList: $yValues,
        xDataList: xDataList,
        showEmoji: true,
        showYValues: true,
        showLines: true,
    showAreaMark: true,
        yAxisTitle: .none,
        valuesColor: .black,
        linesColor: .black,
        arealinesColor: .black.opacity(0.4),
           gradientColors: [.purple.opacity(0.4), .clear]
    )


}


