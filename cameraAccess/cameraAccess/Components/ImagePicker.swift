//
//  ImagePicker.swift
//  cameraAccess
//
//  Created by Fabrício Guilhermo on 24/03/20.
//  Copyright © 2020 Fabrício Guilhermo. All rights reserved.
//

import UIKit

protocol ImagePickerSelectedImage {
    func imagePickerSelectedImage(_ photo: UIImage)
}

class ImagePicker: NSObject, UIImagePickerControllerDelegate {

    // MARK: - Atributos

    var delegate:ImagePickerSelectedImage?

    // MARK: - Métodos

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let photo = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        delegate?.imagePickerSelectedImage(photo)
        picker.dismiss(animated: true, completion: nil)
    }
}

extension ImagePicker: UINavigationControllerDelegate {
    
}
