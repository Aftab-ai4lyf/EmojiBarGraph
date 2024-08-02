//
//  EmojiGroupBarChart.swift
//
//
//  Created by ai4lyf on 16/05/2024.
//

import Foundation
import SwiftUI

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

extension Double {
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}

@available(iOS 17.0, *)
public struct EmojiGroupBarChart: View {
    
    
    @Binding var yValues:[[EmojiChartView.BarChart]]
    var xValues:[String]
    var showEmoji:Bool
    
    var tempYValues:[[Int]] = [[0,0],[0,0],[0,0],[0,0]]
    @State var tempMaxYValues:[[Int]] = [[0,0],[0,0],[0,0],[0,0]]
    var tempXValues:[String] = ["15m","30m","45m","60m"]
    
    @State var dataSet:[String] = []
    
    var valuesColor:Color = .black
    var linesColor:Color = .black.opacity(0.50)
    
    var progressBGColor = Color.gray.opacity(0.40)
    
    var fontName = ""
    
    var yAxisTitle:String?
    var yAxisTitleSize = 12
    
    var yAxisValuesSize = 12
    
    var emojiHeight = 8
    var emojiWidth = 8

    @State var textWidth:CGFloat = .zero
    
    @State var heightDivider:Double = 0
    @State var lastValue:Double = 0
    
    @State var mainMaxValue = 4
    
    @State var isError = false
    @State var errorMessage = ""
    
    @State var isDataLoaded = false
    
    @State var showTooltip = false
    @State var tooltipJIndex = 0
    @State var tooltipIIndex = 0
    
    @State var xOffset:CGFloat = .zero
    @State var yOffset:CGFloat = .zero
    
    @State private var tooltipPosition: CGPoint = .zero

    @State var hadTitle = false

    @State var isAbbreviated = false
    
