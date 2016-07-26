//
//  CKAsset.swift
//  Morse Chat
//
//  Created by Mason Earl on 7/18/16.
//  Copyright © 2016 trianglez. All rights reserved.
//

import Foundation
import UIKit
import CloudKit

enum ImageFileType {
    case JPG(compressionQuality: CGFloat)
    case PNG
    
    var fileExtension: String {
        switch self {
        case .JPG(_):
            return ".jpg"
        case .PNG:
            return ".png"
        }
    }
}

enum ImageError: ErrorType {
    case UnableToConvertImageToData
}

extension CKAsset {
    convenience init(image: UIImage, fileType: ImageFileType = .JPG(compressionQuality: 70)) throws {
        let url = try image.saveToTempLocationWithFileType(fileType)
        self.init(fileURL: url)
    }
    
    var image: UIImage? {
        guard let data = NSData(contentsOfURL: fileURL), image = UIImage(data: data) else { return nil }
        return image
    }
}

extension UIImage {
    func saveToTempLocationWithFileType(fileType: ImageFileType) throws -> NSURL {
        let imageData: NSData?
        
        switch fileType {
        case .JPG(let quality):
            imageData = UIImageJPEGRepresentation(self, quality)
        case .PNG:
            imageData = UIImagePNGRepresentation(self)
        }
        guard let data = imageData else {
            throw ImageError.UnableToConvertImageToData
        }
        
        let filename = NSProcessInfo.processInfo().globallyUniqueString + fileType.fileExtension
        let url = NSURL.fileURLWithPath(NSTemporaryDirectory()).URLByAppendingPathComponent(filename)
        try data.writeToURL(url, options: .AtomicWrite)
        
        return url
    }
}
