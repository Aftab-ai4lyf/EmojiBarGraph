 

import SwiftUI

@available(iOS 17.0, *)
public struct EmojiChartView: View {
    
    public var chartType:EmojiChartView.ChartType
    
    @Binding public var yDataList:[[EmojiChartView.BarChart]]
    public var xDataList:[String]
    
   public var showEmoji:Bool
   public var showYValues: Bool
    public var showLines: Bool
   public var yAxisTitle:String?
   public  var showAreaMark: Bool
   public var valuesColor:Color = .black
   public  var gradientColors: [Color] = [.blue.opacity(0.4), .clear]
    public var linesColor:Color = .black.opacity(0.50)
    
    public var arealinesColor:Color = .black.opacity(0.50)
    public var progressBGColor = Color.gray.opacity(0.40)
    
   public var fontName = ""
    
   public var yAxisTitleSize = 12
    
   public var yAxisValuesSize = 12
    
   public var emojiHeight = 8
   public var emojiWidth = 8
    
    // Public initializer
    public init(chartType: EmojiChartView.ChartType,
                yDataList: Binding<[[EmojiChartView.BarChart]]>,
                xDataList: [String],
                showEmoji: Bool,
                showYValues: Bool,
                showLines: Bool,
               showAreaMark: Bool,
                yAxisTitle: String? = nil,
                valuesColor: Color = .black,
                linesColor: Color = .black.opacity(0.50),
                arealinesColor: Color = .black.opacity(0.50),
                gradientColors:[Color] = [.blue.opacity(0.4), .clear],
                progressBGColor: Color = Color.gray.opacity(0.40),
                fontName: String = "",
                yAxisTitleSize: Int = 12,
                yAxisValuesSize: Int = 12,
                emojiHeight: Int = 8,
                emojiWidth: Int = 8) {
        self._yDataList = yDataList
        self.chartType = chartType
        self.xDataList = xDataList
        self.showEmoji = showEmoji
        self.showYValues = showYValues
        self.showLines = showLines
        self.showAreaMark = showAreaMark
        self.gradientColors = gradientColors
        self.yAxisTitle = yAxisTitle
        self.valuesColor = valuesColor
        self.linesColor = linesColor
        self.arealinesColor = arealinesColor
        self.progressBGColor = progressBGColor
        self.fontName = fontName
        self.yAxisTitleSize = yAxisTitleSize
        self.yAxisValuesSize = yAxisValuesSize
        self.emojiHeight = emojiHeight
        self.emojiWidth = emojiWidth
    }
    
    

