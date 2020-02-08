//
//  ContentView.swift
//  TextHighlightTest
//
//  Created by Yehor Sorokin on 07.02.2020.
//  Copyright © 2020 Yehor Sorokin. All rights reserved.
//

import UIKit

final class ContentView: UIView {
    
    var message: String? {
        didSet {
            setup()
        }
    }
    
    let wordHeight: CGFloat = 30
    
    var words: [UILabel] = []
    
    var highlightStart: Int?
    var highlightEnd: Int?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for view in subviews where view.frame.contains(touches.first!.location(in: self)) {
            guard view is UILabel else { return }
            let temp = view as? UILabel
            highlightStart = words.firstIndex(of: temp!)
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for view in subviews where view.frame.contains(touches.first!.location(in: self)) {
            guard view is UILabel else { return }
            let temp = view as? UILabel
            highlightEnd = words.firstIndex(of: temp!)
            
            if let start = highlightStart, let end = highlightEnd {
                applyHighlight(from: start, to: end)
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        highlightStart = nil
        highlightEnd = nil
        
        cancelHighlight()
    }
    
    private func splitText(_ text: String) -> [Substring] {
        return text.split(separator: " ")
    }
    
    private func setup() -> Void {
        var currentTopOffest: CGFloat = 100
        var currentLeftOffset: CGFloat = 0
        var lineStartIndex = 0
        
        guard let message = message else { return }
        let tempText: [String] = splitText(message).map { String($0) }
        
        for word in tempText {
            let label = UILabel()
            label.text = word
            words.append(label)
            
            let totalWidth: CGFloat = calculateTotalWidth(for: words, starts: lineStartIndex)
            if totalWidth > UIScreen.main.bounds.width {
                currentLeftOffset = 0
                currentTopOffest += wordHeight
                lineStartIndex = words.count
            } else {
                currentLeftOffset += label.intrinsicContentSize.width + 50
            }
            label.frame = CGRect(x: currentLeftOffset, y: currentTopOffest, width: label.intrinsicContentSize.width, height: wordHeight)
            addSubview(label)
        }
    }
    
    private func calculateTotalWidth(for labels: [UILabel], starts line: Int) -> CGFloat {
        var total: CGFloat = 0
        for label in labels[line..<labels.count] {
            total += label.intrinsicContentSize.width
        }
        return total
    }
    
    private func applyHighlight(from: Int, to: Int) -> Void {
        var start = from
        var end = to
        
        if end < start {
            (start, end) = (end, start)
            for word in words[start...end].reversed() {
                word.backgroundColor = UIColor.green
            }
        } else {
            for word in words[start...end].reversed() {
                word.backgroundColor = UIColor.green
            }
        }
    }
    
    private func cancelHighlight() -> Void {
        for word in words {
            word.backgroundColor = UIColor.clear
        }
    }

}
