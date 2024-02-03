//
//  ACSPlayerApp.swift
//  ACSPlayer
//
//  Created by Isaac D2 on 1/20/24.
//

import SwiftUI

@main
struct ACSPlayerApp: App {
    @StateObject var playerManager = PlayerManager()
    
    var body: some Scene {
        WindowGroup {
            ContentView(playerManager: playerManager)
        }
        Window("Viewer", id: "Viewer") {
            QueuePlayerView(playerManager: playerManager)
        }
    }
}
