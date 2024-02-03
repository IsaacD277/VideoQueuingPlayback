//
//  VideoPlayerView.swift
//  ACSPlayer
//
//  Created by Isaac D2 on 2/2/24.
//

import AVKit
import SwiftUI

struct VideoPlayerView: View {
    var selectedVideoURL: URL?
    
    var size: CGFloat
    
    init(size: CGFloat = 500, _ url: URL?) {
        self.size = size
        self.selectedVideoURL = url
    }
    
    var body: some View {
        if let selectedVideoURL = selectedVideoURL {
            VideoPlayer(player: AVPlayer(url: selectedVideoURL))
                .frame(width: size, height: size / 16 * 9) // Adjust size as needed
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .padding()
        } else {
            
        }
    }
}

#Preview {
    VideoPlayerView(URL(string: "file:///Users/isaacd2/Movies/Reel/TGU Jib Shot 3.mov")!)
}
