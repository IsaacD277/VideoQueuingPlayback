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
    
    @State private var justURLs: [URL] = []

    var body: some View {
        VStack {
            VStack {
                HStack {
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
                    
                    Queue(videoURLs: justURLs)
                        .frame(width: 500, height: 500 / 16 * 9) // Adjust size as needed
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                        .padding()
                }
                
                // Video selection buttons
                ForEach(justURLs, id: \.self) { index in
                    Text(index.lastPathComponent)
                }
                .padding()
            }
            
            Button("\(filename ?? "Select Folder")") {
                selectFolder()
            }
            .padding()
            
            if !allVideos.isEmpty {
                ScrollView {
                    LazyVGrid(columns: gridLayout()) {
                        ForEach(allVideos, id: \.0) { (videoURL, previewImage) in
                            VStack {
                                VideoThumbnailView(videoURL, selectedVideoURL: $selectedVideoURL)
                                #warning("User selectable thumbnail sizing and scaling")
                                Button("Add to Queue") {
                                    addToQueue(videoURL)
                                }
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
    
    private func addToQueue(_ url: URL) {
        justURLs.append(url)
        print("Added video to queue: \(url)")
    }
    
    private func gridLayout() -> [GridItem] {
        let columns = [
            GridItem(.adaptive(minimum: 200), spacing: 8)
        ]
        
        return columns
    }
}


#Preview {
    ContentView()
}
