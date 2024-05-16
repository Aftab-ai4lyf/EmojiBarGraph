//
//  BarChart.swift
//
//
//  Created by ai4lyf on 16/05/2024.
//

import Foundation

 

struct BarChart : Identifiable, Hashable{
    
    var id:UUID = UUID()
    
    var progress:Double = 0
    var totalProgress:Double = 0
    var color:String = ""
    var emoji:String = ""
   
    
}
