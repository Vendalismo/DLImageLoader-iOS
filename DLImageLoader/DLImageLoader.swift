//
//  DLILManager.swift
//
//  Created by Andrey Lunevich
//  Copyright © 2015 Andrey Lunevich. All rights reserved.

//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at

//  http://www.apache.org/licenses/LICENSE-2.0

//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.

import UIKit

public typealias DLILCompletion = (_ result: Result<UIImage, DLImageLoader.Error>) -> Void

public final class DLImageLoader {

    public enum Error: Swift.Error {
        case invalidUrl
        case loadingFailed(Swift.Error)
        case corruptedImage
    }

    public var enableLog = false

    /**
     Instance method
     - returns: DLImageLoader instance.
     */
    public static let shared = DLImageLoader()

    private let session: URLSession
    private var cache: DLILCacheManager?

    private init() {
        session = URLSession(configuration: URLSessionConfiguration.default,
                             delegate: nil,
                             delegateQueue: OperationQueue.main)

        do {
            setupCache(try DLILCacheManager())
        } catch {
            log(message: error.localizedDescription)
        }
    }

    @discardableResult
    public func setupCache(_ cache: DLILCacheManager) -> Self {
        self.cache?.clear()

        self.cache = cache

        return self
    }

    /**
     Load image from url
     - parameter url: The url of image.
     - parameter into: UIImageView in which will display image.
     - parameter completion: Completion block that will be called after image loading.
     */
    @discardableResult
    public func load(_ url: URL?,
                     placeholder: UIImage? = nil,
                     into imageView: UIImageView,
                     completion: DLILCompletion? = nil) -> URLSessionDataTask? {
        imageView.image = placeholder

        guard let url = url else {
            completion?(.failure(.invalidUrl))

            return nil
        }

        return load(URLRequest(url: url), into: imageView, completion: completion)
    }

    /**
     Load image from request
     - parameter request: The request of image.
     - parameter into: UIImageView in which will display image.
     - parameter completion: Completion block that will be called after image loading.
     */
    @discardableResult
    public func load(_ request: URLRequest,
                     placeholder: UIImage? = nil,
                     into imageView: UIImageView,
                     completion: DLILCompletion? = nil) -> URLSessionDataTask? {
        imageView.image = placeholder

        guard let url = request.url?.absoluteString, !url.isEmpty else {
            completion?(.failure(.invalidUrl))

            return nil
        }

        log(message: "loading image from url => \(url)")

        if let image = cache?.image(forKey: url) {
            log(message: "got an image from the cache")

            if let completion = completion {
                completion(.success(image))
            } else {
                imageView.image = image
                imageView.setNeedsDisplay()
            }

            return nil
        }

        let task = session.dataTask(with: request) { [weak self] (data, response, error) in
            if let error = error {
                completion?(.failure(.loadingFailed(error)))

                self?.log(message: "error image loading \(error)")
            } else {
                if let data = data, let image = UIImage(data: data) {
                    // save loaded image to cache
                    self?.cache?.saveImage(image, forKey: url)

                    if let completion = completion {
                        completion(.success(image))
                    } else {
                        imageView.image = image
                        imageView.setNeedsDisplay()
                    }

                    self?.log(message: "loaded image from url => \(url)")
                } else {
                    completion?(.failure(.corruptedImage))
                }
            }
        }

        task.resume()

        return task
    }

    /**
     Cancel task
     - parameter url: Url to stop a task
     */
    public func cancelOperation(url: String) {
        allTasks(of: session) { (tasks) in
            for task in tasks {
                if task.currentRequest?.url?.absoluteString == url {
                    task.cancel()
                }
            }
        }
    }

    /**
     Stop all active tasks
     */
    public func cancelAllOperations() {
        allTasks(of: session) { (tasks) in
            for task in tasks {
                task.cancel()
            }
        }
    }

    /**
     Clear cache of DLImageLoader
     */
    public func clearCache(_ completion: ((_ success: Bool) -> Void)? = nil) {
        cache?.clear(completion)
    }


    // MARK: - private methods

    private func allTasks(of session: URLSession, completionHandler: @escaping ([URLSessionTask]) -> Void) {
        session.getTasksWithCompletionHandler { (data, upload, download) in
            let tasks = data as [URLSessionTask] + upload as [URLSessionTask] + download as [URLSessionTask]

            completionHandler(tasks)
        }
    }

    private func log(message: String) {
        if enableLog {
            print("DLImageLoader: \(message)")
        }
    }
}
