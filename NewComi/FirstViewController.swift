import UIKit

class FirstViewController: UIViewController, UIPickerViewDelegate, UICollectionViewDelegateFlowLayout, UIPickerViewDataSource, UITextFieldDelegate {
    
    @IBOutlet weak var appLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var publiLabel: UILabel!
    @IBOutlet weak var publiPickerView: UIPickerView!
    @IBOutlet weak var Btn: UIButton!
    
    let dataList = [
            "集英社","講談社","小学館","KADOKAWA",
            "スクウェア・エニックス","白泉社","角川書店","秋田書店",
            "メディアファクトリー","少年画報社","竹書房"
    ]
    
    //pickerの列数
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    //pickerのリストの数
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return dataList.count
    }
    
    //pickerの最初の表示
    func pickerView(_ pickerView: UIPickerView,
                        titleForRow row: Int,
                        forComponent component: Int) -> String? {
        return dataList[row]
    }
    
    //UserDefaultsのインスタンス
    let userDefaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameTextField.delegate = self
        // picker Delegate設定
        publiPickerView.delegate = self
        publiPickerView.dataSource = self
        
        // 背景色を空色に変更する
        self.view.backgroundColor = UIColor.cyan
    }
    
    
    //初期値
    var testText:String = "default"
    
    //picker
    var fav:String = ""
    
    //次回以降表示しないための
    var nextSkip:Bool = false
    
    //pickerの値の取得
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        fav = dataList[row]
    }
    
    @IBAction func BtnAction(_ sender: Any) {
        //テキストフィールドの処理
        testText = nameTextField.text!
        nameTextField.text = testText
        //(保存したいデータ)を引数として以下の関数へ
        userDefaults.set(nameTextField.text, forKey: "NameString")
        //pickerの処理
        userDefaults.set(fav, forKey: "FavString")
        
        //次回以降表示しない
        nextSkip = true
        userDefaults.set(nextSkip, forKey: "Boolean")
    }
}
