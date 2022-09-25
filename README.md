# XCAppTest

Utilities for easier interaction with XCUITest methods.

## Installation

### Swift Package Manager

1. Add the following to the dependencies array in your `Package.swift` file:

```swift
.package(url: "https://github.com/Tunous/XCAppTest.git"),
```

2. Add `XCAppTest` as a dependency for your **tests** target:

```swift
.target(name: "MyAppTests", dependencies: ["XCAppTest"]),
```

3. Add `import XCAppTest` in your tests source code.

### Xcode

Add [https://github.com/Tunous/XCAppTest.git](https://github.com/Tunous/XCAppTest.git), to the list of Swift packages for your project in Xcode and include it as a dependency on your **tests** target.

# Tips

## Type safe identifiers

To make interaction with elements easier, you can introduce a helper enum that will act as a type safe accessibility identifier. That way you will avoid typos when trying to match user interface elements from your tests.

1. Create `ElementIdentifier.swift` file with following contents and include it in both your source and tests targets:

```swift
public enum ElementIdentifier: String {
    case exampleButton
    // More identifiers can be added here
}

extension View {
    public func accessibilityIdentifier(_ id: ElementIdentifier) -> some View {
        return self.accessibilityIdentifier(id.rawValue)
    }
}
```

2. In tests target add helper extension to match element by this new identifier:

```swift
extension XCUIElementQuery {
    public subscript(_ id: ElementIdentifier) -> XCUIElement {
        return self[id.rawValue]
    }

    public subscript(_ id: ElementIdentifier, boundBy index: Int) -> XCUIElement {
        return self.matching(identifier: id.rawValue).element(boundBy: index)
    }
}
```

3. In your views use the new `ElementIdentifier` instead of String as accessibilityIdentifier:

```swift
struct MyView: View {
    var body: some View {
        Button("My button", action: {})
            .accessibilityIdentifier(.exampleButton)
    }
}
```

4. Access mentioned button in your tests:

```swift
func testTapButton() {
    let app = XCUIApplication()
    app.buttons[.exampleButton].tap()
}
```
