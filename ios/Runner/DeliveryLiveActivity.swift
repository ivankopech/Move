import ActivityKit
import WidgetKit
import SwiftUI

@main
struct DeliveryLiveActivityBundle: WidgetBundle {
    var body: some Widget {
        DeliveryLiveActivityWidget()
    }
}

struct DeliveryLiveActivityWidget: Widget {

    var body: some WidgetConfiguration {
        ActivityConfiguration(for: DeliveryAttributes.self) { context in
            
            // 🔵 Lock Screen / Always On Display
            VStack(alignment: .leading, spacing: 10) {
                HStack(spacing: 8) {
                    Text("🚚")
                    Text("Delivery in progress")
                        .font(.headline)
                }
                
                VStack(alignment: .leading, spacing: 4) {
                    Text("Destination:")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    Text(context.state.destination)
                        .font(.body)
                        .lineLimit(2)
                        .minimumScaleFactor(0.8)
                }
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)

        } dynamicIsland: { context in
            
            DynamicIsland {
                
                // 🔵 EXPANDED - Left
                DynamicIslandExpandedRegion(.leading) {
                    Text("🚚")
                        .font(.title2)
                }
                
                // 🔵 EXPANDED - Center
                DynamicIslandExpandedRegion(.center) {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Destination:")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        
                        Text(context.state.destination)
                            .font(.headline)
                            .lineLimit(2)
                            .minimumScaleFactor(0.8)
                    }
                }
                
                // 🔵 EXPANDED - Right
                DynamicIslandExpandedRegion(.trailing) {
                    Text("ID: \(context.attributes.deliveryId)")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                
            } compactLeading: {
                Text("🚚")
            } compactTrailing: {
                Text("🏁") 
            } minimal: {
                Text("🚚")
            }
        }
        .activityAttributesDisplayName("Delivery") // 👈 aparece en Ajustes de iOS
    }
}