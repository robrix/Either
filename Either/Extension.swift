//  Copyright (c) 2016 Rob Rix. All rights reserved.

extension Sequence where Iterator.Element: EitherProtocol {
	/// Select only `Right` instances.
	public func rights() -> [Iterator.Element.Right] {
		return self.flatMap{ $0.right }
	}
	
	/// Select only `Left` instances.
	public func lefts() -> [Iterator.Element.Left] {
		return self.flatMap{ $0.left }
	}
}
