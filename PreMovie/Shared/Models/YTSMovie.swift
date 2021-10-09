//
//  YTSMovie.swift
//  PreMovie (iOS)
//
//  Created by Cédric Bahirwe on 09/10/2021.
//

import Foundation

// MARK: - MoviesResponse
struct MoviesResponse: Decodable {
    let status: Stat
    let statusMessage: String
    let data: MoviesData
    let meta: Meta

    enum CodingKeys: String, CodingKey {
        case status
        case statusMessage = "status_message"
        case data
        case meta = "@meta"
    }
}

// MARK: - MoviesData
struct MoviesData: Decodable {
    let movieCount, limit, pageNumber: Int
    let movies: [Movie]

    enum CodingKeys: String, CodingKey {
        case movieCount = "movie_count"
        case pageNumber = "page_number"
        case limit
        case movies
    }
}

// MARK: - Movie
struct Movie: Decodable, Identifiable, Equatable {
    static func == (lhs: Movie, rhs: Movie) -> Bool {
        lhs.id == rhs.id
    }
    
    let id: Int
    let url: String
    let imdbCode, title, titleEnglish, titleLong: String
    
    let slug: String
    let year: Int
    let rating: Double
    let runtime: Int
    let summary: String
    let genres: [String]?
    
    let descriptionFull, synopsis, ytTrailerCode: String
    let state: Stat
    let language: String
    let mpaRating: String
    
    let backgroundImage, backgroundImageOriginal, smallCoverImage, mediumCoverImage: String
    let largeCoverImage: String
    
    let torrents: [Torrent]
    let dateUploaded: String
    let dateUploadedUnix: Int

    enum CodingKeys: String, CodingKey {
        case id, url
        case imdbCode = "imdb_code"
        case title
        case titleEnglish = "title_english"
        case titleLong = "title_long"
        
        case slug, year, rating, runtime, summary, genres
        
        case descriptionFull = "description_full"
        case synopsis
        case ytTrailerCode = "yt_trailer_code"
        case language
        case mpaRating = "mpa_rating"
        case state
        
        case backgroundImage = "background_image"
        case backgroundImageOriginal = "background_image_original"
        case smallCoverImage = "small_cover_image"
        case mediumCoverImage = "medium_cover_image"
        case largeCoverImage = "large_cover_image"
        
        case torrents
        case dateUploaded = "date_uploaded"
        case dateUploadedUnix = "date_uploaded_unix"
    }
}

enum Stat: String, Decodable {
    case ok = "ok"
}

// MARK: - Torrent
struct Torrent: Decodable {
    let url: String
    let hash: String
    let quality: Quality
    let type: String
    let seeds, peers: Int
    let size: String
    let sizeBytes: Int
    let dateUploaded: String
    let dateUploadedUnix: Int

    enum CodingKeys: String, CodingKey {
        case url, hash, quality, type, seeds, peers, size
        case sizeBytes = "size_bytes"
        case dateUploaded = "date_uploaded"
        case dateUploadedUnix = "date_uploaded_unix"
    }
}

// MARK: - Quality
enum Quality: String, Decodable {
    case the1080P = "1080p"
    case the720P = "720p"
}

// MARK: - Meta
struct Meta: Decodable {
    let serverTime: Int
    let serverTimezone: String
    let apiVersion: Int
    let executionTime: String

    enum CodingKeys: String, CodingKey {
        case serverTime = "server_time"
        case serverTimezone = "server_timezone"
        case apiVersion = "api_version"
        case executionTime = "execution_time"
    }
}


extension Movie {
    static let exampleMovie = Movie(id: 36531, url: "https://yts.mx/movies/no-regret-1993", imdbCode: "tt0137129", title: "No Regret", titleEnglish: "No Regret", titleLong: "No Regret (1993)", slug: "no-regret-1993", year: 1993, rating: 7.4, runtime: 0, summary: "Five HIV positive gay black men discuss their struggles with the disease.", genres: nil, descriptionFull: "Five HIV positive gay black men discuss their struggles with the disease.", synopsis: "Five HIV positive gay black men discuss their struggles with the disease.", ytTrailerCode: "", state: Stat.ok, language: "en", mpaRating: "", backgroundImage: "https://yts.mx/assets/images/movies/no_regret_1993/background.jpg", backgroundImageOriginal: "https://yts.mx/assets/images/movies/no_regret_1993/background.jpg", smallCoverImage: "https://yts.mx/assets/images/movies/no_regret_1993/small-cover.jpg", mediumCoverImage: "https://yts.mx/assets/images/movies/no_regret_1993/medium-cover.jpg", largeCoverImage: "https://yts.mx/assets/images/movies/no_regret_1993/large-cover.jpg",
                                    torrents: [
                                        Torrent(url: "https://yts.mx/torrent/download/165931505DCEC38A9CFCF6AA4CFE5402A93D2444", hash: "165931505DCEC38A9CFCF6AA4CFE5402A93D2444", quality: Quality.the720P, type: "bluray", seeds: 40, peers: 12, size: "352.01 MB", sizeBytes: 369109238, dateUploaded: "2021-10-09 15:16:19", dateUploadedUnix: 1633785379),
                                        Torrent(url: "https://yts.mx/torrent/download/B58C4FFF74EE9FE4B49C391C97EF96957398DDD5", hash: "B58C4FFF74EE9FE4B49C391C97EF96957398DDD5", quality: Quality.the1080P, type: "bluray", seeds: 0, peers: 0, size: "652.58 MB", sizeBytes: 684279726, dateUploaded: "2021-10-09 15:42:15", dateUploadedUnix: 1633786935)], dateUploaded: "2021-10-09 15:16:19", dateUploadedUnix: 1633785379)
}
