//
//  ViewController.swift
//  HitGame
//
//  Created by Len Chan on 19/1/2017.
//  Copyright © 2017 Len Chan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var btn1: UIButton!
    @IBOutlet weak var btn2: UIButton!
    @IBOutlet weak var btn3: UIButton!
    @IBOutlet weak var btn4: UIButton!
    @IBOutlet weak var btn5: UIButton!
    @IBOutlet weak var btn6: UIButton!
    @IBOutlet weak var btn7: UIButton!
    @IBOutlet weak var btn8: UIButton!
    @IBOutlet weak var btn9: UIButton!
    @IBOutlet weak var lblTimer: UILabel!
    @IBOutlet weak var lblScore: UILabel!
    @IBOutlet weak var btnChange: UIButton!
    var url = "https://lenchan139.org/myWorks/iOS_project/btn_bg1.png"
    var urlCount = 1
    
    var timer = Timer()
    var counter = 0;
    var score: Int = 0{
        didSet{
            lblScore.text = String(Int(score))
        }
    };
    func changeBtnBg(sender: UIButton, url: String){
        if let checkedUrl = URL(string: url) {
            sender.imageView?.contentMode = .scaleAspectFit
            downloadImage(url: checkedUrl, sender: sender)
        }
    }
    @IBAction func changeBtnClick(_ sender: UIButton) {
        changeUrl()
        changeBg(sender: sender)
        score=score-1
    }
    func changeUrl(){
        urlCount=urlCount+1
        if(urlCount==2){
            url = "https://lenchan139.org/myWorks/iOS_project/btn_bg2.png"
        }else if(urlCount==3){
            url = "https://lenchan139.org/myWorks/iOS_project/btn_bg3.png"
        }else{
            urlCount=1
            url = "https://lenchan139.org/myWorks/iOS_project/btn_bg1.png"
        }
    }
    func changeAllBg(url: String){
        changeBtnBg(sender: btn1, url: url)
        changeBtnBg(sender: btn2, url: url)
        changeBtnBg(sender: btn3, url: url)
        changeBtnBg(sender: btn4, url: url)
        changeBtnBg(sender: btn5, url: url)
        changeBtnBg(sender: btn6, url: url)
        changeBtnBg(sender: btn7, url: url)
        changeBtnBg(sender: btn8, url: url)
        changeBtnBg(sender: btn9, url: url)
        
    }
    override func viewDidLoad() {
        // Use for the app's interface
        //changeAllBg(url: self.url)
        changeBg(sender: btnChange)
        
    }
    
    @IBAction func btnReset(_ sender: UIButton) {
        counter=50;
        timer.invalidate()
        scheduledTimerWithTimeInterval()
    }
    
    func scheduledTimerWithTimeInterval(){
        // Scheduling timer to Call the function **Countdown** with the interval of 1 seconds
        timer = Timer.scheduledTimer(timeInterval: 1/3, target: self, selector: #selector(self.updateCounting), userInfo: nil, repeats: true)
    }
    
    func clearAllBtn(){
        btn1.setImage(nil, for: .normal)
        btn2.setImage(nil, for: .normal)
        btn3.setImage(nil, for: .normal)
        btn4.setImage(nil, for: .normal)
        btn5.setImage(nil, for: .normal)
        btn6.setImage(nil, for: .normal)
        btn7.setImage(nil, for: .normal)
        btn8.setImage(nil, for: .normal)
        btn9.setImage(nil, for: .normal)
    }
    func changeBg(sender: UIButton){
        changeBtnBg(sender: sender, url: self.url)
    }

    func updateCounting(){
        if counter > 0{
        clearAllBtn()
        counter=counter-1
        lblTimer.text = String(counter)
        let ranNum =  Int(arc4random_uniform(13))+1
        if ranNum == 1{
            changeBg(sender: btn1)
        }else if ranNum == 2{
            changeBg(sender: btn2)
        }else if ranNum == 3{
            changeBg(sender: btn3)
        }else if ranNum == 4{
            changeBg(sender: btn4)
        }else if ranNum == 5{
            changeBg(sender: btn5)
        }else if ranNum == 6{
            changeBg(sender: btn6)
        }else if ranNum == 7{
            changeBg(sender: btn7)
        }else if ranNum == 8{
            changeBg(sender: btn8)
        }else if ranNum == 9{
            changeBg(sender: btn9)
        }else if ranNum == 10{
            changeBg(sender: btn5)
            changeBg(sender: btn9)
            }
        else if ranNum == 11{
            changeBg(sender: btn7)
            changeBg(sender: btn2)
        }else if ranNum == 12{
            changeBg(sender: btn6)
            changeBg(sender: btn1)
        }else if ranNum == 13{
            changeBg(sender: btn2)
            changeBg(sender: btn4)
            changeBg(sender: btn6)
            changeBg(sender: btn8)
            }
        }else {
            timer.invalidate()
            clearAllBtn()
            // create the alert
            let alert = UIAlertController(title: String ("You got " + String(score))  + " Scores!" , message: " Enter your name and send to score board: ", preferredStyle: UIAlertControllerStyle.alert)
            
            // add the actions (buttons)
            alert.addTextField { (textField) in
                textField.text = ""
            }
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
                let textField = alert?.textFields![0] // Force unwrapping because we know it exists.
                self.submitScore(name: (textField?.text!)!, sScore: self.score)
            }))
        
            alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil))
            
            // show the alert
            self.present(alert, animated: true, completion: nil)
        }
        
        
    }
    
    func submitScore(name: String , sScore : Int){
        
        if(name != "" && sScore>0){
            var finalMsg : String = "ERROR: Empty Content!"
            let name1 = name.removingPercentEncoding
            let name2 = name1?.replacingOccurrences(of: " ", with: "_")
            let str1 = "https://lenchan139.org/myWorks/iOS_project/submit_score.php?name="
            let str2 = "&score="
            let urlStr = str1 + name2! + str2 + String(sScore);
            let myURLString = urlStr;
        guard let myURL = URL(string: myURLString) else {
            print("Error: \(myURLString) doesn't seem to be a valid URL")
            return
        }
        
        do {
            let myHTMLString = try String(contentsOf: myURL, encoding: .ascii)
            finalMsg = " \(myHTMLString)"
        } catch let error {
            finalMsg = "Error: \(error)"
        }
         
            
            // create the alert
            let alert = UIAlertController(title: finalMsg, message: "", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK!", style: UIAlertActionStyle.cancel, handler: nil))
            // show the alert
            self.present(alert, animated: true, completion: nil)
        }else{
            
            // create the alert
            let alert = UIAlertController(title: "Please Enter name or assume you are not zero score", message: "", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK!", style: UIAlertActionStyle.cancel, handler: nil))
            // show the alert
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func btn1Click(_ sender: UIButton) {
        checked(inBtn: sender)
    }
    
    @IBAction func btn2Click(_ sender: UIButton) {
        checked(inBtn: sender)
    }
    
    @IBAction func btn3Click(_ sender: UIButton) {
        checked(inBtn: sender)
    }
    
    @IBAction func btn4Click(_ sender: UIButton) {
        checked(inBtn: sender)
    }
    
    @IBAction func btn5Click(_ sender: UIButton) {
        checked(inBtn: sender)
    }
    
    @IBAction func btn6Click(_ sender: UIButton) {
        checked(inBtn: sender)
    }
    
    @IBAction func btn7Click(_ sender: UIButton) {
        checked(inBtn: sender)
    }
    
    @IBAction func btn8Click(_ sender: UIButton) {
        checked(inBtn: sender)
    }
    
    @IBAction func btn9Click(_ sender: UIButton) {
        checked(inBtn: sender)
    }
    
    func checked(inBtn:UIButton){
        if inBtn.image(for: .normal) != nil{
        inBtn.setImage(nil, for: .normal)
            score = score + 1;
                  }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func downloadImage(url: URL, sender: UIButton) {
        print("Download Started")
        getDataFromUrl(url: url) { (data, response, error)  in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            print("Download Finished")
            DispatchQueue.main.async() { () -> Void in
                sender.setImage( UIImage(data: data), for: .normal)
            }
        }
    }
    func getDataFromUrl(url: URL, completion: @escaping (_ data: Data?, _  response: URLResponse?, _ error: Error?) -> Void) {
        URLSession.shared.dataTask(with: url) {
            (data, response, error) in
            completion(data, response, error)
            }.resume()
    }
}

