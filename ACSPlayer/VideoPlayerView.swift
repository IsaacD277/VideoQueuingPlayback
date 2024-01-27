//
//  VideoPlayerView.swift
//  ACSPlayer
//
//  Created by Isaac D2 on 1/26/24.
//

import SwiftUI
import AVKit

struct VideoPlayerView: View {
    private var player: AVQueuePlayer
    private var looper: AVPlayerLooper?
    
    var videoURL: URL
    
    init(_ videoURL: URL) {
        self.videoURL = videoURL
        self.player = AVQueuePlayer()
        self.looper = AVPlayerLooper(player: player, templateItem: AVPlayerItem(url: videoURL))
    }
    
    var body: some View {
        VideoPlayer(player: player)
            .onChange(of: videoURL, initial: true) {
                player.play()
            }
    }
}


#Preview {
    VideoPlayerView(URL(string: "file:///Users/isaacd2/Movies/Reel/TGU Jib Shot 3.mov")!)
}
