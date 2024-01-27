//
//  ContentView.swift
//  ACSPlayer
//
//  Created by Isaac D2 on 1/20/24.
//

import SwiftUI
import AVKit

struct ContentView: View {
    @State private var filename: String?
    @State private var showFileChooser = false
    @State private var allVideos: [(URL, Image?)] = []
    @State private var selectedVideoURL: URL?

    var body: some View {
        VStack {
            if let selectedVideoURL = selectedVideoURL {
                VideoPlayerView(selectedVideoURL)
                    .frame(width: 500, height: 500 / 16 * 9) // Adjust size as needed
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .padding()
            } else {
                RoundedRectangle(cornerRadius: 8)
                    .frame(width: 500, height: 500 / 16 * 9) // Adjust this size as well to match.
                    .padding(.top)
            }
            
            Button("\(filename ?? "Select Folder")") {
                selectFolder()
            }
            .padding()
            
            if !allVideos.isEmpty {
                ScrollView {
                    let (columns, spacing) = gridLayout()
                    
                    LazyVGrid(columns: columns, spacing: spacing) {
                        ForEach(allVideos, id: \.0) { (videoURL, previewImage) in
                            VideoThumbnailView(videoURL, selectedVideoURL: $selectedVideoURL)
                        }
                    }
                    .padding()
                }
                
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
    
    private func selectFolder() {
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
    
    private func gridLayout() -> ([GridItem], CGFloat) {
        let columns = [
            GridItem(.adaptive(minimum: 200), spacing: 16)
        ]
        let spacing = CGFloat(200)
        
        return (columns, spacing)
    }
}


#Preview {
    ContentView()
}
