//
//  ViewController.swift
//  SlideshowApp
//
//  Created by 岩田知也 on 2016/12/23.
//  Copyright © 2016年 tomoya.iwata. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var imageArray = ["1.jpg","2.jpg","3.jpg","4.jpg","5.jpg","6.jpg","7.jpg","8.jpg","9.jpg","10.jpg","11.jpg"]
    
    var counter = 0
    var timer: Timer!
    //タイマーを宣言、タイマーは最初はnilが代入されている
    
    @IBAction func next(_ sender: Any) {
        counter = counter + 1
        if ( counter > 10 ) {
            counter = 0
            ImageView.image = UIImage(named: imageArray[counter])
        }else{
            ImageView.image = UIImage(named: imageArray[counter])
        }
    }
    
    @IBAction func back(_ sender: Any) {
        counter = counter - 1
        if(counter < 0){
            counter = 10
            ImageView.image = UIImage(named: imageArray[counter])
        }else{
            ImageView.image = UIImage(named: imageArray[counter])
        }
    }
    
    @IBAction func startstop(_ sender: Any) {
    //再生/停止ボタンを押すとクロックスタート
        if ( timer == nil ) {
            timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(update), userInfo: nil, repeats: true)
            timer.fire()
            //2秒毎にupdateを実行
            Forward.isEnabled = false
            Return.isEnabled = false
            //戻る・進むボタンを無効化
            PlayStop.setTitle("停止", for: .normal)
        }
        else {
            //クロックがnillで無い場合、つまりスライドショー中に停止が押されたことを意味する、なので進むと戻るをアクティブにして再生ボタンに戻す。その上で、timerをnilに戻す。
            Forward.isEnabled = true
            Return.isEnabled = true
            PlayStop.setTitle("再生", for: .normal)
            timer.invalidate()
            timer = nil
        }
    }

    
    @IBOutlet weak var Forward: UIButton!
    
    @IBOutlet weak var Return: UIButton!
    
    @IBOutlet weak var PlayStop: UIButton!
    
    @IBOutlet weak var ImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        ImageView.image = UIImage(named: imageArray[0])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        // segueから遷移先のResultViewControllerを取得する
        let resultViewController:ResultViewController = segue.destination as! ResultViewController
        // 遷移先のResultViewControllerで宣言しているxに画像名を代入して渡す
        resultViewController.x = imageArray[counter]
        if(timer == nil){
        }
        else{
        Forward.isEnabled = true
        Return.isEnabled = true
        PlayStop.setTitle("再生", for: .normal)
        timer.invalidate()
        timer = nil
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func update() {
        counter = counter + 1
        if ( counter == imageArray.count ) {
            counter = 0
        }
        ImageView.image = UIImage(named: imageArray[counter])
    }
    
    @IBAction func unwind(segue: UIStoryboardSegue){
        //他の画面からsegueを使って戻ってきた時に呼ばれる
    }


}

