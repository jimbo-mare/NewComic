import UIKit
import SafariServices
import Lottie

class ViewController: UIViewController, SFSafariViewControllerDelegate, UITableViewDelegate, UITableViewDataSource {
    
    //var animationView = AnimationView()
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBAction func Switch(_ sender: UISwitch) {
        if sender.isOn {
            searchManga(publisherName: favorite)
        } else {
            searchAllManga()
        }
    }
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var userNameLabel: UILabel!
    
    //マンガのリスト
    var mangaList : [(title:String, publisherName:String, author: String, salesDate: String, itemUrl:URL, smallImageUrl:URL)] = []
    
    //favorite宣言
    var favorite:String = ""
    //all宣言
    var allcomics:String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //TableViewのdataSourceを設定
        tableView.dataSource = self
        //Table Viewのdelegateを設定
        tableView.delegate = self
        //表示
        favorite = UserDefaults.standard.string(forKey: "FavString") ?? ""
        searchManga(publisherName: favorite)
        
        //ユーザーネームの表示
        let value:String = UserDefaults.standard.string(forKey: "NameString")!
        userNameLabel.text = "Welcome!\(value)"
        
        // ->背景色を空色に変更する
        self.view.backgroundColor = UIColor.cyan
    }
        //邪魔だから停止(後々)
        //addAnimationView()
    
    
    //JSONのitem内のデータ構造
    struct ItemsJson: Codable {
        //作品名
        let title: String?
        //出版社
        let publisherName: String?
        //作者
        let author: String?
        //発売日
        let salesDate: String?
        //商品URL
        let itemUrl: URL?
        //商品画像
        let smallImageUrl: URL?
        
    }
    
    //JSONのデータ構造
    struct ResultJson: Codable {
        //複数要素
        let Items:[ItemsJson]?
    }
    
    //serchMangaメソッド
    func searchManga (publisherName : String?)  {
        
        //エンコード
        guard let publisherName_encode = (publisherName?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)) else {
            return
            
        }
        //URLの組み立て
        guard let req_url = URL (string: "https://app.rakuten.co.jp/services/api/BooksBook/Search/20170404?format=json&publisherName=\(String(describing: publisherName_encode))&booksGenreId=001001&availability=5&formatVersion=2&applicationId=1078393297425093197")else{
            return
            
        }
        
        //リクエストに必要な情報を生成
        let req = URLRequest(url: req_url)
        //データ転送を管理するためのセッションを生成
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        //
        let task = session.dataTask(with: req, completionHandler: {
            (data, response, error) in
            //セッションを終了
            session.finishTasksAndInvalidate()
            //do try catch エラーハンドリング
            do {
                //JSONDecodeerのインスタンス取得
                let decoder = JSONDecoder()
                //受け取ったJSONデータをパースして格納
                let json = try decoder.decode(ResultJson.self, from: data!)
                
                print(json)
                //マンガの情報が取得できているか確認
                if let items = json.Items {
                    //リストの初期化
                    self.mangaList.removeAll()
                    //取得できている数だけ処理
                    for item in items {
                        //アンラップ
                        if let title = item.title , let publisherName = item.publisherName ,let author = item.author , let saleData = item.salesDate , let itemUrl = item.itemUrl , let smallImageUrl = item.itemUrl {
                            //タプルに
                            let manga = (title,publisherName,author,saleData,itemUrl,smallImageUrl)
                            //配列へ追加
                            self.mangaList.append(manga)
                        }
                    }
                    
                    self.tableView.reloadData()
                }
            } catch {
                //エラー処理
                print("エラーが出ました")
            }
        })
        //ダウンロード開始
        task.resume()
    }
    
    
    //serchMangaメソッド
    func searchAllManga ()  {
        //URLの組み立て
        guard let req_url = URL (string: "https://app.rakuten.co.jp/services/api/BooksBook/Search/20170404?format=json&booksGenreId=001001&availability=5&formatVersion=2&applicationId=1078393297425093197")else{
            return
            
        }
        
        //リクエストに必要な情報を生成
        let req = URLRequest(url: req_url)
        //データ転送を管理するためのセッションを生成
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        //
        let task = session.dataTask(with: req, completionHandler: {
            (data, response, error) in
            //セッションを終了
            session.finishTasksAndInvalidate()
            //do try catch エラーハンドリング
            do {
                //JSONDecodeerのインスタンス取得
                let decoder = JSONDecoder()
                //受け取ったJSONデータをパースして格納
                let json = try decoder.decode(ResultJson.self, from: data!)
                
                print(json)
                //マンガの情報が取得できているか確認
                if let items = json.Items {
                    //リストの初期化
                    self.mangaList.removeAll()
                    //取得できている数だけ処理
                    for item in items {
                        //アンラップ
                        if let title = item.title , let publisherName = item.publisherName ,let author = item.author , let saleData = item.salesDate , let itemUrl = item.itemUrl , let smallImageUrl = item.itemUrl {
                            //タプルに
                            let manga = (title,publisherName,author,saleData,itemUrl,smallImageUrl)
                            //配列へ追加
                            self.mangaList.append(manga)
                        }
                    }
                    
                    self.tableView.reloadData()
                }
            } catch {
                //エラー処理
                print("エラーが出ました")
            }
        })
        //ダウンロード開始
        task.resume()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //マンガリストの総数
        return mangaList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //cellオブジェクト一行
        let cell = tableView.dequeueReusableCell(withIdentifier: "comicCell", for: indexPath)
        //マンガのタイトル、作者名設定
        cell.textLabel?.text = mangaList[indexPath.row].title
        cell.detailTextLabel?.text = mangaList[indexPath.row].author
        //画像を取得
        if let imageData = try? Data(contentsOf: mangaList[indexPath.row].smallImageUrl) {
            //正常に取得できた場合はUIimageで画像オブジェクトを生成してCellにマンガ画像を設定
            cell.imageView?.image = UIImage(data: imageData)
        }
        //設定済みのcellオブジェクト
        return cell
    }
    
    
    
    
    // Cellが選択された時に呼び出されるメソッド
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //ハイライト解除
        tableView.deselectRow(at: indexPath, animated: true)
        
        //SFSafariViewを開く
        let safariViewController = SFSafariViewController(url: mangaList[indexPath.row].itemUrl)
        
        //deleteの通知先を自分自身に
        safariViewController.delegate = self
        
        //SafariViewが開かれる
        present(safariViewController, animated: true, completion: nil)
    }
    //SafariViewが閉じられた時に呼ばれるdelegateメソッド
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        //SafariViewを閉じる
        dismiss(animated: true, completion: nil)
    }
}
