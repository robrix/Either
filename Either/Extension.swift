//  Copyright (c) 2016 Rob Rix. All rights reserved.

extension Sequence where Iterator.Element: EitherProtocol {
	/// Select only `Right` instances.
	public func rights() -> [Iterator.Element.Right] {
		return self.filter{ $0.isRight }.map{ $0.right! }
	}
	
	/// Select only `Left` instances.
	public func lefts() -> [Iterator.Element.Left] {
		return self.filter{ $0.isLeft }.map{ $0.left! }
	}
}
