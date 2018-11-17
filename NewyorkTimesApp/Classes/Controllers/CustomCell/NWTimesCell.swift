//
//  NWTimesCell.swift
//  NewyorkTimesApp
//


import UIKit

class NWTimesCell: UITableViewCell {
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelByLine: UILabel!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelDate: UILabel!
    @IBOutlet weak var imageViewProfile: RoundedImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
         self.imageViewProfile.layer.cornerRadius = min(self.imageViewProfile.frame.size.height, self.imageViewProfile.frame.size.width) / 2.0
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
