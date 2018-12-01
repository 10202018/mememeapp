//
//  Meme.swift
//  MemeMe
//
//  Created by TJ on 11/28/18.
//  Copyright © 2018 TJ. All rights reserved.
//

import UIKit

struct Meme {
    var topText: String?
    var bottomText: String?
    var originalImage: UIImage?
    var memedImage: UIImage?
    
    init (topText: UITextField, bottomText: UITextField, image: UIImage?, memedImage: UIImage?) {
        if let topText = topText.text, let bottomText = bottomText.text, let image = image {
            self.topText = topText
            self.bottomText = bottomText
            self.originalImage = image
            self.memedImage = UIImage()
        } else {
            self.topText = ""
            self.bottomText = ""
            self.originalImage = UIImage()
            self.memedImage = UIImage()
        }
    }
  
    
}
