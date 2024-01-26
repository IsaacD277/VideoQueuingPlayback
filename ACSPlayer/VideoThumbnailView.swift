//
//  VideoThumbnailView.swift
//  ACSPlayer
//
//  Created by Isaac D2 on 1/22/24.
//

import SwiftUI

struct VideoThumbnailView: View {
    var isSelected: Bool
    var previewImage: Image?
    var videoURL: URL
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                if let image = previewImage {
                    image
                        .resizable()
                        .frame(width: geometry.size.width, height: geometry.size.width / 16 * 9)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .strokeBorder(isSelected ? Color.blue : Color.clear, lineWidth: 2)
                        )
                } else {
                    Text("No preview available")
                }
                Text(videoURL.lastPathComponent)
                    .font(.caption)
            }
        }
    }
    
    init(isSelected: Bool = false, previewImage: Image? = nil, videoURL: URL) {
        self.isSelected = isSelected
        self.previewImage = previewImage
        self.videoURL = videoURL
    }
}

#Preview {
    VideoThumbnailView(videoURL: URL(string: "file:///Users/isaacd2/Movies/Reel/ TGU%20Jib%20Shot%203.mov")!)
}
