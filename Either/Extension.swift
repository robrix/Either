//  Copyright (c) 2016 Rob Rix. All rights reserved.

extension Sequence where Iterator.Element: EitherProtocol {
	/// Select only `Right` instances.
	public var rights: [Iterator.Element.Right] {
		return flatMap{ $0.right }
	}
	
	/// Select only `Left` instances.
	public var lefts: [Iterator.Element.Left] {
		return flatMap{ $0.left }
	}
}
