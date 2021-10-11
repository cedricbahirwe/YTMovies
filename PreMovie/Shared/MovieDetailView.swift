//
//  MovieDetailView.swift
//  PreMovie
//
//  Created by Cédric Bahirwe on 10/10/2021.
//

import SwiftUI
import AVKit
import SDWebImageSwiftUI

struct MovieDetailView: View {
    let movie: Movie
    var animation: Namespace.ID
    
    private
    static let videoURL = Bundle.main.url(forResource: "vampire", withExtension: "mp4")!
    
    let player = AVPlayer(url: videoURL)

    
    @State private var isPlaying = false
    @State private var orientation = UIDeviceOrientation.unknown

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 0) {
                ZStack {
                    WebImage(url: URL(string: movie.largeCoverImage))
                        .resizable()
                        .placeholder(Image("smoke"))
                        .scaledToFill()
                        .frame(maxWidth: .infinity)
                        .frame(height: 250)
                        .clipped()
                        .matchedGeometryEffect(id: movie.largeCoverImage, in: animation)
                    
                    if isPlaying {
                        
                        VideoPlayer(player: player)
                    } else {
                        Button {
                            isPlaying = true
                            player.play()
                            
                        } label: {
                            Image(systemName: "play")
                                .imageScale(.large)
                                .frame(width: 60, height: 60)
                                .background(Color.green)
                                .clipShape(Circle())
                                .padding(4)
                                .background(Color.white)
                                .clipShape(Circle())
                        }
                    }
                }
                
                if !orientation.isLandscape {
                    
                    VStack(alignment: .leading) {
                        Text(movie.title)
                            .font(.system(.title, design: .monospaced))
                            .fontWeight(.bold)
                        
                        if let genres = movie.genres {
                            Text(genres.joined(separator: ","))
                                .font(.system(.headline, design: .monospaced))
                                .fontWeight(.bold)
                                .foregroundColor(.gray)
                        }
                        
                        HStack {
                            
                            ForEach(0 ..< 5) { index in
                                Image("smoke")
                                    .resizable()
                                    .frame(width: 50, height: 50)
                                    .clipShape(Circle())
                                    .padding(4)
                                    .background(Color.white)
                                    .clipShape(Circle())
                                    .offset(x: -Double(index)*30)
                                    .zIndex(-Double(index))
                            }
                            
                            Spacer()
                        }
                        
                        Text(movie.descriptionFull)
                            .font(.system(.headline, design: .monospaced))
                            .opacity(0.8)
                            .lineSpacing(10)
                            .matchedGeometryEffect(id: movie.descriptionFull, in: animation)
                        Spacer()
                    }
                    .padding()
                    .background(
                        WebImage(url: URL(string: movie.largeCoverImage))
                            .resizable()
                            .scaledToFill()
                            .opacity(0.7)
                            .blur(radius: 20)
                    )
                    .transition(.move(edge: .bottom))
                }
            }
        }
        .foregroundColor(.white.opacity(0.9))
        .onRotate { newOrientation in
            orientation = newOrientation
        }
        .background(Color.primaryBackground.ignoresSafeArea(.all, edges: .bottom))
    }
}

struct MovieDetailView_Previews: PreviewProvider {
    @Namespace static var animate
    static var previews: some View {
        MovieDetailView(movie: .exampleMovie, animation: animate)
    }
}


struct DeviceRotationViewModifier: ViewModifier {
    let action: (UIDeviceOrientation) -> Void

    func body(content: Content) -> some View {
        content
            .onAppear()
            .onReceive(NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification)) { _ in
                action(UIDevice.current.orientation)
            }
    }
}

// A View wrapper to make the modifier easier to use
extension View {
    func onRotate(perform action: @escaping (UIDeviceOrientation) -> Void) -> some View {
        self.modifier(DeviceRotationViewModifier(action: action))
    }
}
