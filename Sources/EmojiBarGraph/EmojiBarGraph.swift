// The Swift Programming Language
// https://docs.swift.org/swift-book


import SwiftUI

@available(iOS 17.0, *)
public struct EmojiChartView: View {
    
    public var chartType:EmojiChartView.ChartType
    
    @Binding var yDataList:[[EmojiChartView.BarChart]]
    var xDataList:[String]
    
    var showEmoji:Bool
    
    var yAxisTitle:String?
    
    var valuesColor:Color = .black
    var linesColor:Color = .black.opacity(0.50)
    
    var progressBGColor = Color.gray.opacity(0.40)
    
    var fontName = ""
    
    var yAxisTitleSize = 12
    
    var yAxisValuesSize = 12
    
    var emojiHeight = 8
    var emojiWidth = 8
    
    public var body: some View {
        ZStack {
            
            if(chartType == .GroupChart){
                
                EmojiGroupBarChart(yValues: $yDataList, xValues: xDataList,showEmoji:showEmoji)
                    .setYAxisTitle(yAxisTitle ?? "")
                    .setValuesColor(valuesColor)
                    .setLinesColor(linesColor)
                    .setBarBackgroundColor(progressBGColor)
                    .setFontName(fontName)
                    .setYAxisTitleSize(yAxisTitleSize)
                    .setYAxisValuesSize(yAxisValuesSize)
                    .setEmojiHeight(emojiHeight)
                    .setEmojiWidth(emojiWidth)
                
            }else if(chartType == .StackChart){
                
                EmojiStackBarChart(yValues: $yDataList, xValues: xDataList,showEmoji:showEmoji)
                    .setYAxisTitle(yAxisTitle ?? "")
                    .setValuesColor(valuesColor)
                    .setLinesColor(linesColor)
                    .setBarBackgroundColor(progressBGColor)
                    .setFontName(fontName)
                    .setYAxisTitleSize(yAxisTitleSize)
                    .setYAxisValuesSize(yAxisValuesSize)
                    .setEmojiHeight(emojiHeight)
                    .setEmojiWidth(emojiWidth)
                
            }
        }
    }
    
    
}

@available(iOS 17.0, *)
#Preview {
    EmojiChartView(chartType: .StackChart,
                   yDataList: .constant([[.init(progress: 1,totalProgress: 4,color: "#FA6418"),.init(progress: 3,totalProgress: 14,color: "#BD013C")],
                                         [.init(progress: 0,totalProgress: 0,color: "#FA6418"),.init(progress: 0,totalProgress: 0,color: "#BD013C")],
                                         [.init(progress: 0,totalProgress: 0,color: "#FA6418"),.init(progress: 0,totalProgress: 0,color: "#BD013C")],
                                         [.init(progress: 0,totalProgress: 0,color: "#FA6418"),.init(progress: 0,totalProgress: 0,color: "#BD013C")],
                                         [.init(progress: 0,totalProgress: 0,color: "#FA6418"),.init(progress: 0,totalProgress: 0,color: "#BD013C")],
                                         [.init(progress: 0,totalProgress: 0,color: "#FA6418"),.init(progress: 0,totalProgress: 0,color: "#BD013C")],
                                         [.init(progress: 1,totalProgress: 4,color: "#FA6418"),.init(progress: 0,totalProgress: 0,color: "#BD013C")]]),
                   xDataList: ["Mon","Tue","Wed","Thu","Fri","Sat","Sun"],
                   showEmoji: false).setYAxisTitle("Number of Puffs").setValuesColor(.black)
    
}

@available(iOS 17.0, *)
extension EmojiChartView {
        
    
    func setYAxisTitle(_ title: String) -> EmojiChartView {
     
        EmojiChartView(chartType: chartType, yDataList: $yDataList, xDataList: xDataList, showEmoji: showEmoji, yAxisTitle: title)
        
    }
    
    func setValuesColor(_ color: Color) -> EmojiChartView {
        
        EmojiChartView(chartType: chartType, yDataList: $yDataList, xDataList: xDataList, showEmoji: showEmoji,yAxisTitle:yAxisTitle, valuesColor: color)
        
    }
    
    func setLinesColor(_ color: Color) -> EmojiChartView {
        
        EmojiChartView(chartType: chartType, yDataList: $yDataList, xDataList: xDataList, showEmoji: showEmoji,yAxisTitle:yAxisTitle, valuesColor: valuesColor,linesColor: color)
        
    }
    
    func setBarBackgroundColor(_ color: Color) -> EmojiChartView {
        
        EmojiChartView(chartType: chartType, yDataList: $yDataList, xDataList: xDataList, showEmoji: showEmoji,yAxisTitle:yAxisTitle, valuesColor: valuesColor,linesColor: linesColor,progressBGColor: color)
        
    }
    
    func setFontName(_ name: String) -> EmojiChartView {
        
        EmojiChartView(chartType: chartType, yDataList: $yDataList, xDataList: xDataList, showEmoji: showEmoji,yAxisTitle:yAxisTitle, valuesColor: valuesColor,linesColor: linesColor,progressBGColor: progressBGColor,fontName: name)
        
    }
    
    func setYAxisTitleSize(_ size: Int) -> EmojiChartView {
        
        EmojiChartView(chartType: chartType, yDataList: $yDataList, xDataList: xDataList, showEmoji: showEmoji,yAxisTitle:yAxisTitle, valuesColor: valuesColor,linesColor: linesColor,progressBGColor: progressBGColor,fontName: fontName,yAxisTitleSize: size)
        
    }
    
    func setYAxisValuesSize(_ size: Int) -> EmojiChartView {
        
        EmojiChartView(chartType: chartType, yDataList: $yDataList, xDataList: xDataList, showEmoji: showEmoji,yAxisTitle:yAxisTitle, valuesColor: valuesColor,linesColor: linesColor,progressBGColor: progressBGColor,fontName: fontName,yAxisTitleSize: yAxisTitleSize,yAxisValuesSize: size)
        
    }
    
    func setEmojiHeight(_ size: Int) -> EmojiChartView {
        
        EmojiChartView(chartType: chartType, yDataList: $yDataList, xDataList: xDataList, showEmoji: showEmoji,yAxisTitle:yAxisTitle, valuesColor: valuesColor,linesColor: linesColor,progressBGColor: progressBGColor,fontName: fontName,yAxisTitleSize: yAxisTitleSize,yAxisValuesSize: yAxisValuesSize,emojiHeight: size)
        
    }
    
    func setEmojiWidth(_ size: Int) -> EmojiChartView {
        
        EmojiChartView(chartType: chartType, yDataList: $yDataList, xDataList: xDataList, showEmoji: showEmoji,yAxisTitle:yAxisTitle, valuesColor: valuesColor,linesColor: linesColor,progressBGColor: progressBGColor,fontName: fontName,yAxisTitleSize: yAxisTitleSize,yAxisValuesSize: yAxisValuesSize,emojiHeight: emojiHeight,emojiWidth: size)
        
    }
    
}
