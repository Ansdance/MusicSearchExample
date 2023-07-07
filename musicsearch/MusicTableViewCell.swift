

import UIKit
import SDWebImage

class MusicTableViewCell: UITableViewCell {
    @IBOutlet weak var albomImageView: UIImageView!
    @IBOutlet weak var songNameLabel: UILabel!
    @IBOutlet weak var artistNameLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(music: ItunesMusic) {
        artistNameLabel.text = music.artistName
        
        songNameLabel.text = music.trackName
        
        albomImageView.sd_setImage(with: URL(string: music.artworkUrl100), completed: nil)
        print("___________________________")
        print(URL(string: music.artworkUrl100))
    }

}
