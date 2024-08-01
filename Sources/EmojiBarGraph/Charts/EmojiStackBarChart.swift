//
//  EmojiStackBarChart.swift
//
//
//  Created by ai4lyf on 16/05/2024.
//

import Foundation
import SwiftUI

@available(iOS 17.0, *)
public struct EmojiStackBarChart: View {
    
    @Binding var yValues:[[EmojiChartView.BarChart]]
    var xValues:[String]
    var showEmoji:Bool
    
    
    var tempYValues:[[Int]] = [[0,0],[0,0],[0,0],[0,0],[0,0],[0,0],[0,0]]
    @State var tempMaxYValues:[[Int]] = [[0,0],[0,0],[0,0],[0,0],[0,0],[0,0],[0,0]]
    var tempXValues:[String] = ["Mon","Tue","Wed","Thu","Fri","Sat","Sun"]
    
    @State var dataSet:[String] = []
    @State var dataSet1:[String] = ["0", "3", "6", "9", "12", "15", "18"]
    
    var valuesColor:Color = .black
    var linesColor:Color = .black.opacity(0.50)
    
    var progressBGColor = Color.gray.opacity(0.40)
    
    var fontName = ""
    
    var yAxisTitle:String?
    var yAxisTitleSize = 12
    
    var yAxisValuesSize = 12
    
    var emojiHeight = 8
    var emojiWidth = 8
    
    @State var heightDivider:Double = 0
    @State var lastValue:Double = 0
    
    @State var mainMaxValue = 4

    @State var textWidth:CGFloat = .zero
    
    @State var isError = false
    @State var errorMessage = ""
    
    @State var isDataLoaded = false

    @State var hadTitle = false
    
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
                                    
                                    if(lastValue > 6){
                                        
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
                                
                                ZStack(alignment: .bottom){
                                    
                                    let totalMaxSum = Int(yValue.compactMap { $0 }.reduce(0) { $0 + $1.totalProgress })
                                    let totalHeight = Double(30 * totalMaxSum)
                                    
                                    Capsule()
                                        .frame(width: 12, height: totalHeight / heightDivider)
                                        .foregroundColor(progressBGColor)
                                    
                                    
                                    
                                    VStack(spacing: 1) {
                                        
                                        Spacer()
                                        
                                        
                                        ForEach(0..<yValue.count,id: \.self){ j in
                                            
                                            let maxValue = yValue[j].totalProgress
                                            let progress = yValue[j].progress
                                            let height = Double(30 * progress)
                                            let color = yValue[j].color
                                            
                                            VStack{
                                                
                                                if(maxValue>0){
                                                    
                                                    Capsule()
                                                        .frame(width: 12, height: height / heightDivider)
                                                        .foregroundColor(Color(hex: color))
                                                    
                                                    
                                                }
                                                
                                            }
                                            
                                            
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
                                            //                                                    Image(.love)
                                            //                                                        .resizable()
                                            //                                                        .frame(width: CGFloat(emojiWidth), height: CGFloat(emojiHeight))
                                            //                                                        .padding(.top,-13)
                                            //
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
                            
                        }
                    
                }
                
            }
            .overlay(alignment: .center) {
                
                if(isError){
                    
                    HStack{
                        
                        Spacer()
                        
                        Text(errorMessage)
                            .font(.custom(fontName, size: 14))
                            .foregroundColor(.red)
                            .multilineTextAlignment(.center)
                        
                        Spacer()
                        
                    }.padding(.horizontal)
                        .padding(.leading,32)
                }
                
                
            }
            
            
            
        }.padding()
            .onChange(of: yValues) { oldValue, newValue in
                
                validate()
                
                
            }.onAppear{
                
                validate()
                
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
        
        dataSet.removeAll()
        
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
             
            print("we")
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
            
            print("array",array)
            
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
        
        print("array",array)
        
        return array
    }
}


@available(iOS 17.0, *)
#Preview {
    EmojiStackBarChart(yValues: .constant([[.init(progress: 1,totalProgress: 4,color: "#FA6418"),.init(progress: 1,totalProgress: 4,color: "#BD013C")],
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
extension EmojiStackBarChart {
    
    func setYAxisTitle(_ title: String) -> EmojiStackBarChart {
        EmojiStackBarChart(
            yValues: $yValues,
            xValues: xValues,
            showEmoji: showEmoji,
            yAxisTitle: title
        )
    }
    
    func setValuesColor(_ color: Color) -> EmojiStackBarChart {
        EmojiStackBarChart(
            yValues: $yValues,
            xValues: xValues,
            showEmoji: showEmoji,
            valuesColor: color,
            yAxisTitle: yAxisTitle
        )
    }
    
    func setLinesColor(_ color: Color) -> EmojiStackBarChart {
        
        EmojiStackBarChart(
            yValues: $yValues,
            xValues: xValues,
            showEmoji: showEmoji,
            valuesColor: valuesColor,
            linesColor: color,
            yAxisTitle: yAxisTitle
        )
        
    }
    
    func setBarBackgroundColor(_ color: Color) -> EmojiStackBarChart {
        
        EmojiStackBarChart(
            yValues: $yValues,
            xValues: xValues,
            showEmoji: showEmoji,
            valuesColor: valuesColor,
            linesColor: linesColor,
            progressBGColor: color,
            yAxisTitle: yAxisTitle
        )
        
    }
    
    func setFontName(_ name: String) -> EmojiStackBarChart {
        
        EmojiStackBarChart(
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
    
    func setYAxisTitleSize(_ size: Int) -> EmojiStackBarChart {
        
        EmojiStackBarChart(
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
    
    func setYAxisValuesSize(_ size: Int) -> EmojiStackBarChart {
        
        EmojiStackBarChart(
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
    
    func setEmojiHeight(_ size: Int) -> EmojiStackBarChart {
        
        EmojiStackBarChart(
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
    
    func setEmojiWidth(_ size: Int) -> EmojiStackBarChart {
        
        EmojiStackBarChart(
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

