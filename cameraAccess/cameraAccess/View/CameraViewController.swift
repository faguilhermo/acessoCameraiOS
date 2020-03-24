//
//  CameraViewController.swift
//  cameraAccess
//
//  Created by Fabrício Guilhermo on 24/03/20.
//  Copyright © 2020 Fabrício Guilhermo. All rights reserved.
//

import UIKit

public final class CameraViewController: UIViewController {

    let imagePicker = ImagePicker()

    private lazy var addPhotoButton: UIButton = {
        let addPhotoButton = UIButton.init(type: .roundedRect)
        addPhotoButton.frame.size.height = 200
        addPhotoButton.frame.size.width = 200
        addPhotoButton.backgroundColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
        addPhotoButton.layer.cornerRadius = addPhotoButton.frame.size.width/2
        addPhotoButton.setTitle("+", for: .normal)
        addPhotoButton.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
        addPhotoButton.titleLabel?.font = UIFont.systemFont(ofSize: 50)
        addPhotoButton.addTarget(self, action: #selector(buttonAction(_ :)), for: .touchUpInside)

        return addPhotoButton
    }()

    private lazy var image: UIImageView = {
        let image = UIImageView()
        image.frame.size.height = 200
        image.frame.size.width = 200
        image.layer.cornerRadius = image.frame.size.width/2
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill

        return image
    }()


    override public func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.5568627715, green: 0.5465146013, blue: 0.9686274529, alpha: 1)
        initUI()
        setup()
    }

    private func initUI() {
        view.addSubview(image)
        image.center = self.view.center
        view.addSubview(addPhotoButton)
        addPhotoButton.center = self.view.center
    }

    private func showMultimedia(_ option: Options) {
        let multimedia = UIImagePickerController()
        multimedia.delegate = imagePicker
        if UIImagePickerController.isSourceTypeAvailable(.camera) && option == .camera {
            multimedia.sourceType = .camera
        } else {
            multimedia.sourceType = .photoLibrary
        }
        self.present(multimedia, animated: true, completion: nil)
    }

    @objc private func buttonAction(_ : UIButton) {
        let menu = ImagePicker().optionsMenu { (option) in
            self.showMultimedia(option)
        }
        present(menu, animated: true, completion: nil)
    }
}

extension CameraViewController: ImagePickerSelectedImage {
    internal func imagePickerSelectedImage(_ photo: UIImage) {
        image.image = photo
        addPhotoButton.isHidden = true
    }

    private func setup() {
        imagePicker.delegate = self
    }
}
