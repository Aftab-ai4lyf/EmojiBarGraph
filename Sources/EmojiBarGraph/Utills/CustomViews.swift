//
//  CustomViews.swift
//  EmojiBarGraph
//
//  Created by AI 4LYF on 21/07/2025.
//

import Foundation
import SwiftUI

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
    var width: Double
    var height: Double
    var progressColor: String
    var progressBGColor: Color
    var j: Int
    var i: Int
    var minValue: Double
    var maxValue: Double
    var xValue: String
    var title: String
    var fontName: String
    var id: UUID
    var showDecimalValues: Bool
    @Binding var tooltipJIndex: Int
    @Binding var tooltipIIndex: Int
    @Binding var showToolTip: Bool
    @Binding var totalYValues: Int
    @Binding var selectedUUID: UUID
    
    @State var paddingTrailing = CGFloat(0)
    
    var body: some View {
        VStack {
            
            ZStack(alignment: .bottom) {
                
                Capsule()
                    .frame(width: width, height: height)
                    .foregroundColor(progressBGColor)
                
                Capsule()
                    .frame(width: width, height: CGFloat(progress) * height)
                    .foregroundColor(Color(hex: progressColor))
                
            }.tooltip(alignment: .top, visible: $showToolTip, paddingTrailing: $paddingTrailing, backgroundColor: .white) {
                
                if id == selectedUUID {
                    
                    VStack(alignment: .leading, spacing: 4) {
                        
                        if title != "" {
                            
                            Text("\(title)")
                                .font(.custom(fontName, size: 11))
                                .fontWeight(.semibold)
                                .foregroundColor(Color(hex: progressColor))
                            
                        }
                        
                        HStack {
                            
                            Text("Taken:")
                                .font(.custom(fontName, size: 11))
                                .foregroundColor(.black.opacity(0.50))
                            
                            Text(String(format: showDecimalValues ? "%.1f" : "%.0f", minValue))
                                .font(.custom(fontName, size: 11))
                                .fontWeight(.semibold)
                                .foregroundColor(Color(hex: progressColor))
                            
                        }
                        
                        HStack {
                            
                            Text("Total:")
                                .font(.custom(fontName, size: 11))
                                .foregroundColor(.black.opacity(0.50))
                            
                            Text(String(format: showDecimalValues ? "%.1f" : "%.0f", totalProgress))
                                .font(.custom(fontName, size: 11))
                                .fontWeight(.semibold)
                                .foregroundColor(.black)
                            
                        }
                        
                        HStack {
                            
                            Text("Timeline:")
                                .font(.custom(fontName, size: 11))
                                .foregroundColor(.black.opacity(0.50))
                            
                            Text("\(xValue)")
                                .font(.custom(fontName, size: 11))
                                .fontWeight(.semibold)
                                .foregroundColor(.black)
                            
                        }
                        
                    }.frame(width: 95)
                        .padding(.vertical, 4)
                        .onAppear {
                            
                            if i == totalYValues - 1 {
                                
                                paddingTrailing = CGFloat(80)
                                
                            } else {
                                
                                paddingTrailing = CGFloat(0)
                                
                            }
                            
                        }
                    
                }
                
            }
            
        }
        
    }
    
}

