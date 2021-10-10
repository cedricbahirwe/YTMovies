//
//  MovieDetailView.swift
//  PreMovie
//
//  Created by Cédric Bahirwe on 10/10/2021.
//

import SwiftUI
import SDWebImageSwiftUI

struct MovieDetailView: View {
    let movie: Movie
    @Namespace var animation: Namespace.ID
    
    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                WebImage(url: URL(string: movie.largeCoverImage))
                    .resizable()
                    .placeholder(Image("smoke"))
                    .scaledToFill()
                    .frame(maxWidth: .infinity)
                    .frame(height: 300)
                    .clipped()
                
                Button {
                    // Play
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
                            .frame(width: 60, height: 60)
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
//                    .font(.sys)
                    .opacity(0.8)
                    .lineSpacing(10)
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
        .foregroundColor(.white.opacity(0.9))
        .background(Color.primaryBackground.ignoresSafeArea())
    }
}

struct MovieDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetailView(movie: .exampleMovie)
    }
}