    public var body: some View {
        ZStack(alignment: .bottom) {
            
            VStack(spacing: 0) {
                
                HStack(spacing: 0){
                    
                    
                    if let title = yAxisTitle {
                        
                        if title != "" {
                            
                            Text(title)
                                .font(.custom(fontName, size: CGFloat(yAxisTitleSize)))
                                .rotationEffect(Angle(degrees: 270))
                                .foregroundColor(valuesColor)
                                .fixedSize()
                                .frame(width: 20, height: 0)
                                .onTapGesture {
                                    
                                    let i = yValues[1][1].totalProgress
                                    yValues[1][1].totalProgress = i+1
                                    
                                }.onAppear{
                                    
                                    hadTitle = true
                                    
                                }
                            
                            
                            
                        }
                        
                    }
                    
                    VStack(spacing: 0){
                        
                        
                        ForEach((0..<dataSet.count).reversed(),id: \.self){ i in
                            
                            HStack(spacing: 4) {
                                
                                Text("\(dataSet[i])")
                                    .font(.custom(fontName, size: CGFloat(yAxisTitleSize)))
                                    .foregroundColor(valuesColor)
                                    .frame(width: textWidth,height: 30,alignment: .trailing)
                                
                                Line()
                                    .stroke(style: StrokeStyle(lineWidth: 0.5, dash: [2]))
                                    .frame(height: 0.5)
                                    .foregroundColor(linesColor)
                                
                                
                            }
                            
                        }
                        
                    }.padding(.leading,hadTitle ? 8 : 0)
                    
                    
                }
                
                
                
            }.overlay{
                
                Text(String(format: "%.1f" ,lastValue))
                    .opacity(0)
                    .font(.custom(fontName, size: CGFloat(yAxisTitleSize)))
                    .background{
                        
                        GeometryReader { geo in
                            
                            Color.clear
                                .onAppear{
                                    
                                    textWidth = CGFloat(geo.size.width)
                                    
                                     if(isAbbreviated){
                                        
                                        textWidth-=10
                                        
                                    }
                                    
                                }
                            
                        }
                        
                    }.id(lastValue)
                
            }
            .overlay(alignment: .bottom) {
                
                if(!isError){
                    
                    HStack(alignment: .bottom,spacing: 0) {
                        
                        var lastXValue = ""
                        
                        ForEach(0..<yValues.count,id: \.self){ i in
                            
                            let yValue = yValues[i]
                            let xValue = xValues[i]
                            
                            Spacer()
                            
                            VStack(spacing: 0) {
                                
                                HStack(alignment: .bottom,spacing: 4) {
                                    
                                    ForEach(0..<yValue.count,id: \.self){ j in
                                        
                                        let maxValue = yValue[j].totalProgress
                                        let progress = yValue[j].progress
                                        //                                        let height = Double(30 * progress > maxValue ? progress : maxValue)
                                        let height = Double(30 * max(progress, maxValue))
                                        let progressColor = yValue[j].color
                                        let emoji = yValue[j].emoji
                                        let title = yValue[j].title
                                        
                                        if(maxValue>0){
                                            
                                            GeometryReader{ geometry in
                                                
                                                VStack{
                                                    
                                                    Spacer()
                                                   VerticalProgressBar(progress: Double(progress) / Double(maxValue),totalProgress: maxValue
                                                                        , width: 8, height: height / heightDivider
                                                                        ,progressColor: progressColor
                                                                        ,progressBGColor: progressBGColor
                                                                        ,j:j
                                                                        ,i:i,
                                                                        minValue:progress,
                                                                        maxValue:maxValue
                                                                        ,xValue:xValue
                                                                        ,title:title
                                                                        ,fontName:fontName,
                                                                        tooltipJIndex:$tooltipJIndex,
                                                                        tooltipIIndex:$tooltipIIndex,
                                                                        showToolTip: $showTooltip,
                                                                        totalYValues: $totalYValues)
                                                    .zIndex(Double(-j))
                                                    .overlay(alignment: .top) {
                                                        
                                                        if(showEmoji){
                                                            
                                                            Image(emoji)
                                                                .resizable()
                                                                .frame(width: CGFloat(emojiWidth), height: CGFloat(emojiHeight))
                                                                .padding(.top,-10)
                                                            
                                                            
                                                        }
                                                        
                                                    }
                                                    .onTapGesture{
                                                        
                                                        withAnimation {
                                                            
                                                            tooltipJIndex = j
                                                            tooltipIIndex = i
                                                            showTooltip = true
                                                            
                                                        }
                                                        
                                                        
                                                    }
                                                    
                                                }
                                                
                                            }.frame(width: 8, height:  height / heightDivider + 16)
                                            
                                            
                                            
                                        }
                                        
                                    }
                                    
                                }.padding(.bottom,-8)
                                
                                
                                if(lastXValue != xValue){
                                    
                                    Text("\n\n"+xValue)
                                        .font(.custom(fontName, size: 8))
                                        .foregroundColor(valuesColor)
                                        .padding(.bottom,-4)
                                        .onAppear{
                                            
                                            lastXValue = xValue
                                            
                                        }
                                    
                                }
                                
                                
                                
                            }
                            
                            
                            
                            
                        }
                        
                        
                    } .padding(.leading,16)
                        .id(mainMaxValue)
                    
                    
                    
                }else{
                    
                    HStack(alignment: .bottom,spacing: 0) {
                        
                        var lastXValue = ""
                        
                        ForEach(0..<tempYValues.count,id: \.self){ i in
                            
                            let yValue = tempYValues[i]
                            let xValue = tempXValues[i]
                            
                            Spacer()
                            
                            VStack(spacing: 0) {
                                
                                HStack(alignment: .bottom,spacing: 4) {
                                    
                                    ForEach(0..<yValue.count,id: \.self){ j in
                                        
                                        let maxValue = tempMaxYValues[i][j]
                                        let progress = yValue[j]
                                        let height = Double(30 * maxValue)
                                        
                                        
                                        
                                        if(maxValue>0){
                                            
                                            
                                            //                                            VerticalProgressBar(progress: Double(progress) / Double(maxValue), width: 8, height: height,progressColor: "#FF0000",progressBGColor: progressBGColor)
                                            //                                                .overlay(alignment: .top) {
                                            //
                                            //                                                    if(showEmoji){
                                            //                                                        Image(.love)
                                            //                                                            .resizable()
                                            //                                                            .frame(width: CGFloat(emojiWidth), height: CGFloat(emojiHeight))
                                            //                                                            .padding(.top,-13)
                                            //                                                    }
                                            //
                                            //                                                }
                                            
                                        }
                                        
                                    }
                                    
                                }.padding(.bottom,-8)
                                
                                
                                if(lastXValue != xValue){
                                    
                                    Text("\n\n"+xValue)
                                        .font(.custom(fontName, size: 8))
                                        .padding(.bottom,-4)
                                        .onAppear{
                                            
                                            lastXValue = xValue
                                            
                                        }
                                    
                                }
                                
                                
                                
                            }
                            
                            
                            
                            
                        }
                        
                        
                    } .padding(.leading,28)
                        .id(mainMaxValue)
                        .onAppear{
                            
                            DispatchQueue.main.asyncAfter(deadline: .now()+0.5){
                                
                                mainMaxValue = 12
                                
                            }
                            
                            dataSet = ["0","2","4","6","8","10","12"]
                            //   print("err")
                            
                        }
                    
                }
                
            }
            //.overlay(alignment: .center) {
            
            //      if(isError){
            
            //         HStack{
            
            //              Spacer()
            
            //             Text(errorMessage)
            //                .font(.custom(fontName, size: 14))
            //                 .foregroundColor(.red)
            //               .multilineTextAlignment(.center)
            
            //          Spacer()
            
            //        }.padding(.horizontal)
            //            .padding(.leading,32)
            //    }
            
            
            // }
            
            
        }.padding()
            .onChange(of: yValues) { oldValue, newValue in
                
                validate()
                
                
            }.onAppear{
                
                validate()
                
            }.onTapGesture {
                
                showTooltip = false
                
            }
        
    }
    
    
    func validate(){
        
        withAnimation {
            
            isDataLoaded = false
            
        }
        
        
        let xValuesCount = xValues.count
        let yValuesCount = yValues.count
        
        if(xValuesCount != yValuesCount){
            
            withAnimation {
                
                isError = true
                errorMessage = "X and Y values had different size"
                
            }
            
        }else if((xValuesCount == yValuesCount)){
            
            
            if(!isError){
                
                findMaxValue()
                
            }
            
            
        }
        
        
        
    }
    
