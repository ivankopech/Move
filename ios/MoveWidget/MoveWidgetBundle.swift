//
//  MoveWidgetBundle.swift
//  MoveWidget
//
//  Created by Ivan Kopech on 28/01/2026.
//

import WidgetKit
import SwiftUI

@main
struct MoveWidgetBundle: WidgetBundle {
    var body: some Widget {
        MoveWidget()
        MoveWidgetControl()
        MoveWidgetLiveActivity()
    }
}
