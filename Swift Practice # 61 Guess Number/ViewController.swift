//
//  ViewController.swift
//  Swift Practice # 61 Guess Number
//
//  Created by Dogpa's MBAir M1 on 2021/8/16.
//

import UIKit

class ViewController: UIViewController {
    
    //輸入猜測數字
    @IBOutlet weak var inputGuessNumberTextField: UITextField!
    
    //提示label
    @IBOutlet weak var hintLabel: UILabel!
    
    //剩餘次數label
    @IBOutlet weak var chagnceLabel: UILabel!
    
    //定義不同的變數供後續改變
    var numberOfAnswer = 0  //正確數字
    var timesOfChance = 5   //剩餘次數
    var smallNumber = 0     //最小值
    var bigNumber = 100     //最大值
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        numberOfAnswer = Int.random(in: 1...100) //隨機取得亂數給正確答案
    }
    
    
    //回傳值的function
    func getNewRange() -> String{
        return"\(smallNumber) - \(bigNumber)" //回傳最小值與最大值的
    }
    
    //次數減1以及顯示提示語的改變的值
    func hintChange(){
        timesOfChance -= 1
        chagnceLabel.text = "還有   \(timesOfChance)   次機會"
    }
    
    //定義數字判斷的function，透過傳入的值去做判斷
    func confirmGuessNumber(input:Int) {
        if input > 100 {    //超過預設最大值
            hintLabel.text = "爆掉啦ＱＱ \(getNewRange())"
            hintChange()
            
        }else if input > numberOfAnswer {   //大於正確答案
            bigNumber = input - 1
            hintLabel.text = "有點太多 \(getNewRange())"
            hintLabel.textColor = .black
            hintChange()
        }else if input < numberOfAnswer { //小於正確答案
            smallNumber = input + 1
            hintLabel.text = "太少ＱＱ \(getNewRange())"
            hintLabel.textColor = .black
            hintChange()
        }else{  //正解答案
            hintLabel.text = "猜對啦！"
            hintLabel.textColor = .brown
            
        }
    }
    
    //猜數字按鈕執行所做的動作
    @IBAction func guessNumber(_ sender: UIButton) {
        inputGuessNumberTextField.resignFirstResponder()
        //沒有輸入
        if inputGuessNumberTextField.text == "" {
            hintLabel.text = "請猜一個數字"
            hintLabel.textColor = .red
        //輸入的不是數字
        }else if Int(inputGuessNumberTextField.text!) == nil {
            hintLabel.text = "請輸入數字"
            hintLabel.textColor = .black
        //剩餘次數大於0
        }else if timesOfChance > 0 {
            let number = Int(inputGuessNumberTextField.text!)!
            confirmGuessNumber(input: number)
            //若是猜測次數用完
            if timesOfChance == 0{
                hintLabel.text = "可惜答案是\(numberOfAnswer)"
                hintLabel.textColor = .white
            }
        }else{
            hintLabel.text = "可惜答案是\(numberOfAnswer)"
        }
        


    }
    
    
    //重玩重設所有內容
    @IBAction func Replay(_ sender: UIButton) {
        hintLabel.text = "猜看看吧!"

        numberOfAnswer = Int(arc4random_uniform(100))
        
        smallNumber = 0
        bigNumber = 100
        timesOfChance = 5
        inputGuessNumberTextField.text = "0"
        chagnceLabel.text = String(timesOfChance)
        chagnceLabel.text = "還有   5   次機會"
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        inputGuessNumberTextField.resignFirstResponder()
        return true
    }
    //輸入後收鍵盤
    @IBAction func closeKeyboard(_ sender: UITextField) {
    }
    
}

