

import UIKit
import Alamofire
import SwiftyJSON
import SVProgressHUD

class TableViewController: UITableViewController, UISearchBarDelegate {
    @IBOutlet weak var searchbar: UISearchBar!
    
    var arrayMusic: [ItunesMusic] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchbar.delegate = self
        searchbar.placeholder = "Search artist"
        
        searchMusic(term: "eminem")
    }
    
    func searchMusic(term: String) {
        //http://itunes.apple.com/search?term=eminem&limit=25
//        200 OK: Запрос успешно выполнен и сервер возвращает запрошенные данные.
//        201 Created: Запрос успешно выполнен, и на сервере был создан новый ресурс.
//        204 No Content: Запрос выполнен успешно, но сервер не возвращает содержимое в ответе.
//        400 Bad Request: Запрос содержит синтаксическую ошибку или некорректные данные, и сервер не может его обработать.
//        401 Unauthorized: Для доступа к запрашиваемому ресурсу требуется аутентификация пользователя.
//        403 Forbidden: Доступ к запрашиваемому ресурсу запрещен, даже после аутентификации.
//        404 Not Found: Запрашиваемый ресурс не найден на сервере.
//        500 Internal Server Error: На сервере произошла ошибка, которая не позволяет выполнить запрос.
        let parameters = ["term" : term, //2pac
                          "limit": 25] as [String: Any]
        
        SVProgressHUD.show()
        
        AF.request("https://itunes.apple.com/search", method: .get, parameters: parameters).responseData { response in
            print("\(String(describing: response.request))")  // original URL request
            
            
            SVProgressHUD.dismiss()
            
            var resultString = ""
            if let data = response.data {
                resultString = String(data: data, encoding: .utf8)!
                print(resultString)
            }
            
            if response.response?.statusCode == 200 {
                let json = JSON(response.data!)
                
                if let array = json["results"].array {
                    for item in array {
                        let music = ItunesMusic(json: item)
                        self.arrayMusic.append(music)
                    }
                }
                
                self.tableView.reloadData()
            }
        }
        
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        arrayMusic.removeAll()
        tableView.reloadData()
        searchMusic(term: searchBar.text!)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return arrayMusic.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! MusicTableViewCell

        cell.setData(music: arrayMusic[indexPath.row])

        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 162.0
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        
        vc.music = arrayMusic[indexPath.row]
        
        navigationController?.show(vc, sender: self)
    }
}
