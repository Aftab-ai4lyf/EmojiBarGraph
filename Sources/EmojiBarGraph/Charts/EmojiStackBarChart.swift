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
    
    @State var dataSet:[Int] = []
    @State var dataSet1:[Int] = [0, 3, 6, 9, 12, 15, 18]
    
    var valuesColor:Color = .black
    var linesColor:Color = .black.opacity(0.50)
    
    var progressBGColor = Color.gray.opacity(0.40)
    
    var fontName = ""
    
    var yAxisTitle = "Number of Puffs"
    var yAxisTitleSize = 12
    
    var yAxisValuesSize = 12
    
    var emojiHeight = 8
    var emojiWidth = 8
    
    @State var heightDivider:Double = 0
    
    @State var mainMaxValue = 4
    
    @State var isError = false
    @State var errorMessage = ""
    
    @State var isDataLoaded = false
    
    var body: some View {
        ZStack(alignment: .bottom) {
            
            VStack(spacing: 0) {
                
                HStack(spacing: 0){
                    
                    Text(yAxisTitle)
                        .font(.custom(fontName, size: CGFloat(yAxisTitleSize)))
                        .rotationEffect(Angle(degrees: 270))
                        .foregroundColor(valuesColor)
                        .fixedSize()
                        .frame(width: 20, height: 0)
                        .onTapGesture {
                            
                            let i = yValues[1][1].totalProgress
                            yValues[1][1].totalProgress = i+1
                            
                        }
                    
                    VStack(spacing: 0){
                        
                        
                        ForEach((0..<dataSet.count).reversed(),id: \.self){ i in
                            
                            HStack {
                                
                                Text("\(dataSet[i])")
                                    .font(.custom(fontName, size: CGFloat(yAxisTitleSize)))
                                    .foregroundColor(valuesColor)
                                    .frame(height: 30)
                                
                                Line()
                                    .stroke(style: StrokeStyle(lineWidth: 0.5, dash: [2]))
                                    .frame(height: 0.5)
                                    .foregroundColor(linesColor)
                                
                                
                            }
                            
                        }
                        
                    }.padding(.leading,8)
                    
                    
                }
                
                
                
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
                        
                        
                    } .padding(.leading,28)
                    //                        .id(mainMaxValue)
                    
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
                            
                            dataSet = [0,2,4,6,8,10,12]
                            
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
                
            }.onChange(of: dataSet) { oldValue, newValue in
                
                print("dataSet change",newValue)
                
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
        
        //        for i in 0..<yValues.count {
        //
        //            let yValue = yValues[i]
        //
        //            let totalMaxSum = Int(yValue.compactMap { $0 }.reduce(0) { $0 + $1.totalProgress })
        //
        //        }
        
        let maxValues = yValues.map { $0.reduce(0) { $0 + $1.totalProgress } }.max() ?? 0
        
        print("maxValues",maxValues)
        
        //        let maxValues = yValues.flatMap { $0.map { $0.totalProgress } }.max() ?? 0
        
        if maxValues > 4 {
            
            withAnimation {
                
                if maxValues >= 100 {
                    
                    mainMaxValue = 100
                    
                }else{
                    
                    mainMaxValue = Int(maxValues)
                    
                }
            }
            
            
        }else{
            
            withAnimation {
                
                mainMaxValue = 6
                
            }
            
        }
        
        dataSet.removeAll()
        
        dataSet = generateArray1(forX: mainMaxValue)
        
        print("dataSet",dataSet)
        
        if let maxValue = dataSet.last {
            
            withAnimation {
                
                self.mainMaxValue = maxValue
                
            }
            
        }
        
        print("dataSet",dataSet)
        
        isDataLoaded = true
        
        
    }
    
    
    
    
    
    
    func generateArray1(forX x: Int) -> [Int] {
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

