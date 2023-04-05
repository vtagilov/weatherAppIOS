import UIKit

class LocationTableViewCell: UITableViewCell {
    
        let titleLabel = UILabel()
    let imageLabel = UIImage()
    

    init(reuseIdentifier: String?, indexPath: IndexPath) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        
        
        contentView.addSubview(titleLabel)
        
        titleLabel.text = reuseIdentifier
        titleLabel.font = UIFont.boldSystemFont(ofSize: 30)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0),
            titleLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            titleLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor)
        ])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        if selected == true {
            print("LocationTableViewCell \(titleLabel.text ?? "") was selected")
            
            
            
            

        }
        
    }
    
}
