//
//  BarChart.swift
//
//
//  Created by ai4lyf on 16/05/2024.
//

import Foundation

 
@available(iOS 17.0, *)
extension EmojiChartView {
   
    struct BarChart : Identifiable, Hashable{
        
        var id:UUID = UUID()
        
        var progress:Double = 0
        var totalProgress:Double = 0
        var color:String = ""
        var emoji:String = ""
        
        
    }
    
}
