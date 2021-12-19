
import AOCLib
import Foundation
import UIKit

class Solve17: PuzzleSolver {
	func solveAExamples() -> Bool {
		solveA(exampleA) == 45
	}

	func solveBExamples() -> Bool {
		true
	}
	
	// target area: x=20..30, y=-10..-5
	let exampleA = CGRect(x: 20, y: -10, width: 10, height: 5)
	// target area: x=124..174, y=-123..-86
	let targetA = CGRect(x: 124, y: -123, width: 50, height: (-86+123))
	

	var answerA = "7503"
	var answerB = ""

	func solveA() -> String {
		solveA(targetA).description
	}

	func solveB() -> String {
		"" // solveB("Input17").description
	}
	
	// Returns maxHeight if hits, or 0 if misses.
	func hits(_ v: Position2D, _ target: CGRect) -> Int {
		var pos = CGPoint(x: 0, y: 0)
		var velocity = CGPoint( x: v.x, y: v.y)
		var maxHeight: CGFloat = 0
		while pos.x < target.maxX && pos.y > target.minY {
			pos.x += velocity.x
			pos.y += velocity.y
			if velocity.x > 0 {
				velocity.x -= 1
			} else if velocity.x < 0 {
				velocity.x += 1
			}
			velocity.y -= 1
			
			maxHeight = max(maxHeight, pos.y)
			if target.contains(pos) {
				return Int( maxHeight)
			}
		}
		return 0
	}

	func solveA(_ target: CGRect) -> Int {
		
		// Guesses
		let minX = 1
		let maxX = Int(target.minX)
		let minY = 0
		let maxY = maxX * 2
		
		var maxHeight = 0
		for x in minX ... maxX {
			for y in minY ... maxY {
				let height = hits(.init(x, y), target)
				if height > maxHeight {
					maxHeight = height
				}
			}
		}
		
		return maxHeight
	}

	func solveB(_: String) -> Int {
		0
	}
}
