import Foundation

// MARK: - CodingWrapper
protocol CodingWrapper: NSCoding {
    associatedtype CodingType
    init(model: CodingType)
    var model: CodingType { get }
}

// MARK: - Coding
protocol Coding {
    associatedtype CoderClass: CodingWrapper
    var coder: CoderClass { get }
}

extension Coding {
    var coder: CoderClass {
        guard let model = self as? Self.CoderClass.CodingType else {
            preconditionFailure()
        }

        return CoderClass(model: model)
    }
}

// MARK: - MyStruct
struct MyStruct<T: Coding> {}

extension MyStruct: Coding {
    typealias CoderClass = Wrapper

    class Wrapper: NSObject, CodingWrapper {
        let model: T

        required init(model: T) {
            self.model = model
            super.init()
        }

        required init?(coder decoder: NSCoder) {
            return nil
        }

        public func encode(with coder: NSCoder) {
        }
    }
}
