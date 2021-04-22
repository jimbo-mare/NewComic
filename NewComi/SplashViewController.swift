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
        self.view.backgroundColor = UIColor.cyan
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
