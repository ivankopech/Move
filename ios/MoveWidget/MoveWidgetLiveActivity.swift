import ActivityKit
import WidgetKit
import SwiftUI

// ⚠️ NOMBRE EXACTO requerido por el plugin
struct LiveActivitiesAppAttributes: ActivityAttributes {

    public struct ContentState: Codable, Hashable {
        var status: String
    }

    var id: String
}

@available(iOS 16.1, *)
struct MoveWidgetLiveActivity: Widget {

    var body: some WidgetConfiguration {
        ActivityConfiguration(for: LiveActivitiesAppAttributes.self) { context in
            // LOCK SCREEN
            VStack(spacing: 8) {
                Text("Live Activity activa")
                    .font(.headline)
                Text(context.state.status)
            }
            .padding()
            .activityBackgroundTint(.cyan)
            .activitySystemActionForegroundColor(.black)

        } dynamicIsland: { context in
            DynamicIsland {

                DynamicIslandExpandedRegion(.center) {
                    VStack(spacing: 4) {
                        Text("Dynamic Island")
                            .font(.headline)
                        Text(context.state.status)
                    }
                }

            } compactLeading: {
                Text("🚚")
            } compactTrailing: {
                Text("ON")
            } minimal: {
                Text("🚚")
            }
        }
    }
}
