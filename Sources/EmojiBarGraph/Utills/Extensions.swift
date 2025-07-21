    //
    //  Extensions.swift
    //  EmojiBarGraph
    //
    //  Created by AI 4LYF on 21/07/2025.
    //
import Foundation
import SwiftUI

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
extension EmojiGroupBarChart {
    func setYAxisTitle(_ title: String) -> EmojiGroupBarChart {
        EmojiGroupBarChart(
            yValues: $yValues,
            xValues: xValues,
            showEmoji: showEmoji,
            yAxisTitle: title,
            showYValues: showYValues,
            showLines: showLines,
            showAreaMark: showAreaMark,
            arealinesColor: arealinesColor,
            gradientColors: gradientColors
        )
    }
    
    func setValuesColor(_ color: Color) -> EmojiGroupBarChart {
        EmojiGroupBarChart(
            yValues: $yValues,
            xValues: xValues,
            showEmoji: showEmoji,
            valuesColor: color,
            yAxisTitle: yAxisTitle,
            showYValues: showYValues,
            showLines: showLines,
            showAreaMark: showAreaMark,
            arealinesColor: arealinesColor,
            gradientColors: gradientColors
        )
    }
    
    func setLinesColor(_ color: Color) -> EmojiGroupBarChart {
        EmojiGroupBarChart(
            yValues: $yValues,
            xValues: xValues,
            showEmoji: showEmoji,
            valuesColor: valuesColor,
            linesColor: color,
            yAxisTitle: yAxisTitle,
            showYValues: showYValues,
            showLines: showLines,
            showAreaMark: showAreaMark,
            arealinesColor: arealinesColor,
            gradientColors: gradientColors
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
            yAxisTitle: yAxisTitle,
            showYValues: showYValues,
            showLines: showLines,
            showAreaMark: showAreaMark,
            arealinesColor: arealinesColor,
            gradientColors: gradientColors
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
            yAxisTitle: yAxisTitle,
            showYValues: showYValues,
            showLines: showLines,
            showAreaMark: showAreaMark,
            arealinesColor: arealinesColor,
            gradientColors: gradientColors
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
            yAxisTitleSize: size,
            showYValues: showYValues,
            showLines: showLines,
            showAreaMark: showAreaMark,
            arealinesColor: arealinesColor,
            gradientColors: gradientColors
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
            yAxisValuesSize: size,
            showYValues: showYValues,
            showLines: showLines,
            showAreaMark: showAreaMark,
            arealinesColor: arealinesColor,
            gradientColors: gradientColors
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
            showYValues: showYValues,
            showLines: showLines,
            emojiHeight: size,
            showAreaMark: showAreaMark,
            arealinesColor: arealinesColor,
            gradientColors: gradientColors
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
            showYValues: showYValues,
            showLines: showLines,
            emojiHeight: emojiHeight,
            emojiWidth: size,
            showAreaMark: showAreaMark,
            arealinesColor: arealinesColor,
            gradientColors: gradientColors
        )
    }
    
    func showLine(_ show: Bool) -> EmojiGroupBarChart {
        EmojiGroupBarChart(
            yValues: $yValues,
            xValues: xValues,
            showEmoji: showEmoji,
            valuesColor: valuesColor,
            linesColor: linesColor,
            showYValues: showYValues,
            showLines: show,
            showAreaMark: showAreaMark,
            arealinesColor: arealinesColor,
            gradientColors: gradientColors
        )
    }
    
    func showYValue(_ show: Bool) -> EmojiGroupBarChart {
        EmojiGroupBarChart(
            yValues: $yValues,
            xValues: xValues,
            showEmoji: showEmoji,
            valuesColor: valuesColor,
            linesColor: linesColor,
            showYValues: show,
            showLines: showLines,
            showAreaMark: showAreaMark,
            arealinesColor: arealinesColor,
            gradientColors: gradientColors
        )
    }
}


@available(iOS 17.0, *)
extension EmojiGroupStackBarChart {
    func setYAxisTitle(_ title: String) -> EmojiGroupStackBarChart {
        EmojiGroupStackBarChart(yValues: $yValues,
                                xValues: xValues,
                                showEmoji: showEmoji,
                                showYValues: showYValues,
                                showLines: showLines,
                                progressBGColor: progressBGColor,
                                yAxisTitle: title,
                                showAreaMark: showAreaMark,
                                arealinesColor: arealinesColor,
                                gradientColors: gradientColors)
    }
    
    func setValuesColor(_ color: Color) -> EmojiGroupStackBarChart {
        EmojiGroupStackBarChart(yValues: $yValues,
                                xValues: xValues,
                                showEmoji: showEmoji,
                                showYValues: showYValues,
                                showLines: showLines,
                                valuesColor: color,
                                progressBGColor: progressBGColor,
                                yAxisTitle: yAxisTitle,
                                showAreaMark: showAreaMark,
                                arealinesColor: arealinesColor,
                                gradientColors: gradientColors)
    }
    
