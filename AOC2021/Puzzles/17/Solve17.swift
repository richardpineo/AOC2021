
import AOCLib
import Foundation
import UIKit

class Solve17: PuzzleSolver {
	func solveAExamples() -> Bool {
		solveA(exampleTarget) == 45
	}

	func solveBExamples() -> Bool {
		solveB(exampleTarget) == 112
	}

	// target area: x=20..30, y=-10..-5
	let exampleTarget = CGRect(x: 20, y: -10, width: 10, height: 5)
	// target area: x=124..174, y=-123..-86
	let actualTarget = CGRect(x: 124, y: -123, width: 50, height: -86 + 123)

	var answerA = "7503"
	var answerB = "3229"

	func solveA() -> String {
		solveA(actualTarget).description
	}

	func solveB() -> String {
		solveB(actualTarget).description
	}

	// Returns maxHeight if hits, or nil if misses.
	func hits(_ v: Position2D, _ target: CGRect) -> Int? {
		var pos = CGPoint(x: 0, y: 0)
		var velocity = CGPoint(x: v.x, y: v.y)
		var maxHeight: CGFloat = 0
		while pos.x <= target.maxX, pos.y >= target.minY {
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
				return Int(maxHeight)
			}
		}
		return nil
	}

	// Returns maxHeight, hitCount
	func solve(_ targetRaw: CGRect) -> (Int, Int) {
		// Because pt in rect doesn't count if on the maxX, maxY value.
		let target = CGRect(origin: targetRaw.origin, size: CGSize(width: targetRaw.width + 1, height: targetRaw.height + 1))

		// Guesses
		let minX = 1
		let maxX = Int(target.maxX)
		let minY = Int(target.minY)
		let maxY = maxX

		var hitCount = 0
		var maxHeight = 0

		for x in minX ... maxX {
			for y in minY ... maxY {
				if let height = hits(.init(x, y), target) {
					// print ("Hit: \(x),\(y)")
					hitCount += 1
					maxHeight = max(maxHeight, height)
				}
			}
		}

		return (maxHeight, hitCount)
	}

	func solveA(_ target: CGRect) -> Int {
		solve(target).0
	}

	func solveB(_ target: CGRect) -> Int {
		solve(target).1
	}
}