    public var body: some View {
        VStack {
             
            if(chartType == .GroupChart){
                
                EmojiGroupBarChart(yValues: $yDataList, xValues: xDataList,showEmoji:showEmoji, showYValues:showYValues, showLines:showLines,showAreaMark:showAreaMark,arealinesColor:arealinesColor, gradientColors:gradientColors)
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
                
                EmojiStackBarChart(yValues: $yDataList, xValues: xDataList,showEmoji:showEmoji,showYValues:showYValues,showLines:showLines,showAreaMark:showAreaMark,arealinesColor: arealinesColor,gradientColors:gradientColors)
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

//@available(iOS 17.0, *)
//#Preview {
//    EmojiChartView(chartType: .GroupChart,
//                   yDataList: .constant([[.init(progress: 0,totalProgress: 0,color: "#FA6418"),.init(progress: 0,totalProgress: 1512,color: "#BD013C")],
//                                         [.init(progress: 0,totalProgress: 0,color: "#FA6418"),.init(progress: 0,totalProgress: 0,color: "#BD013C")],
//                                         [.init(progress: 0,totalProgress: 0,color: "#FA6418"),.init(progress: 0,totalProgress: 0,color: "#BD013C")],
//                                         [.init(progress: 0,totalProgress: 0,color: "#FA6418"),.init(progress: 0,totalProgress: 0,color: "#BD013C")],
//                                         [.init(progress: 0,totalProgress: 0,color: "#FA6418"),.init(progress: 0,totalProgress: 0,color: "#BD013C")],
//                                         [.init(progress: 0,totalProgress: 0,color: "#FA6418"),.init(progress: 0,totalProgress: 0,color: "#BD013C")],
//                                         [.init(progress: 0,totalProgress: 0,color: "#FA6418"),.init(progress: 0,totalProgress: 0,color: "#BD013C")]]),
//                   xDataList: ["Mon","Tue","Wed","Thu","Fri","Sat","Sun"],showEmoji: false).setYAxisTitle("Number of Puffs").setValuesColor(.black)
//    
//}

@available(iOS 17.0, *)
extension EmojiChartView {
        
    
    func setYAxisTitle(_ title: String) -> EmojiChartView {
     
        EmojiChartView(chartType: chartType, yDataList: $yDataList, xDataList: xDataList, showEmoji: showEmoji, showYValues: showYValues, showLines: showLines, showAreaMark: showAreaMark, yAxisTitle: title)
        
    }
    
    func setValuesColor(_ color: Color) -> EmojiChartView {
        
        EmojiChartView(chartType: chartType, yDataList: $yDataList, xDataList: xDataList, showEmoji: showEmoji, showYValues: showYValues, showLines: showLines, showAreaMark: showAreaMark,yAxisTitle:yAxisTitle, valuesColor: color)
        
    }
    
    func setLinesColor(_ color: Color) -> EmojiChartView {
        
        EmojiChartView(chartType: chartType, yDataList: $yDataList, xDataList: xDataList, showEmoji: showEmoji, showYValues: showYValues, showLines: showLines, showAreaMark: showAreaMark,yAxisTitle:yAxisTitle, valuesColor: valuesColor,linesColor: color)
        
    }
    
    func setBarBackgroundColor(_ color: Color) -> EmojiChartView {
        
        EmojiChartView(chartType: chartType, yDataList: $yDataList, xDataList: xDataList, showEmoji: showEmoji, showYValues: showYValues, showLines: showLines, showAreaMark: showAreaMark,yAxisTitle:yAxisTitle, valuesColor: valuesColor,linesColor: linesColor,progressBGColor: color)
        
    }
    
    func setFontName(_ name: String) -> EmojiChartView {
        
        EmojiChartView(chartType: chartType, yDataList: $yDataList, xDataList: xDataList, showEmoji: showEmoji, showYValues: showYValues, showLines: showLines, showAreaMark: showAreaMark,yAxisTitle:yAxisTitle, valuesColor: valuesColor,linesColor: linesColor,progressBGColor: progressBGColor,fontName: name)
        
    }
    
    func setYAxisTitleSize(_ size: Int) -> EmojiChartView {
        
        EmojiChartView(chartType: chartType, yDataList: $yDataList, xDataList: xDataList, showEmoji: showEmoji, showYValues:showYValues, showLines: showLines, showAreaMark: showAreaMark,yAxisTitle:yAxisTitle, valuesColor: valuesColor,linesColor: linesColor,progressBGColor: progressBGColor,fontName: fontName,yAxisTitleSize: size)
        
    }
    
    func setYAxisValuesSize(_ size: Int) -> EmojiChartView {
        
        EmojiChartView(chartType: chartType, yDataList: $yDataList, xDataList: xDataList, showEmoji: showEmoji, showYValues:showYValues, showLines: showLines, showAreaMark: showAreaMark,yAxisTitle:yAxisTitle, valuesColor: valuesColor,linesColor: linesColor,progressBGColor: progressBGColor,fontName: fontName,yAxisTitleSize: yAxisTitleSize,yAxisValuesSize: size)
        
    }
    
    func setEmojiHeight(_ size: Int) -> EmojiChartView {
        
        EmojiChartView(chartType: chartType, yDataList: $yDataList, xDataList: xDataList, showEmoji: showEmoji, showYValues:showYValues, showLines: showLines, showAreaMark: showAreaMark,yAxisTitle:yAxisTitle, valuesColor: valuesColor,linesColor: linesColor,progressBGColor: progressBGColor,fontName: fontName,yAxisTitleSize: yAxisTitleSize,yAxisValuesSize: yAxisValuesSize,emojiHeight: size)
        
    }
    
    func setEmojiWidth(_ size: Int) -> EmojiChartView {
        
        EmojiChartView(chartType: chartType, yDataList: $yDataList, xDataList: xDataList, showEmoji: showEmoji, showYValues:showYValues, showLines: showLines, showAreaMark: showAreaMark,yAxisTitle:yAxisTitle, valuesColor: valuesColor,linesColor: linesColor,progressBGColor: progressBGColor,fontName: fontName,yAxisTitleSize: yAxisTitleSize,yAxisValuesSize: yAxisValuesSize,emojiHeight: emojiHeight,emojiWidth: size)
        
    }
    
}
 
 
