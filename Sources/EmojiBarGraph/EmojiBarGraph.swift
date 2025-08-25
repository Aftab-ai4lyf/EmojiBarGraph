    //
    //  EmojiChartView.swift
    //  EmojiBarGraph
    //
    //  Created by AI 4LYF on 21/07/2025.
    //


import SwiftUI

@available(iOS 17.0, *)
public struct EmojiChartView: View {
    
    public var chartType:EmojiChartView.ChartType
    
    @Binding public var yDataList:[[[EmojiChartView.BarChart]]]
    public var xDataList:[String]
    public var areaLinesValues:[Double]?
    public var graphOrientation:EmojiChartView.ChartOrientation?
    
    public var showEmoji:Bool
    public var showYValues: Bool
    public var showLines: Bool
    public var yAxisTitle:String?
    public var showAreaMark: Bool
    public var valuesColor:Color = .black
    public var gradientColors: [Color] = [.blue.opacity(0.4), .clear]
    public var linesColor:Color = .black.opacity(0.50)
    
    public var arealinesColor:Color = .black.opacity(0.50)
    public var progressBGColor = Color.gray.opacity(0.40)
    
    public var fontName = ""
    
    public var yAxisTitleSize = 12
    
    public var yAxisValuesSize = 12
    
    public var emojiHeight = 8
    public var emojiWidth = 8
    
    public var enableHorizontalScroll = true
    
    
    let severityColors: [String: Color] = [
        "Best": Color(hex: "#A7E3A1"),
        "Mild": Color(hex: "#FFD166"),
        "Moderate": Color(hex: "#FF8C42"),
        "Severe": Color(hex: "#EF8089"),
        "Worst": Color(hex: "#E63946")
    ]
    
        // Public initializer
    public init(chartType: EmojiChartView.ChartType,
                yDataList: Binding<[[[EmojiChartView.BarChart]]]>,
                xDataList: [String],
                areaLinesValues: [Double] = [],
                graphOrientation: EmojiChartView.ChartOrientation? = .Horizontal,
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
                emojiWidth: Int = 8,
                enableHorizontalScroll:Bool = true) {
        self._yDataList = yDataList
        self.chartType = chartType
        self.xDataList = xDataList
        self.areaLinesValues = areaLinesValues
        self.graphOrientation = graphOrientation
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
        self.enableHorizontalScroll = enableHorizontalScroll
    }
    
    
    
