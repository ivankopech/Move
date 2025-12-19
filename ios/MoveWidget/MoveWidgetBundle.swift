import WidgetKit
import SwiftUI

@main
struct MoveWidgetBundle: WidgetBundle {
    var body: some Widget {
        if #available(iOS 16.1, *) {
            MoveWidgetLiveActivity()
        }
    }
}
