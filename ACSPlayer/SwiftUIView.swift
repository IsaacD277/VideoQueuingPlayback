//
//  SwiftUIView.swift
//  ACSPlayer
//
//  Created by Isaac D2 on 1/20/24.
//

import SwiftUI

struct FileListView: View {
    let folderURL = FileManager.default.homeDirectoryForCurrentUser
    @State private var fileNames: [String] = []

    var body: some View {
        List(fileNames, id: \.self) { fileName in
            Text(fileName)
        }
        .onAppear {
            fileNames = getFilesWithExtension("txt")
        }
    }

    func getFilesWithExtension(_ fileExtension: String) -> [String] {
        do {
            let fileURLs = try FileManager.default.contentsOfDirectory(at: folderURL, includingPropertiesForKeys: nil)
            return fileURLs.filter { $0.pathExtension == fileExtension }.map { $0.lastPathComponent }
        } catch {
            print("Error: \(error)")
            return []
        }
    }
}


#Preview {
    FileListView()
}
