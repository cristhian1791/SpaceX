//
//  MenuCell.swift
//  SpaceX3
//
//  Created by Cristhian on 01/01/24.
//
import UIKit
class MenuCell: UITableViewCell {
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var icon: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated) 
    }
    func configureCell(icon: String, title: String) {
        self.lblTitle.text = title
        self.icon.image = UIImage(systemName: icon)
    }
}