    func setLinesColor(_ color: Color) -> EmojiGroupStackBarChart {
        EmojiGroupStackBarChart(yValues: $yValues,
                                xValues: xValues,
                                showEmoji: showEmoji,
                                showYValues: showYValues,
                                showLines: showLines,
                                linesColor: color,
                                progressBGColor: progressBGColor,
                                yAxisTitle: yAxisTitle,
                                showAreaMark: showAreaMark,
                                arealinesColor: arealinesColor,
                                gradientColors: gradientColors)
    }
    
    func setBarBackgroundColor(_ color: Color) -> EmojiGroupStackBarChart {
        EmojiGroupStackBarChart(yValues: $yValues,
                                xValues: xValues,
                                showEmoji: showEmoji,
                                showYValues: showYValues,
                                showLines: showLines,
                                progressBGColor: color,
                                yAxisTitle: yAxisTitle,
                                showAreaMark: showAreaMark,
                                arealinesColor: arealinesColor,
                                gradientColors: gradientColors)
    }
    
    func setFontName(_ name: String) -> EmojiGroupStackBarChart {
        EmojiGroupStackBarChart(yValues: $yValues,
                                xValues: xValues,
                                showEmoji: showEmoji,
                                showYValues: showYValues,
                                showLines: showLines,
                                progressBGColor: progressBGColor,
                                fontName: name,
                                yAxisTitle: yAxisTitle,
                                showAreaMark: showAreaMark,
                                arealinesColor: arealinesColor,
                                gradientColors: gradientColors)
    }
    
    func setYAxisTitleSize(_ size: Int) -> EmojiGroupStackBarChart {
        EmojiGroupStackBarChart(yValues: $yValues,
                                xValues: xValues,
                                showEmoji: showEmoji,
                                showYValues: showYValues,
                                showLines: showLines,
                                progressBGColor: progressBGColor,
                                yAxisTitle: yAxisTitle,
                                yAxisTitleSize: size,
                                showAreaMark: showAreaMark,
                                arealinesColor: arealinesColor,
                                gradientColors: gradientColors)
    }
    
    func setYAxisValuesSize(_ size: Int) -> EmojiGroupStackBarChart {
        EmojiGroupStackBarChart(yValues: $yValues,
                                xValues: xValues,
                                showEmoji: showEmoji,
                                showYValues: showYValues,
                                showLines: showLines,
                                progressBGColor: progressBGColor,
                                yAxisTitle: yAxisTitle,
                                yAxisValuesSize: size,
                                showAreaMark: showAreaMark,
                                arealinesColor: arealinesColor,
                                gradientColors: gradientColors)
    }
    
    func setEmojiHeight(_ size: Int) -> EmojiGroupStackBarChart {
        EmojiGroupStackBarChart(yValues: $yValues,
                                xValues: xValues,
                                showEmoji: showEmoji,
                                showYValues: showYValues,
                                showLines: showLines,
                                progressBGColor: progressBGColor,
                                yAxisTitle: yAxisTitle,
                                emojiHeight: size,
                                showAreaMark: showAreaMark,
                                arealinesColor: arealinesColor,
                                gradientColors: gradientColors)
    }
    
    func setEmojiWidth(_ size: Int) -> EmojiGroupStackBarChart {
        EmojiGroupStackBarChart(yValues: $yValues,
                                xValues: xValues,
                                showEmoji: showEmoji,
                                showYValues: showYValues,
                                showLines: showLines,
                                progressBGColor: progressBGColor,
                                yAxisTitle: yAxisTitle,
                                emojiWidth: size,
                                showAreaMark: showAreaMark,
                                arealinesColor: arealinesColor,
                                gradientColors: gradientColors)
    }
    
    func showLine(_ show: Bool) -> EmojiGroupStackBarChart {
        EmojiGroupStackBarChart(yValues: $yValues,
                                xValues: xValues,
                                showEmoji: showEmoji,
                                showYValues: showYValues,
                                showLines: show,
                                progressBGColor: progressBGColor,
                                yAxisTitle: yAxisTitle,
                                showAreaMark: showAreaMark,
                                arealinesColor: arealinesColor,
                                gradientColors: gradientColors)
    }
    
    func showYValue(_ show: Bool) -> EmojiGroupStackBarChart {
        EmojiGroupStackBarChart(yValues: $yValues,
                                xValues: xValues,
                                showEmoji: showEmoji,
                                showYValues: show,
                                showLines: showLines,
                                progressBGColor: progressBGColor,
                                yAxisTitle: yAxisTitle,
                                showAreaMark: showAreaMark,
                                arealinesColor: arealinesColor,
                                gradientColors: gradientColors)
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
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}



@available(iOS 17.0, *)
extension View {
    func tooltip(alignment: Edge, visible: Binding<Bool>, paddingTrailing: Binding<CGFloat> = .constant(CGFloat(0)), backgroundColor: Color = .white, @ViewBuilder tooltip: @escaping () -> some View) -> some View {
        modifier(TooltipDisplayingModifier(alignment: alignment, visible: visible, paddingTrailing: paddingTrailing, backgroundColor: backgroundColor, tooltip: tooltip))
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
                .padding(.trailing, paddingTrailing)
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

@available(iOS 17.0, *)
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

@available(iOS 17.0, *)
extension Double {
    func rounded(toPlaces places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}

