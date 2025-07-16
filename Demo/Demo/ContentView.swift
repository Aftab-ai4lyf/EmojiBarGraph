//
//  ContentView.swift
//  Demo
//
//  Created by AI4LYF on 14/07/2025.
//
//
//import SwiftUI
//import EmojiBarGraph
//struct CoughStackGraphView: View {
//    @State var yDataList:[[EmojiChartView.BarChart]] = [[.init(progress: 3,totalProgress: 3,color: "#2893D7"),.init(progress: 3,totalProgress: 0,color: "#BD013C",emoji: "love")],
//                                                        [.init(progress: 8,totalProgress: 7,color: "#2893D7"),.init(progress: 0,totalProgress: 0,color: "#BD013C",emoji: "love")],
//                                                        [.init(progress: 4,totalProgress: 3,color: "#2893D7"),.init(progress: 0,totalProgress: 0,color: "#BD013C",emoji: "love")],
//                                                        [.init(progress: 5,totalProgress: 4,color: "#2893D7"),.init(progress: 0,totalProgress: 0,color: "#BD013C",emoji: "love")],
//                                                        [.init(progress: 6,totalProgress: 5,color: "#2893D7"),.init(progress: 0,totalProgress: 0,color: "#BD013C",emoji: "love")],
//                                                        [.init(progress: 7,totalProgress: 6,color: "#2893D7"),.init(progress: 0,totalProgress: 0,color: "#BD013C",emoji: "love")],
//                                                        [.init(progress: 8,totalProgress: 7,color: "#2893D7"),.init(progress: 0,totalProgress: 0,color: "#BD013C",emoji: "love")]]
//    
//    var xDataList:[String] = ["Mon","Tue","Wed","Thu","Fri","Sat","Sun"]
//    
//    var body: some View {
//         VStack(spacing: 8) {
//             EmojiChartView(chartType: .StackChart, yDataList: $yDataList, xDataList: xDataList, showEmoji: true, showYValues: false, showLines: false, yAxisTitle: .none , valuesColor: .clear,linesColor:.clear)
//
//                         .frame(height: 200)
//                 .frame(maxWidth: .infinity, alignment: .center)
//         }
//        
//     }
// 
//}
//
//#Preview {
//    CoughStackGraphView()
//}




import SwiftUI
import EmojiBarGraph


struct CoughStackGraphView: View {
    @State var yDataList:[[EmojiChartView.BarChart]] = [
        [.init(progress: 3,totalProgress: 8,color: "#2893D7"), .init(progress: 2,totalProgress: 3,color: "#BD013C",emoji: "love")],
        [.init(progress: 8,totalProgress: 8,color: "#2893D7"), .init(progress: 2,totalProgress: 2,color: "#BD013C",emoji: "love")],
        [.init(progress: 4,totalProgress: 4,color: "#2893D7"), .init(progress: 1,totalProgress: 3,color: "#BD013C",emoji: "love")],
        [.init(progress: 5,totalProgress: 5,color: "#2893D7"), .init(progress: 3,totalProgress: 5,color: "#BD013C",emoji: "love")],
        [.init(progress: 6,totalProgress: 6,color: "#2893D7"), .init(progress: 2,totalProgress: 6,color: "#BD013C",emoji: "love")],
        [.init(progress: 7,totalProgress: 7,color: "#2893D7"), .init(progress: 4,totalProgress: 5,color: "#BD013C",emoji: "love")],
        [.init(progress: 4,totalProgress: 4,color: "#2893D7"), .init(progress: 3,totalProgress: 3,color: "#BD013C",emoji: "love")]
    ]
    
    var xDataList: [String] =  ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]

    var body: some View {
        
        VStack(spacing: 8) {
            
            ZStack {
                
                EmojiChartView(
                    chartType: .StackChart,
                    yDataList: $yDataList,
                    xDataList: xDataList,
                    showEmoji: true,
                    showYValues: true,
                    showLines: true,
                    showAreaMark: true,
                    yAxisTitle: .none,
                    valuesColor: .black,
                    linesColor: .black,
                    arealinesColor: .red.opacity(0.4),
                    gradientColors: [.black.opacity(0.4), .clear]
                )
                
                .frame(height: 200)
                
 

            }
            .frame(height: 200)
        }
        
        .padding(8)
    }
}



#Preview {
    CoughStackGraphView()
}
