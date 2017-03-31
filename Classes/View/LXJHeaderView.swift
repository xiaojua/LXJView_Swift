//
//  LXJHeaderView.swift
//  LXJView_Swift
//
//  Created by xiaojuan on 17/3/29.
//  Copyright © 2017年 xiaojuan. All rights reserved.
//

import UIKit

class LXJHeaderView: UIView , UIImagePickerControllerDelegate, UINavigationControllerDelegate{

    var basicVc : UIViewController!
    
    var imageView : UIImageView!
    
    var bgView : UIView!
    
    var showImageView : UIImageView!
    
    var picker : UIImagePickerController!
    
    
    
    
    //重写init方法
    override init(frame: CGRect){
        super.init(frame: frame)
        
        
        picker = UIImagePickerController.init()
        picker.delegate = self
        
        self.layer.borderColor = UIColor.gray.cgColor
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 20
        self.layer.masksToBounds = true
        self.backgroundColor = UIColor.white
        
        imageView = UIImageView()
        imageView.frame = CGRect(x:0, y:0, width:Int(self.frame.size.width), height:Int(self.frame.size.height))
        imageView.backgroundColor = UIColor.white
        imageView.image = self.returnCurrentImage()
        imageView.contentMode = UIViewContentMode.scaleToFill
        self.addSubview(imageView)
        
        imageView.isUserInteractionEnabled = true
        let tapGr = UITapGestureRecognizer.init(target: self, action: #selector(tapGrShowImage))
        tapGr.numberOfTouchesRequired = 1
        imageView.addGestureRecognizer(tapGr)
        
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func tapGrShowImage() -> Void {
        self.basicVc.navigationController?.isNavigationBarHidden = true
        bgView = UIView.init(frame: CGRect(x:0, y:0, width:SCREEN_W, height:SCREEN_H))
        bgView.backgroundColor = UIColor.white
        basicVc.view.addSubview(bgView)
        
        showImageView = UIImageView.init(frame: bgView.frame)
        showImageView.backgroundColor = UIColor.white
        showImageView.contentMode = UIViewContentMode.scaleAspectFit
        showImageView.image = self.returnCurrentImage()
        bgView.addSubview(showImageView)
        
        showImageView.isUserInteractionEnabled = true
        let tapGrHide = UITapGestureRecognizer.init(target: self, action: #selector(tapGrHideImage))
        tapGrHide.numberOfTouchesRequired = 1
        showImageView.addGestureRecognizer(tapGrHide)
        
        let longPres = UILongPressGestureRecognizer.init(target: self, action: #selector(longPressGr))
        showImageView.addGestureRecognizer(longPres)
        
        
    }
    
    func tapGrHideImage() -> Void {
        self.basicVc.navigationController?.isNavigationBarHidden = false
        bgView.removeFromSuperview()
    }
    
    func longPressGr() -> Void {
        let alert = UIAlertController.init(title: nil, message: nil, preferredStyle: UIAlertControllerStyle.actionSheet)
        weak var weakSelf = self
        let camera = UIAlertAction.init(title: "camera", style: UIAlertActionStyle.default) { (UIAlertAction) in
            weakSelf?.picker.sourceType = UIImagePickerControllerSourceType.camera
            weakSelf?.basicVc.present((weakSelf?.picker)!, animated: true, completion: nil)
        }
        let photo = UIAlertAction.init(title: "photo", style: UIAlertActionStyle.default) { (UIAlertAction) in
            weakSelf?.picker.sourceType = UIImagePickerControllerSourceType.photoLibrary
            weakSelf?.basicVc.present((weakSelf?.picker)!, animated: true, completion: nil)
        }
        let save = UIAlertAction.init(title: "save", style: UIAlertActionStyle.default) { (UIAlertAction) in
            self.savePhotoToPhotoLibrary()
        }
        let cancel = UIAlertAction.init(title: "", style: UIAlertActionStyle.cancel, handler: nil)
        
        alert.addAction(camera)
        alert.addAction(photo)
        alert.addAction(save)
        alert.addAction(cancel)
        
        basicVc.present(alert, animated: true, completion: nil)
    }
    
    func returnCurrentImage() -> UIImage {
        //获取documents路径
        let documentStr = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).first
        let filePath = documentStr! + kFilePath
        var img = UIImage(contentsOfFile: filePath)
        if (img == nil) {
            img = UIImage(named: "aa")
        }
        return img!
        
        
    }
    
    func savePhotoToPhotoLibrary() -> Void {
        UIImageWriteToSavedPhotosAlbum(self.returnCurrentImage(), self, #selector(savePhotoFinish(_:)), nil)
    }
    
    func savePhotoFinish(_ error: NSError) -> Void {
        if error == nil {
            print("保存成功")
        }else{
            print("保存失败")
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        let img = info["UIImagePickerControllerOriginalImage"] as! UIImage?
        
        self.imageView.image = img
        
        //save to document
        
        self.picker.dismiss(animated: true, completion: nil)
        self.tapGrHideImage()
        
    }
    
    func saveImageToDocuments(_ img: UIImage) -> Void {
        /*
        let document = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).first
        let filePath = document! + kFilePath
        let imgData = UIImagePNGRepresentation(img)
        */
        
        
        
        
    }
    

}
