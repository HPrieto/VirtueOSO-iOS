//
//  BorderedTextField+TextField.swift
//  VirtueOSO
//
//  Created by Heriberto Prieto on 7/12/20.
//  Copyright © 2020 Heriberto Prieto. All rights reserved.
//

import UIKit

extension BorderedTextField: UITextViewDelegate {
    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        _state = .edit
        if textView.text.count == 0 {
            textView.text = " "
            textView.text = ""
        }
        return true
    }
    
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        _state = .normal
        return true
    }
    
    func textViewDidChange(_ textView: UITextView) {
    }
    
    func textViewDidChangeSelection(_ textView: UITextView) {
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        _state = .edit
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
    }
    
}
