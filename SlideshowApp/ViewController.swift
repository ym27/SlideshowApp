//
//  ViewController.swift
//  SlideshowApp
//
//  Created by Yuji Mochizuki on 2022/04/14.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var show_image: UIImageView!
    
    @IBAction func forward(_ sender: Any) {
        if flg_play == 0 {
            self.image_id += 1
            change_image()
        }
    }
    
    @IBAction func back(_ sender: Any) {
        if flg_play == 0 {
            self.image_id -= 1
            change_image()
        }
    }
    
    @IBAction func play_stop(_ sender: Any) {
        // 停止→再生
        if flg_play == 0 {
            // タイマー設定
            if self.timer == nil{
                self.timer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(autoplay(_:)), userInfo: nil, repeats: true)
            }
            flg_play = 1
        // 再生→停止
        } else if flg_play == 1 {
            // タイマー停止
            self.timer.invalidate()
            self.timer = nil
            flg_play = 0
        }
        
    }
    
    @IBAction func show_image_zoom(_ sender: Any) {
        // zoom中は自動再生を停止
        if flg_play == 1 {
            self.timer.invalidate()
            self.timer = nil
            flg_play = 0
        }
    }
    
    @IBAction func unwind(_ segue: UIStoryboardSegue) {
    }
    
    // 初期設定（画像ID）
    var image_id = 0
    // 初期設定（再生フラグ）
    var flg_play = 0
    // 初期設定（画像リスト）
    let list_images = [
        "IMGP1233.JPG",
        "IMGP1251.JPG",
        "IMGP1269.JPG",
        "IMGP1303.JPG"
    ]
    // タイマー
    var timer: Timer!

    // 表示する画像を変更するためのメソッド
    func change_image() {
        if self.image_id < 0 {
            self.image_id = self.list_images.count  - 1
        } else if self.image_id > self.list_images.count - 1 {
            self.image_id = 0
        }
        
        let image = UIImage(named: self.list_images[self.image_id])
        show_image.image = image
    }
    
    @objc func autoplay(_ timer: Timer) {
        self.image_id += 1
        change_image()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // 画像表示（list_imagesの先頭画像が表示）
        let image = UIImage(named: self.list_images[0])
        show_image.image = image
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let resultViewController:ResultViewController = segue.destination as! ResultViewController
        resultViewController.image = UIImage(named: self.list_images[self.image_id])
    }
    

}