    func findMaxValue(){
        
        let maxValues1 = yValues.flatMap { $0.map { $0.totalProgress } }.max() ?? 0
        let maxValues2 = yValues.flatMap { $0.map { $0.progress } }.max() ?? 0
        
        var maxValues = 0.0
        
        if(maxValues1>maxValues2){
            
            maxValues = maxValues1
            
        }else{
            
            maxValues = maxValues2
            
        }
        
        
        withAnimation {
            
            if maxValues >= 6 {
                
                mainMaxValue = Int(maxValues)
                
            }else if(maxValues > 3 && maxValues < 6){
                
                mainMaxValue = Int(maxValues)
                
            }else{
                
                mainMaxValue = 3
                
            }
            
        }
         
        
        
        dataSet = generateArray1(forX: mainMaxValue)
        
         lastValue = Double(dataSet[dataSet.count - 1]) ?? 0.0
       
        
        self.mainMaxValue = Int(lastValue)
        
        
        isDataLoaded = true
        
        
    }

    func generateArray1(forX x: Int) -> [String] {
        
        let xValue = x
        
        var array = [Double](repeating: 1, count: 7)
        var stringArray:[String] = []
        
        let valueToAdd = (x - 1) / 5
        
        
        
        if(xValue == 3){
            
            stringArray.removeAll()
            
            let parts = 6
            
            heightDivider = Double(0.5)
            
            let step = Double(xValue) / Double(parts)
            
            for i in 0...parts {
                
                let value = step * Double(i)
                
                stringArray.append(String(format: "%.1f" ,value))
                
            }
            
            
        }else if(xValue > 3 && xValue < 6){
            
            stringArray.removeAll()
            
            let parts = 6
            
            let step = Double(xValue) / Double(parts)
            
            
            if(xValue == 4){
                
                heightDivider = 0.673
                
            }else if(xValue == 5){
                
                heightDivider = 0.842
                
            }
            
            for i in 0...parts {
                
                let value = step * Double(i)
                
                stringArray.append(String(format: "%.1f" ,value))
                
            }
            
            
        }else{
              
            heightDivider = Double(valueToAdd + 1)
            
            for i in 0..<array.count {
                
                var oldValue = array[i]
                
                if i > 0 {
                    
                    oldValue = array[i-1]
                    oldValue += Double(valueToAdd)
                    array[i] += oldValue
                    
                    stringArray.append(String(format: "%.0f" ,array[i]))
                    
                } else {
                    
                    array[i] = 0
                    stringArray.append("0")
                }
                
            }
             
            
        }
        
        
        
        return stringArray
    }
    
    
    
