//
//  VideoThumbnailView.swift
//  ACSPlayer
//
//  Created by Isaac D2 on 1/22/24.
//

import AVKit
import SwiftUI

struct VideoThumbnailView: View {
    @ObservedObject var playerManager: PlayerManager
    @Binding var selectedVideoURL: URL?
    
    @State private var previewImage: Image?
    
    var videoURL: URL
    
    init(videoURL: URL, selectedVideoURL: Binding<URL?>, playerManager: PlayerManager) {
        self.videoURL = videoURL
        self._selectedVideoURL = selectedVideoURL
        self.playerManager = playerManager
    }
    
    var body: some View {
        VStack {
            ZStack(alignment: .bottomTrailing) {
                if let previewImage = previewImage {
                    previewImage
                        .resizable()
                        .frame(width: 200, height: 200 / 16 * 9)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .strokeBorder(selectedVideoURL == videoURL ? Color.blue : Color.clear, lineWidth: 2)
                        )
                        .onTapGesture {
                            selectedVideoURL = videoURL
                        }
                } else {
                    Text("No preview available")
                        .frame(width: 200, height: 200 / 16 * 9)
                        .background(Color.gray)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                }
                
                Image(systemName: "plus.circle")
                    .onTapGesture {
                        playerManager.player.insert(AVPlayerItem(url: videoURL), after: nil)
                    }
                    .padding(3)
            }
            
            Text(videoURL.lastPathComponent)
                .font(.caption)
        }
        .onAppear {
            DispatchQueue.global(qos: .userInitiated).async {
                generatePreviewImage()
            }
        }
    }

    private func generatePreviewImage() {
        let asset = AVAsset(url: videoURL)
        let generator = AVAssetImageGenerator(asset: asset)
        generator.appliesPreferredTrackTransform = true
        
        do {
            let cgImage = try generator.copyCGImage(at: .zero, actualTime: nil)
            let nsImage = NSImage(cgImage: cgImage, size: .zero)
            self.previewImage = Image(nsImage: nsImage)
        } catch {
            print("Error generating preview image: \(error)")
        }
    }
}

#Preview {
    VideoThumbnailView(videoURL: URL(string: "file:///Users/isaacd2/Movies/Reel/TGU Jib Shot 3.mov")!, selectedVideoURL: .constant(nil), playerManager: PlayerManager())
}
