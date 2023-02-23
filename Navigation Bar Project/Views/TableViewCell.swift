//
//  TableViewCell.swift
//  Navigation Bar Project
//
//  Created by 정준영 on 2023/02/17.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    var chatBox: ChatBox? {
        didSet{
            guard let chatBox = chatBox else {return}
            self.textView.text = chatBox.chatBoxText
            self.MessageTimeLabel.text = chatBox.textedTime
            
        }
    }

    @IBOutlet weak var uiView: UIView!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var MessageTimeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        uiView.layer.cornerRadius = 12
        uiView.layer.masksToBounds = true

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        chatBoxSize()
    }
    func chatBoxSize() {
        
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 4, left: 50, bottom: 4, right: 12))
        
        textView.textContainerInset = .zero
        textView.isScrollEnabled = false
        textView.isEditable = false
        
        
    }
}

extension TableViewCell: UITextViewDelegate {
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        return false
    }
}

extension UITextView {
    func setTextView() {
        self.translatesAutoresizingMaskIntoConstraints = true
        self.sizeToFit()
    }
}