    // func generateArray1(forX x: Int) -> [Int] {
    //     var array = [Int](repeating: 1, count: 7)
    //     let valueToAdd = (x - 1) / 5
        
    //     heightDivider = Double(valueToAdd + 1)
    //     print("heightDivider",heightDivider,"-",x)
        
    //     for i in 0..<array.count {
    //         var oldValue = array[i]
    //         if i > 0 {
    //             oldValue = array[i-1]
    //             oldValue += valueToAdd
    //             array[i] += oldValue
    //         } else {
    //             array[i] = 0
    //         }
    //     }
    //     return array
    // }
    
    
    func generateArray2(forX x: Int) -> [Int] {
        var array = [Int](repeating: 1, count: 7) // Initializing an array with six 1s
        
        // Determine the value to add based on the value of x
        let valueToAdd: Int
        switch x {
        case 4, 5, 6: valueToAdd = 0 // Difference 0
        case 7...11: valueToAdd = 1 // Difference 2
        case 12...17: valueToAdd = 2 // Difference 3
        case 18...23: valueToAdd = 3 // Difference 4
        case 24...29: valueToAdd = 4 // Difference 5
        case 30...35: valueToAdd = 5 // Difference 6
        case 36...39: valueToAdd = 6 // Difference 7
        case 40...45: valueToAdd = 7 // Difference 8
        case 46...49: valueToAdd = 8 // Difference 9
        case 50...55: valueToAdd = 9 // Difference 10
        case 56...59: valueToAdd = 10 // Difference 11
        case 60...65: valueToAdd = 11 // Difference 12
        case 66...69: valueToAdd = 12 // Difference 13
        case 70...75: valueToAdd = 13 // Difference 14
        case 76...79: valueToAdd = 14 // Difference 15
        case 80...85: valueToAdd = 15 // Difference 16
        case 86...89: valueToAdd = 16 // Difference 17
        case 90...95: valueToAdd = 17 // Difference 18
        case 96...99: valueToAdd = 18 // Difference 19
        case 100...105: valueToAdd = 19 // Difference 20
        case 106...109: valueToAdd = 20 // Difference 21
        default: valueToAdd = 0
        }
        
        heightDivider = Double(valueToAdd+1)
        
        // Update the array elements with the computed value
        for i in 0..<array.count {
            
            var oldValue = array[i]
            
            if i > 0 {
                
                oldValue = array[i-1]
                oldValue+=valueToAdd
                array[i]+=oldValue
                
            }else{
                
                array[i] = 0
                
            }
            
        }
        
        return array
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
    var width:Double
    var height:Double
    var progressColor:String
    var progressBGColor:Color
    var j:Int
    var i:Int
    var minValue:Double
    var maxValue:Double
    var xValue:String
    var title:String
    var fontName:String
    @Binding var tooltipJIndex:Int
    @Binding var tooltipIIndex:Int
    @Binding var showToolTip:Bool
    @Binding var totalYValues:Int
    
    @State var paddingTrailing = CGFloat(0)
    
    var body: some View {
        VStack {
            ZStack(alignment: .bottom) {
                Capsule()
                    .frame(width: width, height: height)
                    .foregroundColor(progressBGColor)
                
                Capsule()
                    .frame(width: width, height: min(CGFloat(progress) * height / CGFloat(maxValue), height))
                    .foregroundColor(Color(hex: progressColor))
            }
            
        }
        .tooltip(alignment: .top, visible: $showToolTip,paddingTrailing: $paddingTrailing, backgroundColor: .white) {
            
            if j == tooltipJIndex && i == tooltipIIndex {
                
                VStack(alignment: .leading,spacing:4){
                    
                    Text("\(title)")
                        .font(.custom(fontName, size: 11))
                        .fontWeight(.semibold)
                        .foregroundColor(Color(hex: progressColor))
                    
                    HStack{
                        
                        Text("Taken:")
                            .font(.custom(fontName, size: 11))
                            .foregroundColor(.black.opacity(0.50))
                        
                        Text(String(format: "%.1f", progress))
                            .font(.custom(fontName, size: 11))
                            .fontWeight(.semibold)
                            .foregroundColor(Color(hex: progressColor))
                        
                    }
                    
                    HStack{
                        
                        Text("Total:")
                            .font(.custom(fontName, size: 11))
                            .foregroundColor(.black.opacity(0.50))
                        
                        Text(String(format: "%.1f", totalProgress))
                            .font(.custom(fontName, size: 11))
                            .fontWeight(.semibold)
                            .foregroundColor(.black)
                        
                    }
                    
                    HStack{
                        
                        Text("Timeline:")
                            .font(.custom(fontName, size: 11))
                            .foregroundColor(.black.opacity(0.50))
                        
                        Text("\(xValue)")
                            .font(.custom(fontName, size: 11))
                            .fontWeight(.semibold)
                            .foregroundColor(.black)
                        
                    }
                    
                }.frame(width: 95)
                    .padding(.vertical,4)
                    .zIndex(Double(j+50))
                    .onAppear{
                          
                        if(i == totalYValues-1){
                             
                            paddingTrailing = CGFloat(80)
                            
                        }else{
                            
                            paddingTrailing = CGFloat(0)
                            
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
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}


@available(iOS 17.0, *)
#Preview {
    EmojiGroupBarChart(yValues: .constant([[.init(progress: 11,totalProgress: 6,color: "#FA6418"),.init(progress: 0,totalProgress: 0,color: "#BD013C")],
                                           [.init(progress: 0,totalProgress: 0,color: "#FA6418"),.init(progress: 0,totalProgress: 0,color: "#BD013C")],
                                           [.init(progress: 0,totalProgress: 0,color: "#FA6418"),.init(progress: 0,totalProgress: 0,color: "#BD013C")],
                                           [.init(progress: 0,totalProgress: 0,color: "#FA6418"),.init(progress: 0,totalProgress: 0,color: "#BD013C")],
                                           [.init(progress: 0,totalProgress: 0,color: "#FA6418"),.init(progress: 0,totalProgress: 0,color: "#BD013C")],
                                           [.init(progress: 0,totalProgress: 0,color: "#FA6418"),.init(progress: 0,totalProgress: 0,color: "#BD013C")],
                                           [.init(progress: 0,totalProgress: 0,color: "#FA6418"),.init(progress: 0,totalProgress: 0,color: "#BD013C")]]),
                       xValues: ["Mon","Tue","Wed","Thu","Fri","Sat","Sun"],
                       showEmoji: false)
}



@available(iOS 17.0, *)
extension EmojiGroupBarChart {
    
    func setYAxisTitle(_ title: String) -> EmojiGroupBarChart {
        EmojiGroupBarChart(
            yValues: $yValues,
            xValues: xValues,
            showEmoji: showEmoji,
            yAxisTitle: title
        )
    }
    
    func setValuesColor(_ color: Color) -> EmojiGroupBarChart {
        EmojiGroupBarChart(
            yValues: $yValues,
            xValues: xValues,
            showEmoji: showEmoji,
            valuesColor: color,
            yAxisTitle: yAxisTitle
        )
    }
    
    func setLinesColor(_ color: Color) -> EmojiGroupBarChart {
        
        EmojiGroupBarChart(
            yValues: $yValues,
            xValues: xValues,
            showEmoji: showEmoji,
            valuesColor: valuesColor,
            linesColor: color,
            yAxisTitle: yAxisTitle
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
            yAxisTitle: yAxisTitle
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
            yAxisTitle: yAxisTitle
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
            yAxisTitleSize: size
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
            yAxisValuesSize: size
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
            emojiHeight: size
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
            emojiHeight: emojiHeight,
            emojiWidth: size
        )
        
    }
    
}


@available(iOS 17.0, *)
extension View {
    func tooltip(alignment: Edge, visible: Binding<Bool>, paddingTrailing: Binding<CGFloat> = .constant(CGFloat(0)), backgroundColor: Color = .white, @ViewBuilder tooltip: @escaping () -> some View) -> some View {
        modifier(TooltipDisplayingModifier(alignment: alignment, visible: visible,paddingTrailing: paddingTrailing, backgroundColor: backgroundColor, tooltip: tooltip))
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
                .padding(.trailing,paddingTrailing)
            
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
