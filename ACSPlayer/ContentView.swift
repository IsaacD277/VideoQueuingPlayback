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
    @State private var videoURL: URL?
    @State private var videoLocation: URL?
    @State private var allVideos: [(URL, Image?)] = []
    @State private var columnWidth: CGFloat?
    @State private var selectedVideo: URL?
    @State var previewURL = UserDefaults.standard.url(forKey: "preview")

    var body: some View {
        VStack {
            // Text(filename)
            Button("\(filename ?? "Select Folder")") {
                let panel = NSOpenPanel()
                panel.allowsMultipleSelection = false
                panel.canChooseDirectories = true
                if panel.runModal() == .OK {
                    self.filename = panel.url?.lastPathComponent ?? "<none>"
                    self.videoURL = panel.url
                    self.videoLocation = panel.directoryURL
                    if let directoryURL = panel.directoryURL {
                        do {
                            let videoURLs = try FileManager.default.contentsOfDirectory(at: directoryURL, includingPropertiesForKeys: nil, options: [])
                            allVideos = videoURLs
                                .filter { $0.pathExtension.lowercased() == "mp4" || $0.pathExtension.lowercased() == "mov" } // Add or remove file extensions as needed
                                .compactMap { url in
                                    return (url, nil)
                                }
                            DispatchQueue.global(qos: .background).async {
                                self.loadPreviewImages()
                            }
                            print("All videos: \(allVideos)")
                        } catch {
                            print("Error getting contents of directory: \(error)")
                        }
                    }
                }
            }
            
            if !allVideos.isEmpty {
                ScrollView {
                    let (columns, spacing) = gridLayout()
                    
                    LazyVGrid(columns: columns, spacing: spacing) {
                        ForEach(allVideos, id: \.0) { (videoURL, previewImage) in
                            VideoThumbnailView(previewImage: previewImage ?? Image(systemName: "pencil"), videoURL: videoURL)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 8)
                                        .strokeBorder((selectedVideo == videoURL) ? Color.blue : Color.clear, lineWidth: 2)
                                )
                                .onTapGesture {
                                    selectedVideo = videoURL
                                    previewURL = videoURL
                                    UserDefaults.standard.set(previewURL, forKey: "preview")
                                }
                                .padding()
                        }
                    }
                }
            } else {
                Text("No selected folder with videos")
            }
        }
    }

    func loadPreviewImages() {
        for index in 0..<allVideos.count {
            let url = allVideos[index].0
            let previewImage = generatePreviewImage(url: url)
            DispatchQueue.main.async {
                self.allVideos[index].1 = previewImage
            }
        }
    }

    func generatePreviewImage(url: URL) -> Image? {
        let asset = AVAsset(url: url)
        let generator = AVAssetImageGenerator(asset: asset)
        generator.appliesPreferredTrackTransform = true

        do {
            let cgImage = try generator.copyCGImage(at: .zero, actualTime: nil)
            let nsImage = NSImage(cgImage: cgImage, size: .zero)
            return Image(nsImage: nsImage)
        } catch {
            print("Error generating preview image: \(error)")
            return nil
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
