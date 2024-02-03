//
//  ContentView.swift
//  ACSPlayer
//
//  Created by Isaac D2 on 1/20/24.
//

import SwiftUI
import AVKit

struct ContentView: View {
    @ObservedObject var playerManager: PlayerManager
    @State private var filename: String?
    @State private var showFileChooser = false
    @State private var allVideos: [(URL, Image?)] = []
    @State private var selectedVideoURL: URL?
    @State private var justURLs: [URL] = []

    var body: some View {
        VStack {
            HStack {
                if let selectedVideoURL = selectedVideoURL {
                    VideoPlayerView(selectedVideoURL)
                } else {
                    RoundedRectangle(cornerRadius: 8)
                        .frame(width: 500, height: 500 / 16 * 9) // Match the size to player
                        .padding()
                }
                
                VideoPlayer(player: playerManager.player)
                    .frame(width: 500, height: 500 / 16 * 9)
                    .padding()
            }
            
            Button("\(filename ?? "Select Folder")") {
                selectFolder()
            }
            .padding()
            
            Button("Print Items") {
                if !playerManager.player.items().isEmpty {
                    for item in playerManager.player.items() {
                        if let urlAsset = (item.asset as? AVURLAsset)?.url {
                            let itemURL = urlAsset.lastPathComponent
                            print("Player Item URL: \(itemURL)")
                        }
                    }
                } else {
                    print("nothin' in here fam.")
                }
            }
                
            if !allVideos.isEmpty {
                ScrollView {
                    LazyVGrid(columns: gridLayout()) {
                        ForEach(allVideos, id: \.0) { (videoURL, previewImage) in
                            VStack {
                                VideoThumbnailView(videoURL: videoURL, selectedVideoURL: $selectedVideoURL, playerManager: playerManager)
                            }
                        }
                    }
                }
                .padding()
                
                if let selectedVideoURL = selectedVideoURL {
                    Text("Selected Video: \(selectedVideoURL.lastPathComponent)")
                        .padding()
                } else {
                    Text("No video selected")
                        .padding()
                }
                
            } else {
                Text("No selected folder with videos")
            }
        }
    }
    
    func selectFolder() {
        let panel = NSOpenPanel()
        panel.allowsMultipleSelection = false
        panel.canChooseDirectories = true
        if panel.runModal() == .OK {
            self.filename = panel.url?.lastPathComponent ?? "<none>"
            if let directoryURL = panel.directoryURL {
                do {
                    let videoURLs = try FileManager.default.contentsOfDirectory(at: directoryURL, includingPropertiesForKeys: nil, options: [])
                    allVideos = videoURLs
                        .filter { $0.pathExtension.lowercased() == "mp4" || $0.pathExtension.lowercased() == "mov" } // Add or remove file extensions as needed
                        .compactMap { url in
                            return (url, nil)
                        }
                } catch {
                    fatalError("Failed to select folder")
                }
            }
        }
    }
    
    private func gridLayout() -> [GridItem] {
        let columns = [
            GridItem(.adaptive(minimum: 200), spacing: 8)
        ]
        
        return columns
    }
}


#Preview {
    ContentView(playerManager: PlayerManager())
}
