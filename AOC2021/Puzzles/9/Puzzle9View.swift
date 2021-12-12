
import AOCLib
import SwiftUI

struct Puzzle9View: View {
	private var columns: [GridItem]
	private var grid: Grid2D

	init() {
		grid = Solve9().inputGrid
		columns = Array(repeating: .init(.flexible(), spacing: 0), count: grid.maxPos.y)
	}

	var body: some View {
		ScrollView(.horizontal) {
			LazyVGrid(columns: columns, spacing: 0) {
				ForEach(0 ..< grid.maxPos.arrayIndex(numCols: grid.maxPos.y - 1), id: \.self) { pos in
					Color(color(val: grid.value(.init(from: pos, numCols: grid.maxPos.y))))
						.frame(maxWidth: .infinity)
						.frame(height: 10)
				}
			}
		}
	}

	private func color(val: Int) -> UIColor {
		if val == 9 {
			return .white
		}
		if val == 0 {
			return .black
		}
		return .init(red: 165.0 / 255.0, green: 42 / 255.0, blue: 42 / 255.0, alpha: 1.0 - CGFloat(val) * 0.1)
	}
}

struct Puzzle9View_Previews: PreviewProvider {
	static var previews: some View {
		Puzzle9View()
	}
}
