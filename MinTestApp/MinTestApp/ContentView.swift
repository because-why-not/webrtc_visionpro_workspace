//
//  ContentView.swift
//  MinTestApp
//
//  Created by Christoph on 24/03/24.
//

import SwiftUI
import WebRTC

struct ContentView: View {
    
    var body: some View {
        
        RTCInitializeSSL()
        RTCSetMinDebugLogLevel(RTCLoggingSeverity.verbose)
        let videoEncoderFactory = RTCDefaultVideoEncoderFactory()
        let videoDecoderFactory = RTCDefaultVideoDecoderFactory()
        let _ = RTCPeerConnectionFactory(encoderFactory: videoEncoderFactory, decoderFactory: videoDecoderFactory)
        
        debugPrint("done")
        
        return VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
