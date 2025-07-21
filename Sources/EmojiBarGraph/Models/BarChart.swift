//
//  BarChart.swift
//
//
//  Created by ai4lyf on 16/05/2024.
//

import Foundation

 
@available(iOS 17.0, *)
extension EmojiChartView {
   
    public struct BarChart : Identifiable, Hashable{
        
       public var id:UUID = UUID()
        
       public var progress:Double = 0
       public var totalProgress:Double = 0
       public var color:String = ""
       public var emoji:String = ""
       public var title:String = ""
       public var type:String = ""
       

       // Public initializer if needed
        public init(id: UUID = UUID(), progress: Double = 0, totalProgress: Double = 0, color: String = "", emoji: String = "",title:String = "",type:String = "") {
            self.id = id
            self.progress = progress
            self.totalProgress = totalProgress
            self.color = color
            self.emoji = emoji
            self.title = title
            self.type = type
        }
        
        
    }
    
}
