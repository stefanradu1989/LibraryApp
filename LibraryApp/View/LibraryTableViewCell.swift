//
//  LibraryTableViewCell.swift
//  LibraryApp
//
//  Created by Radu Stefan on 15/12/2020.
//

import UIKit


class LibraryTableViewCell: UITableViewCell
{
    
    // MARK: IBOutlets
    
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var numberOfBooksLabel: UILabel!
    @IBOutlet weak var evenLabel: UILabel!
    
    
    // MARK: Cell Lifecycle
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    // MARK: Cell Selection

    override func setSelected(_ selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
