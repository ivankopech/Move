//
//  MoveWidgetLiveActivity.swift
//  MoveWidget
//
//  Created by Ivan Kopech on 28/01/2026.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct MoveWidgetAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var emoji: String
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}

struct MoveWidgetLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: MoveWidgetAttributes.self) { context in
            // Lock screen/banner UI goes here
            VStack {
                Text("Hello \(context.state.emoji)")
            }
            .activityBackgroundTint(Color.cyan)
            .activitySystemActionForegroundColor(Color.black)

        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {
                    Text("Leading")
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text("Trailing")
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text("Bottom \(context.state.emoji)")
                    // more content
                }
            } compactLeading: {
                Text("L")
            } compactTrailing: {
                Text("T \(context.state.emoji)")
            } minimal: {
                Text(context.state.emoji)
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }
}

extension MoveWidgetAttributes {
    fileprivate static var preview: MoveWidgetAttributes {
        MoveWidgetAttributes(name: "World")
    }
}

extension MoveWidgetAttributes.ContentState {
    fileprivate static var smiley: MoveWidgetAttributes.ContentState {
        MoveWidgetAttributes.ContentState(emoji: "😀")
     }
     
     fileprivate static var starEyes: MoveWidgetAttributes.ContentState {
         MoveWidgetAttributes.ContentState(emoji: "🤩")
     }
}

#Preview("Notification", as: .content, using: MoveWidgetAttributes.preview) {
   MoveWidgetLiveActivity()
} contentStates: {
    MoveWidgetAttributes.ContentState.smiley
    MoveWidgetAttributes.ContentState.starEyes
}
