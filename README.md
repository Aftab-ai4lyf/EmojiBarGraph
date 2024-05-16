📊 SwiftUI Emoji Bar Graph

This SwiftUI library provides easy-to-use components for creating visually appealing bar graphs using emojis. With support for two types of graphs—StackGraph and GroupGraph—it offers flexibility in presenting data.

## Features:
- **StackGraph:** Display data in a stacked bar graph format.
- **GroupGraph:** Present data in a grouped bar graph layout.
- **Emoji Representation:** Utilize emojis to represent data points, making graphs more engaging and expressive.

## Usage:
1. Import the library into your SwiftUI project.
2. Choose between StackGraph or GroupGraph depending on your data presentation needs.
3. Provide data points and customize the appearance to match your app's design.

## Installation:
You can install this library via Swift Package Manager.

```swift
dependencies: [
    .package(url: "https://github.com/Aftab-ai4lyf/EmojiBarGraph.git", .upToNextMajor(from: "1.0.0"))
]
```

## Requirements:
- iOS 17+
- SwiftUI

## Example:
```swift
import SwiftUI
import EmojiBarGraph

struct ContentView: View {
    @State var yDataList:[[BarChart]] = [[.init(progress: 1,totalProgress: 4,color: "#FA6418"),.init(progress: 3,totalProgress: 14,color: "#BD013C",emoji: "love")],
                                         [.init(progress: 0,totalProgress: 0,color: "#FA6418"),.init(progress: 0,totalProgress: 0,color: "#BD013C",emoji: "love")],
                                         [.init(progress: 0,totalProgress: 0,color: "#FA6418"),.init(progress: 0,totalProgress: 0,color: "#BD013C",emoji: "love")],
                                         [.init(progress: 0,totalProgress: 0,color: "#FA6418"),.init(progress: 0,totalProgress: 0,color: "#BD013C",emoji: "love")],
                                         [.init(progress: 0,totalProgress: 0,color: "#FA6418"),.init(progress: 0,totalProgress: 0,color: "#BD013C",emoji: "love")],
                                         [.init(progress: 0,totalProgress: 0,color: "#FA6418"),.init(progress: 0,totalProgress: 0,color: "#BD013C",emoji: "love")],
                                         [.init(progress: 0,totalProgress: 0,color: "#FA6418"),.init(progress: 0,totalProgress: 0,color: "#BD013C",emoji: "love")]]
    
    var xDataList:[String] = ["Mon","Tue","Wed","Thu","Fri","Sat","Sun"]

    var body: some View {
        VStack {
            Text("StackGraph")
                .font(.title)
            EmojiChartView(chartType: .StackChart, yDataList: $yDataList, xDataList: xDataList, showEmoji: true)
                    .setYAxisTitle("Number of Times")
                .frame(height: 200)

            Text("GroupGraph")
                .font(.title)
            EmojiChartView(chartType: .GroupChart, yDataList: $yDataList, xDataList: xDataList, showEmoji: false)
                    .setYAxisTitle("Number of Times")
                .frame(height: 200)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
```

## License:
This library is available under the MIT license.

## Acknowledgments:
This library is inspired by the need for visually appealing and engaging data representation in SwiftUI apps. Special thanks to contributors and the open-source community for their support.

🚀 Happy graphing! 📊
