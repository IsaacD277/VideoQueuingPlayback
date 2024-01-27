//
//  Queue.swift
//  ACSPlayer
//
//  Created by Isaac D2 on 1/27/24.
//

import AVKit
import SwiftUI

struct Queue: View {
    @State private var player = AVQueuePlayer()
    
    var videoURLs: [URL]
    
    init(videoURLs: [URL]) {
        self.videoURLs = videoURLs
        
        if let firstURL = videoURLs.first {
            let playerItem = AVPlayerItem(url: firstURL)
            player = AVQueuePlayer(playerItem: playerItem)
            player.play()
        }
    }
    
    var body: some View {
        VideoPlayer(player: player)
            .onAppear() {
                player.play()
            }
            .onChange(of: videoURLs) {
                updateQueue(with: videoURLs)
            }
    }
    
    private func updateQueue(with newURLs: [URL]) {
        for url in newURLs {
            let playerItem = AVPlayerItem(url: url)
            player.insert(playerItem, after: nil)
        }
        
        player.play()
    }
}

#Preview {
    Queue( videoURLs: [
        URL(string: "file:///Users/isaacd2/Movies/Reel/TGU Jib Shot 3.mov")!,
        URL(string: "file:///Users/isaacd2/Movies/Reel/TGU Jib Shot 3.mov")!,
        URL(string: "file:///Users/isaacd2/Movies/Reel/TGU Jib Shot 3.mov")!
    ])
}
