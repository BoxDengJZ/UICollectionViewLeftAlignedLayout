
//
//  ViewController.swift
//  musicSheet
//
//  Created by Jz D on 2019/8/25.
//  Copyright © 2019 上海莫小臣有限公司. All rights reserved.
//

import UIKit



extension UIViewController{
    
    

    func config(_ name: String, imageName image: String, selectedImageName selectedImage: String){
        tabBarItem.title = name
        tabBarItem.image = UIImage(named: image)
        tabBarItem.selectedImage = UIImage(named: selectedImage)
        
    }
   
}




extension UIViewController{
    func configOne(){
        view.backgroundColor = UIColor.white
        fd_prefersNavigationBarHidden = true
    }
}
