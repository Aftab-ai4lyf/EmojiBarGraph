 

import SwiftUI

@available(iOS 17.0, *)
public struct EmojiChartView: View {
    
    public var chartType:EmojiChartView.ChartType
    
    @Binding public var yDataList:[[EmojiChartView.BarChart]]
    public var xDataList:[String]
    
   public var showEmoji:Bool
    
   public var yAxisTitle:String?
    
   public var valuesColor:Color = .black
    public var linesColor:Color = .black.opacity(0.50)
    
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
                yAxisTitle: String? = nil,
                valuesColor: Color = .black,
                linesColor: Color = .black.opacity(0.50),
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
        self.yAxisTitle = yAxisTitle
        self.valuesColor = valuesColor
        self.linesColor = linesColor
        self.progressBGColor = progressBGColor
        self.fontName = fontName
        self.yAxisTitleSize = yAxisTitleSize
        self.yAxisValuesSize = yAxisValuesSize
        self.emojiHeight = emojiHeight
        self.emojiWidth = emojiWidth
    }
    
    

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
