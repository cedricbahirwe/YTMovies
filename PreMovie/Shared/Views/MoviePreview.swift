//
//  MoviePreview.swift
//  PreMovie (iOS)
//
//  Created by Cédric Bahirwe on 10/10/2021.
//

import SwiftUI
import SDWebImageSwiftUI

struct MoviePreview: View {
    init(of movie: Movie, size: CGSize) {
        self.movie = movie
        self.size = size
    }
    
    let movie: Movie
    let size: CGSize
    var body: some View {
        ZStack {
            WebImage(url: URL(string: movie.largeCoverImage))
                .resizable()
                .placeholder(Image("smoke"))
                .scaledToFill()
                .frame(width: size.width)
                .clipped()
            //                                    .frame(width: geo.size.width)
            //                                    .frame(maxHeight: geo.size.height)
            //                                    .blur(radius: 5)
                .blur(radius: 4, opaque: false)
            
            VStack {
                ZStack(alignment: .topTrailing) {
                    WebImage(url: URL(string: movie.largeCoverImage))
                        .resizable()
                        .placeholder(Image("smoke"))
                        .scaledToFill()
                        .frame(maxWidth: size.width*0.8)
                        .clipped()
                        .shadow(radius: 10)
                    
                    Text(movie.rating.description)
                        .font(.title2.weight(.semibold))
                        .frame(width: 60, height: 60)
                        .background(Color.green)
                        .clipShape(Circle())
                        .offset(x: 30, y: 30)
                    
                }
                
                VStack {
                    Text(movie.title)
                        .font(.system(.title2, design: .monospaced))
                        .fontWeight(.semibold)
                    HStack {
                        Text(movie.mpaRating)
                        Text("1h 49 min")
                    }
                    .font(.system(.title2, design: .monospaced))
                    .foregroundColor(.gray)
                }
                .padding()
            }
            .padding(.top, 40)
        }
        .frame(width: size.width)
    }
}

struct MoviePreview_Previews: PreviewProvider {
    static var previews: some View {
        MoviePreview(of: .exampleMovie, size: CGSize(width: 350, height: 600))
    }
}
