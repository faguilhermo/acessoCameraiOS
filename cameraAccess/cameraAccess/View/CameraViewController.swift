//
//  CameraViewController.swift
//  cameraAccess
//
//  Created by Fabrício Guilhermo on 24/03/20.
//  Copyright © 2020 Fabrício Guilhermo. All rights reserved.
//

import UIKit

public final class CameraViewController: UIViewController {

    // MARK: - Constants
    let imagePicker = ImagePicker()

    // MARK: - User interface elements
    /// Creates a button to add photos in an UIImageView in the CameraViewController
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

    /// Creates a Image View to receive photos
    private lazy var image: UIImageView = {
        let image = UIImageView()
        image.frame.size.height = 200
        image.frame.size.width = 200
        image.layer.cornerRadius = image.frame.size.width/2
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill

        return image
    }()

    // MARK: - Application lifecycle
    override public func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.5568627715, green: 0.5465146013, blue: 0.9686274529, alpha: 1)
        initUI()
        setup()
    }

    // MARK: - Functions
    /// Add the UI elements on the view.
    private func initUI() {
        view.addSubview(image)
        image.center = self.view.center
        view.addSubview(addPhotoButton)
        addPhotoButton.center = self.view.center
    }

    /// Add options to the button and a  delegate to the ImagePickerController
    /// - Parameter option: Options to add image on the Image View, if option is .camera this function will verify if the camera is available, if true, will access it. Otherwise, if the option is .library this function will access the iOS photo library.
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

    // MARK: - Button action
    /// addPhotoButton action, show the action sheet to choose between .camera and .library.
    /// - Parameter _: the button itself
    @objc private func buttonAction(_ : UIButton) {
        let menu = ImagePicker().optionsMenu { (option) in
            self.showMultimedia(option)
        }
        // show menu
        present(menu, animated: true, completion: nil)
    }
}

extension CameraViewController: ImagePickerSelectedImage {
    internal func imagePickerSelectedImage(_ photo: UIImage) {
        image.image = photo
        addPhotoButton.isHidden = true
    }

    /// Setup the image picker delegate.
    private func setup() {
        imagePicker.delegate = self
    }
}
