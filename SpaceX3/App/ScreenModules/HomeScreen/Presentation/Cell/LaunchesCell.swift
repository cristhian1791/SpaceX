//
//  LaunchesCell.swift
//  BimboNetPruebaTecnica
//
//  Created by CRISTHIAN OMAR GUZMAN HERNANDEZ on 23/12/23.
//
import UIKit
class LaunchesCell: UITableViewCell {
    @IBOutlet weak var viewContainer: UILabel!
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    override func layoutSubviews() {
          super.layoutSubviews()
          let bottomSpace: CGFloat = 10.0
          self.contentView.frame = self.contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: bottomSpace, right: 0))
     }
    override func prepareForReuse() {
            super.prepareForReuse()
            iconImage.image = nil
            lblTitle.text = nil
            lblDescription.text = nil
            lblDate.text = nil
        }
    override func awakeFromNib() {
        super.awakeFromNib()
        viewContainer.layer.borderWidth = 1
        viewContainer.layer.borderColor = UIColor.gray.cgColor
        viewContainer.layer.cornerRadius = 10
    }
    
    /// Estabelce la configuración de la celda.
    /// - Parameter iconImage: Imagen de la celda.
    /// - Parameter title: Título que llevara el primer label de celda.
    /// - Parameter description: Descripción del lanzamiento.
    /// - Parameter date: Fecha del lanzamiento.
    func configureCell(urlImage: String, title: String?, description: String?, date: String?) {
        if let urlImage = URL(string: urlImage) {
            self.iconImage?.load(url: urlImage)
        }
        self.lblTitle.text = title
        self.lblDescription.text = description
        self.lblDate.text = date
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
