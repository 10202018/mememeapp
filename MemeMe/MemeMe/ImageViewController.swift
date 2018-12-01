//
//  ViewController.swift
//  MemeMe
//
//  Created by TJ on 11/28/18.
//  Copyright © 2018 TJ. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    
    // MARK: Properties
    
    var topTextFieldDelegate = TopTextFieldDelegate()
    var bottomTextFieldDelegate = BottomTextFieldDelegate()
    
    
    
    // MARK: Outlets
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var textFieldTop: UITextField!
    @IBOutlet weak var textFieldBottom: UITextField!
    
    
    // MARK: Actions

    // Choose Pic
    @IBAction func pickImage(_ sender: Any) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    // Take Pic
    @IBAction func takePicture(_ sender: Any) {
        let cameraController = UIImagePickerController()
        cameraController.delegate = self
        cameraController.sourceType = .camera
        present(cameraController, animated: true, completion: nil)
    }
    
    // Put Pic on Screen
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

        if let data = info[.originalImage] {
            imageView.image = data as? UIImage
            dismiss(animated: true, completion: nil)
        }
    }
    
    // Keyboard Adjustments
    /// (see KeyboardAdjustments.swift)
    
    
    // MARK: Meme'd Pic Actions
    
    // save Meme'd pic

    
    // Share the saved meme w/ the activityVC
    @IBAction func shareMeme(_ sender: Any) {
        // get the optional image from the meme
        let memedImage = generateMemedImage()
        
        // conditionally unwrap the optional image and add it to the activityVC
        if let image = memedImage {
            let activityVC = UIActivityViewController(activityItems: [image], applicationActivities: nil)
            
            // for iPad
            activityVC.popoverPresentationController?.sourceView = self.view
            
            // present the activityVC
            present(activityVC, animated: true)
            
            // save to Photos... Will not save without this
            activityVC.completionWithItemsHandler = {(activityType: UIActivity.ActivityType?, completed: Bool, returnedItems: [Any]?, error: Error?) in
                if completed {
                    // User completed activity
                    self.saveMeme()
                }
                // User cancelled
            }
        }
    }
    
    // Save the Meme
    func saveMeme() {
        let meme = Meme(topText: textFieldTop, bottomText: textFieldBottom, image: imageView.image, memedImage: generateMemedImage())
    }
    
    // Generate a meme'd image
    func generateMemedImage () -> UIImage? {
        // Render view to an image
        hideNavigationBar()
        hideToolBar()
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        showNavigationBar()
        showToolBar()
        return memedImage
    }
    
    // Associated actions (Nav Bar, Tool Bar)
    func hideNavigationBar () {
        self.navigationController?.navigationBar.isHidden = true
    }
    func showNavigationBar () {
        self.navigationController?.navigationBar.isHidden = false
        self.hideNavigationBar()
    }
    func hideToolBar() {
        self.navigationController?.toolbar.isHidden = true
    }
    func showToolBar() {
        self.navigationController?.toolbar.isHidden = false
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        
        view.addSubview(textFieldTop)
        view.addSubview(textFieldBottom)
        
        imageView.contentMode = .center
        imageView.clipsToBounds = true

        self.textFieldTop.delegate = self.topTextFieldDelegate
        self.textFieldBottom.delegate = self.bottomTextFieldDelegate
        
        
    }
}