    public var body: some View {
        
            //        GeometryReader { geo in
            //
            //            if graphOrientation == .Horizontal {
            //
            //                VStack(spacing: 8) {
            //
            //                    HStack {
            //
            //                        Text("Best")
            //                            .font(.system(size: 10))
            //                            .foregroundColor(.black)
            //
            //                        Spacer()
            //
            //                    }
            //
            //                    GeometryReader { geometry in
            //
            //                        HStack(alignment: .top, spacing: 8) {
            //
            //                            Rectangle()
            //                                .fill(
            //                                    LinearGradient(
            //                                        gradient: Gradient(colors: [
            //                                            severityColors["Best", default: .gray],
            //                                            severityColors["Mild", default: .gray],
            //                                            severityColors["Moderate", default: .gray],
            //                                            severityColors["Severe", default: .gray],
            //                                            severityColors["Worst", default: .gray]
            //                                        ]),
            //                                        startPoint: .top,
            //                                        endPoint: .bottom
            //                                    )
            //                                )
            //                                .frame(width: 12)
            //                                .frame(maxHeight: .infinity)
            //                                .cornerRadius(12)
            //                                .padding(.bottom, 16)
            //
            //                            VStack {
            //
            //                                ForEach(1...5, id: \.self) { level in
            //
            //                                    if level > 1 {
            //
            //                                        Spacer()
            //
            //                                    }
            //
            //                                    Text("\(level)")
            //                                        .font(.system(size: 11))
            //                                        .foregroundColor(.black)
            //
            //                                }
            //
            //                            }
            //                            .frame(maxHeight: .infinity)
            //                            .padding(.bottom, 16)
            //
            //                            EmojiGroupStackBarChart(yValues: $yDataList, xValues: xDataList, arealinesValues: areaLinesValues ?? [], showEmoji: showEmoji, showYValues: showYValues, showLines: showLines, graphOrientation: graphOrientation ?? .Horizontal, showAreaMark: showAreaMark, arealinesColor: arealinesColor, gradientColors: gradientColors)
            //                                .setYAxisTitle(yAxisTitle ?? "")
            //                                .setValuesColor(valuesColor)
            //                                .setLinesColor(linesColor)
            //                                .setBarBackgroundColor(progressBGColor)
            //                                .setFontName(fontName)
            //                                .setYAxisTitleSize(yAxisTitleSize)
            //                                .setYAxisValuesSize(yAxisValuesSize)
            //                                .setEmojiHeight(emojiHeight)
            //                                .setEmojiWidth(emojiWidth)
            //                                .enableHorizontalScroll(enableHorizontalScroll)
            //
            //                                //                    EmojiChartView(chartType: .GroupStackChart, yDataList: $yDataList, xDataList: xDataList, showEmoji: false, showYValues: true, showLines: true, showAreaMark: true)
            //
            //                        }
            //
            //                    }
            //                    .padding(.leading, 6)
            //
            //                    HStack {
            //
            //                        Text("Worst")
            //                            .font(.system(size: 10))
            //                            .foregroundColor(.black)
            //
            //                        Spacer()
            //
            //                    }.offset(y: -15)
            //
            //                }
            //
            //            }else{
            //
            //                VStack {
            //
            //                    HStack {
            //
            //                        ForEach((1...5).reversed(), id: \.self) { level in
            //
            //                            if level < 5 {   // 👈 notice condition flips because reversed
            //
            //                                Spacer()
            //
            //                            }
            //
            //                            Text("\(level)")
            //                                .font(.system(size: 11))
            //                                .foregroundColor(.black)
            //
            //                        }
            //
            //                    }.padding(.leading, 40)
            //                        .padding(.trailing, 2)
            //
            //                    EmojiGroupStackBarChart(yValues: $yDataList, xValues: xDataList, arealinesValues: areaLinesValues ?? [], showEmoji: showEmoji, showYValues: showYValues, showLines: showLines, graphOrientation: graphOrientation ?? .Horizontal, showAreaMark: showAreaMark, arealinesColor: arealinesColor, gradientColors: gradientColors)
            //                        .setYAxisTitle(yAxisTitle ?? "")
            //                        .setValuesColor(valuesColor)
            //                        .setLinesColor(linesColor)
            //                        .setBarBackgroundColor(progressBGColor)
            //                        .setFontName(fontName)
            //                        .setYAxisTitleSize(yAxisTitleSize)
            //                        .setYAxisValuesSize(yAxisValuesSize)
            //                        .setEmojiHeight(emojiHeight)
            //                        .setEmojiWidth(emojiWidth)
            //                        .enableHorizontalScroll(enableHorizontalScroll)
            //                        .frame(height: geo.size.height)
            //                        .frame(width: geo.size.width)
            //                        .padding(.top, 1)
            //
            //                }
            //
            //            }
            //
            //        }
        
        GeometryReader { geo in
            
            VStack {
                
                if(chartType == .GroupChart){
                    
                    EmojiGroupBarChart(yValues: .constant(yDataList.flatMap { $0 }), xValues: xDataList,showEmoji:showEmoji, showYValues:showYValues, showLines:showLines,showAreaMark:showAreaMark,arealinesColor:arealinesColor, gradientColors:gradientColors)
                        .setYAxisTitle(yAxisTitle ?? "")
                        .setValuesColor(valuesColor)
                        .setLinesColor(linesColor)
                        .setBarBackgroundColor(progressBGColor)
                        .setFontName(fontName)
                        .setYAxisTitleSize(yAxisTitleSize)
                        .setYAxisValuesSize(yAxisValuesSize)
                        .setEmojiHeight(emojiHeight)
                        .setEmojiWidth(emojiWidth)
                        .frame(height: geo.size.height)
                        .frame(width: geo.size.width)
                    
                }else if(chartType == .StackChart){
                    
                    EmojiStackBarChart(yValues: .constant(yDataList.flatMap { $0 }), xValues: xDataList,showEmoji:showEmoji,showYValues:showYValues,showLines:showLines,showAreaMark:showAreaMark,arealinesColor: arealinesColor,gradientColors:gradientColors)
                        .setYAxisTitle(yAxisTitle ?? "")
                        .setValuesColor(valuesColor)
                        .setLinesColor(linesColor)
                        .setBarBackgroundColor(progressBGColor)
                        .setFontName(fontName)
                        .setYAxisTitleSize(yAxisTitleSize)
                        .setYAxisValuesSize(yAxisValuesSize)
                        .setEmojiHeight(emojiHeight)
                        .setEmojiWidth(emojiWidth)
                        .frame(height: geo.size.height)
                        .frame(width: geo.size.width)
                    
                }else if(chartType == .GroupStackChart) {
                    
                    EmojiGroupStackBarChart(yValues: $yDataList, xValues: xDataList, arealinesValues: areaLinesValues ?? [], showEmoji: showEmoji, showYValues: showYValues, showLines: showLines, graphOrientation: graphOrientation ?? .Horizontal, showAreaMark: showAreaMark, arealinesColor: arealinesColor, gradientColors: gradientColors)
                        .setYAxisTitle(yAxisTitle ?? "")
                        .setValuesColor(valuesColor)
                        .setLinesColor(linesColor)
                        .setBarBackgroundColor(progressBGColor)
                        .setFontName(fontName)
                        .setYAxisTitleSize(yAxisTitleSize)
                        .setYAxisValuesSize(yAxisValuesSize)
                        .setEmojiHeight(emojiHeight)
                        .setEmojiWidth(emojiWidth)
                        .enableHorizontalScroll(enableHorizontalScroll)
                        .frame(height: geo.size.height)
                        .frame(width: geo.size.width)
                }
                
            }.frame(height: geo.size.height)
                .frame(width: geo.size.width)
            
        }
        
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
    
    var areaLinesValues: [Double] = [1.0, 3.0, 2.0, 5.0, 4.0, 0.0, 2.0]
    
    EmojiChartView(
        chartType: .GroupStackChart,
        yDataList: $yValues,
        xDataList: xDataList,
        areaLinesValues: areaLinesValues,
        graphOrientation: .Vertical,
        showEmoji: false,
        showYValues: false,
        showLines: false,
        showAreaMark: true,
        yAxisTitle: "",
        valuesColor: .black,
        linesColor: .black,
        arealinesColor: .black.opacity(0.4),
        gradientColors: [.red.opacity(0.4), .red.opacity(0.3), .red.opacity(0.2), .red.opacity(0.1), .clear],
        progressBGColor: .clear,
        enableHorizontalScroll: true
    )
    
}

