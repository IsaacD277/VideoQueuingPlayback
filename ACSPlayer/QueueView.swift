//
//  QueueView.swift
//  ACSPlayer
//
//  Created by Isaac D2 on 1/29/24.
//

import AVKit
import SwiftUI

struct QueueView: View {
    var items: [AVPlayerItem]
    var player: AVQueuePlayer
    
    init(player: AVQueuePlayer) {
        self.player = player
        self.items = player.items()
    }
    
    var body: some View {
        VStack {
            List {
                ForEach(items, id: \.self) { item in
                    Text(toString(item))
                    
                    Button() {
                        // player.removeFromQueue(toURL(item))
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
        }
    }
    
    func toString(_ item: AVPlayerItem) -> String {
        if let urlAsset = item.asset as? AVURLAsset {
            let itemURL = urlAsset.url
            let lastPathComponent = itemURL.lastPathComponent
            return lastPathComponent
        } else {
            return "Result failed"
        }
    }
    
    func toURL(_ item: AVPlayerItem) -> URL {
        if let urlAsset = item.asset as? AVURLAsset {
            let itemURL = urlAsset.url
            return itemURL
        } else {
            return URL(string: "")!
        }
    }
}

//#Preview {
//    QueueView()
//}
