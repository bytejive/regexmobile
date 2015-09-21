//: Playground - noun: a place where people can play

import UIKit

func colorWithHue(hue: CGFloat) -> UIColor {
	return UIColor(hue: hue, saturation: 1.0, brightness: 1.0, alpha: 0.5)
}

let colors = [
	colorWithHue(0),
	colorWithHue(1/8),
	colorWithHue(2/8),
	colorWithHue(3/8),
	colorWithHue(4/8),
	colorWithHue(5/8),
	colorWithHue(6/8),
	colorWithHue(7/8),
]

func highlightMatches(pattern: String, inString string: String) throws -> NSAttributedString {
	let regex = try NSRegularExpression(pattern: pattern, options: .CaseInsensitive)
	let strings = string.characters.split("\n")
	let text: NSMutableAttributedString = NSMutableAttributedString()
	for characters in strings {
		var i = 0
		let string = String(characters) + "\n"
		let range = NSMakeRange(0, string.characters.count)
		let matches = regex.matchesInString(String(string), options: .Anchored, range: range)
		
		let attributedText = NSMutableAttributedString(string: string)
		
		for match in matches {
			for range in 1 ..< match.numberOfRanges {
				attributedText.addAttribute(NSBackgroundColorAttributeName, value: colors[(i++ % colors.count)], range: match.rangeAtIndex(range))
			}
		}
		text.appendAttributedString(attributedText.copy() as! NSAttributedString)
	}
	return text
}


let testString = "thing with other letters\nsome other words"
let matches = try highlightMatches("([a-z]+)\\s", inString: testString)
