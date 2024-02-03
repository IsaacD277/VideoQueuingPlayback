# Upcoming Plans

<!--@START_MENU_TOKEN@-->Summary<!--@END_MENU_TOKEN@-->

## Overview

<!--@START_MENU_TOKEN@-->Text<!--@END_MENU_TOKEN@-->

### Section header

User customizable video thumbnail sizing and scaling 

Create a saved queue to be loaded up later

Match size of empty selectedVideoURL in ContentView default rectangle to match the VideoPlayerView(size:)



## Functions to Save
### turn an AVPlayerItem into the file name
    func toString(_ item: AVPlayerItem) -> String {
        if let urlAsset = item.asset as? AVURLAsset {
            let itemURL = urlAsset.url
            let lastPathComponent = itemURL.lastPathComponent
            return lastPathComponent
        } else {
            return "Result failed"
        }
    }
    
    func toURL(_ item: AVPlayerItem) -> URL {
        if let urlAsset = item.asset as? AVURLAsset {
            let itemURL = urlAsset.url
            return itemURL
        } else {
            return URL(string: "")!
        }
    }

### Prints the contents of the Queue
    Button("Print Items") {
        for item in player.items() {
            if let urlAsset = (item.asset as? AVURLAsset)?.url {
                let itemURL = urlAsset.lastPathComponent
                print("Player Item URL: \(itemURL)")
            }
        }
    }
