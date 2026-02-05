// import ActivityKit
// import WidgetKit
// import SwiftUI


// struct LiveActivitiesAppAttributes: ActivityAttributes, Identifiable {
//     public typealias LiveDeliveryData = ContentState

//     public struct ContentState: Codable, Hashable { }

//     var id = UUID()
// }

// extension LiveActivitiesAppAttributes {
//     func prefixedKey(_ key: String) -> String {
//         return "\(id)_\(key)"
//     }
// }

// let sharedDefaults = UserDefaults(suiteName: "group.com.softing.move")!

// struct MoveWidgetLiveActivity: Widget {
//     var body: some WidgetConfiguration {
//         ActivityConfiguration(for: LiveActivitiesAppAttributes.self) { context in
//             let status = sharedDefaults.string(
//                 forKey: context.attributes.prefixedKey("status")
//             ) ?? "Sin estado"

//             let distance = sharedDefaults.double(
//                 forKey: context.attributes.prefixedKey("distance")
//             ) 

//             let destination = sharedDefaults.string(
//                 forKey: context.attributes.prefixedKey("destination")
//             ) ?? "—"
            

//             VStack(alignment: .leading, spacing: 8) {
//                 Text("Move").font(.headline)
//                 Text(status).font(.title3)

//                 Text("Destino: \(destination)")
//                     .font(.subheadline)
//                     .lineLimit(1)

//                 Text(String(format: "Distancia: %.1f km", distance))
//                     .font(.subheadline)
//             }
//             .padding()

//         } dynamicIsland: { context in
            
//             let status = sharedDefaults.string(
//                 forKey: context.attributes.prefixedKey("status")
//             ) ?? "Sin estado"

//             let distance = sharedDefaults.double(
//                 forKey: context.attributes.prefixedKey("distance")
//             )

//             let destination = sharedDefaults.string(
//                 forKey: context.attributes.prefixedKey("destination")
//             ) ?? "—"

//             DynamicIsland {

//                 DynamicIslandExpandedRegion(.leading) { Text("Move") }
//                 DynamicIslandExpandedRegion(.trailing) { Text("🚚") }
//                 DynamicIslandExpandedRegion(.bottom) {
//                     VStack(alignment: .leading, spacing: 4) {
//                         Text(status)
//                             .font(.headline)
//                             .lineLimit(1)
                        
//                         Text(String(format: "%.1f km", distance))
//                             .font(.subheadline)

//                         Text(destination)
//                             .font(.subheadline)
//                             .lineLimit(1)
//                     }    
//                 }
//             } compactLeading: {
//                 Text("🚚")
//             } compactTrailing: {
//                 Text(String(format: "%.0f", distance))
//             } minimal: {
//                 Text("🚚")
//             }
//         }
//     }
// }

import ActivityKit
import WidgetKit
import SwiftUI

struct LiveActivitiesAppAttributes: ActivityAttributes, Identifiable {
    public typealias LiveDeliveryData = ContentState
    public struct ContentState: Codable, Hashable { }
    var id = UUID()
}

extension LiveActivitiesAppAttributes {
    func prefixedKey(_ key: String) -> String {
        return "\(id)_\(key)"
    }
}

let sharedDefaults = UserDefaults(suiteName: "group.com.softing.move")!

struct MoveWidgetLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: LiveActivitiesAppAttributes.self) { context in

            // ✅ Leer valores reales desde App Group
            let status = sharedDefaults.string(
                forKey: context.attributes.prefixedKey("status")
            ) ?? "Sin estado"

            let destination = sharedDefaults.string(
                forKey: context.attributes.prefixedKey("destination")
            ) ?? "—"

            let distance = sharedDefaults.double(
                forKey: context.attributes.prefixedKey("distance")
            ) // si no existe, devuelve 0.0

            VStack(alignment: .leading, spacing: 8) {
                Text("Move").font(.headline)
                Text(status).font(.title3)

                // ✅ Mostramos destino + distancia (lock screen / banner)
                Text("Destination: \(destination)")
                    .font(.subheadline)
                    .lineLimit(1)

                Text(String(format: "Distance: %.1f km", distance))
                    .font(.subheadline)
            }
            .padding()

        } dynamicIsland: { context in
            if #available(iOS 16.1, *) {
            // ✅ Leer valores reales desde App Group
            let status = sharedDefaults.string(
                forKey: context.attributes.prefixedKey("status")
            ) ?? "Sin estado"

            let destination = sharedDefaults.string(
                forKey: context.attributes.prefixedKey("destination")
            ) ?? "—"

            let distance = sharedDefaults.double(
                forKey: context.attributes.prefixedKey("distance")
            )

            return DynamicIsland {
                DynamicIslandExpandedRegion(.leading) {
                    Text("Move")
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text("🚚")
                }
                DynamicIslandExpandedRegion(.bottom) {
                    VStack(alignment: .leading, spacing: 4) {
                        Text(status)
                            .font(.headline)
                            .lineLimit(1)

                        Text(destination)
                            .font(.subheadline)
                            .lineLimit(1)

                        Text(String(format: "%.1f km", distance))
                            .font(.subheadline)
                    }
                }
            } compactLeading: {
                Text("🚚")
            } compactTrailing: {
                // Compact: algo corto pero útil (km, por ejemplo)
                Text(String(format: "%.1fkm", distance))
            } minimal: {
                Text("🚚")
            }
        } else {
            return DynamicIsland {
                DynamicIslandExpandedRegion(.leading) { EmptyView() }
            } compactLeading: {
                EmptyView()
            } compactTrailing: {
                EmptyView()
            } minimal: {
                EmptyView()
            }
        }
        }
    }
}
