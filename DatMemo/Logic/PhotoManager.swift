import SwiftUI
import Combine

class PhotoManager: ObservableObject {
    @Published var photos: [Date: UIImage] = [:]
    @Published var texts: [Date: String] = [:]

    private let photosDirectoryName = "Photos"
    private let textsDirectoryName = "Texts"
    private let fileExtension = "json"
    private let queue = DispatchQueue(label: "PhotoManagerQueue", qos: .userInitiated)

    init() {
        createDirectoriesIfNeeded()
        createFilesIfNeeded()
        loadPhotos()
        loadTexts()
    }

    func savePhoto(_ photo: UIImage, for date: Date) {
        photos[date] = photo
        queue.async { [weak self] in
            self?.savePhotosToDisk()
        }
    }

    func saveText(_ text: String, for date: Date) {
        texts[date] = text
        queue.async { [weak self] in
            self?.saveTextsToDisk()
        }
    }

    func loadPhotos() {
        queue.async { [weak self] in
            self?.loadPhotosFromDisk()
        }
    }

    func loadTexts() {
        queue.async { [weak self] in
            self?.loadTextsFromDisk()
        }
    }

    private func getDocumentsDirectory() -> URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    }

    private func getPhotosDirectoryURL() -> URL {
        getDocumentsDirectory().appendingPathComponent(photosDirectoryName, isDirectory: true)
    }

    private func getTextsDirectoryURL() -> URL {
        getDocumentsDirectory().appendingPathComponent(textsDirectoryName, isDirectory: true)
    }

    private func createDirectoriesIfNeeded() {
        let photosDirectoryURL = getPhotosDirectoryURL()
        let textsDirectoryURL = getTextsDirectoryURL()

        do {
            try FileManager.default.createDirectory(at: photosDirectoryURL, withIntermediateDirectories: true, attributes: nil)
            try FileManager.default.createDirectory(at: textsDirectoryURL, withIntermediateDirectories: true, attributes: nil)
        } catch {
            print("Error creating directories: \(error.localizedDescription)")
        }
    }

    private func createFilesIfNeeded() {
        let photosURL = getPhotosDirectoryURL().appendingPathComponent("\(photosDirectoryName).\(fileExtension)")
        let textsURL = getTextsDirectoryURL().appendingPathComponent("\(textsDirectoryName).\(fileExtension)")

        if !FileManager.default.fileExists(atPath: photosURL.path) {
            // Create an empty JSON file for photos
            let emptyPhotosData = try? JSONEncoder().encode([Date: Data]())
            FileManager.default.createFile(atPath: photosURL.path, contents: emptyPhotosData, attributes: nil)
        }

        if !FileManager.default.fileExists(atPath: textsURL.path) {
            // Create an empty JSON file for texts
            let emptyTextsData = try? JSONEncoder().encode([Date: String]())
            FileManager.default.createFile(atPath: textsURL.path, contents: emptyTextsData, attributes: nil)
        }
    }

    private func savePhotosToDisk() {
        let photosURL = getPhotosDirectoryURL().appendingPathComponent("\(photosDirectoryName).\(fileExtension)")

        do {
            let data = try JSONEncoder().encode(photos.mapValues { $0.pngData() })
            try data.write(to: photosURL)
        } catch {
            print("Error saving photos to disk: \(error.localizedDescription)")
        }
    }

    private func saveTextsToDisk() {
        let textsURL = getTextsDirectoryURL().appendingPathComponent("\(textsDirectoryName).\(fileExtension)")

        do {
            let data = try JSONEncoder().encode(texts)
            try data.write(to: textsURL)
        } catch {
            print("Error saving texts to disk: \(error.localizedDescription)")
        }
    }

    private func loadPhotosFromDisk() {
        let photosURL = getPhotosDirectoryURL().appendingPathComponent("\(photosDirectoryName).\(fileExtension)")

        do {
            let data = try Data(contentsOf: photosURL)
            let decodedPhotos = try JSONDecoder().decode([Date: Data].self, from: data)
            DispatchQueue.main.async {
                self.photos = decodedPhotos.compactMapValues { UIImage(data: $0) }
            }
        } catch {
            print("Error loading photos from disk: \(error.localizedDescription)")
        }
    }

    private func loadTextsFromDisk() {
        let textsURL = getTextsDirectoryURL().appendingPathComponent("\(textsDirectoryName).\(fileExtension)")

        do {
            let data = try Data(contentsOf: textsURL)
            let decodedTexts = try JSONDecoder().decode([Date: String].self, from: data)
            DispatchQueue.main.async {
                self.texts = decodedTexts
            }
        } catch {
            print("Error loading texts from disk: \(error.localizedDescription)")
        }
    }
}
