//
//  NetworkingService.swift
//  CollectionView
//
//  Created by Amankeldi Zhetkergen on 09.10.2024.
//

import UIKit

struct APIResponse: Codable {
    let urls: photoURLs
    let description: String?
}
struct photoURLs: Codable {
    let regular: String
}

class randomPhotoManager {
    var photos: [UIImage] = []
    var namings: [String] = []
    
    let unsplashUrl = "https://api.unsplash.com/photos/random?count=3&client_id=VrJ3q28MCgH3cCsbrlBFPavv4lDt8WNm5rxrZfcAHU0"
    
    
    func fetchPhotos(completion: @escaping ([UIImage], [String]) -> Void) {
        guard let url =  URL(string: unsplashUrl) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else { return }
            
            do {
                let photos = try JSONDecoder().decode([APIResponse].self, from: data)
                let dispatchGroup = DispatchGroup()
                
                for photo in photos {
                    dispatchGroup.enter()
                    self.downloadImage(photoURL: photo) { image in
                        if let image = image {
                            self.photos.append(image)
                            self.namings.append(photo.description ?? "NO info")
                        }
                        dispatchGroup.leave()
                    }
                }
                dispatchGroup.notify(queue: .main) {
                    completion(self.photos, self.namings)
                }
                
            } catch {
                return print(error)
            }
        }
        
        task.resume()
    }
    
    func downloadImage(photoURL: APIResponse, completion: @escaping (UIImage?) -> Void){
        guard let url = URL(string: photoURL.urls.regular) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                completion(nil)
                return
            }
            let image = UIImage(data: data)
            completion(image)
        }
        task.resume()
    }
    
}
