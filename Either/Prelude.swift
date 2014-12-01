//  Copyright (c) 2014 Rob Rix. All rights reserved.

func id<T>(x: T) -> T {
	return x
}

func const<T, U>(x: T) -> U -> T {
	return { _ in x }
}
