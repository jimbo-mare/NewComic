import UIKit

class SplashViewController: UIViewController {
    
    @IBOutlet weak var SkipBtn: UIButton!
    
    @IBAction func BtnSkip(_ sender: UIButton) {
        
        check = UserDefaults.standard.bool(forKey: "Boolean")
        print(check)
        
        if check == true {
        let storyboard: UIStoryboard = self.storyboard!
        let main = storyboard.instantiateViewController(withIdentifier: "main")
        self.present(main, animated: true, completion: nil)
        } else {
            let storyboard: UIStoryboard = self.storyboard!
            let first = storyboard.instantiateViewController(withIdentifier: "first")
            self.present(first, animated: true, completion: nil)
        }
    }
    
    var check:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // ->背景色を空色に変更する
        let bgyellow = UIColor(red: 234/255, green: 194/255, blue: 85/255, alpha: 1)
        self.view.backgroundColor = bgyellow
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
