//
//  ImagePicker.swift
//  cameraAccess
//
//  Created by Fabrício Guilhermo on 24/03/20.
//  Copyright © 2020 Fabrício Guilhermo. All rights reserved.
//

import UIKit

// MARK: - Enums
enum Options {
    case camera
    case library
}

// MARK: - Protocols
protocol ImagePickerSelectedImage {
    func imagePickerSelectedImage(_ photo: UIImage)
}

// MARK: - Class
class ImagePicker: NSObject, UIImagePickerControllerDelegate {

    // MARK: - Variables
    var delegate:ImagePickerSelectedImage?

    // MARK: - Functions
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let photo = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        delegate?.imagePickerSelectedImage(photo)
        picker.dismiss(animated: true, completion: nil)
    }

    /// Creates an action sheet to choos camera, library access or cancel action.
    /// - Parameter completion: options
    /// - Parameter options: escaping with the choosen option
    func optionsMenu(completion: @escaping(_ options: Options) -> Void) -> UIAlertController {
        let menu = UIAlertController(title: "Add new image", message: "Please choose one option below.", preferredStyle: .actionSheet)

        let camera = UIAlertAction(title: "Take picture", style: .default) { (camera) in
            completion(.camera)
        }

        menu.addAction(camera)
        let library = UIAlertAction(title: "Library", style: .default) { (library) in
            completion(.library)
        }
        menu.addAction(library)

        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        menu.addAction(cancel)

        return menu
    }
}

// MARK: - Extensions
extension ImagePicker: UINavigationControllerDelegate {
    
}
