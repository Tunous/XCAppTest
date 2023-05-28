# XCAppTest

Utilities for easier interaction with XCUITest methods.

## What's included

- `XCUIElement` extensions:
    - Checking existence of elements:
        - `assertExists()`
        - `assertExists(waitForAppToIdle: true)`
        - `assertNotExists()`
    - Checking interactivity of elements:
        - `assertIsHittable()`
        - `assertIsNotHittable()`
        - `assertIsEnabled()`
        - `assertIsDisabled()`
        - `assertIsInteractive()` (exists, isHittable, isEnabled)
    - Checking properties of elements:
        - `assertHasLabel("label")`
        - `assertContainsText("label")`
        - `assertHasValue("equatable value")`
        - `assertHasPlaceholder("placeholder")`
    - Checking traits of elements:
        - `assertIsSelected()`
        - `assertIsNotSelected()`
    - Performing actions:
        - `tapWhenReady()`
        - `waitForInteractivity()`
        - `slowTypeText("text")`
        - `tap(withNormalizedOffset: .center)`

- `XCUIApplication` extensions:
    - Accessing other apps:
        - `XCUIApplication.safari`
    - Checking foreground state:
        - `assertIsInForeground()`
        - `assertIsNotInForeground()`
    - Performing actions:
        - `moveToBackground()`

- `XCUIElementQuery` extensions:
    - Checking number of elements:
        - `assertHasCount(2)`
        - `assertNotExists()`

- `CGVector` extensions:
    - Normalized offsets:
        - `topLeft`, `top`, `topRight`
        - `left`, `center`, `right`
        - `bottomLeft`, `bottom`, `bottomRight`

All of the above assertion functions have optional message as last parameter that can be used to configure what is displayed if assertion fails. For example: `element.assertExists("My element should be visible")`.

## Example

Here is a short example from one of my apps that makes use of this library. In the test I am checking that it is possible to navigate to "Premium features" screen, verify that most important data is visible and check that it is possible to leave that screen.

Note that some of the buttons are identified by enum case instead of raw string. You can see [type safe identifiers](#type-safe-identifiers) tip below to see how this is implemented.

```swift
func testOpenClosePremiumScreen() throws {
    try launch(configuration: .init(premiumUnlocked: false))

    app.buttons[.toggleBottomSheetButton].tap()
    app.buttons["Unlock Premium"].tapWhenReady()
    assertPremiumScreenIsVisible()
    app.buttons[.unlockFeaturesButton].assertIsEnabled().assertContainsText("Lifetime access")
    app.buttons["Restore Purchase"].assertIsEnabled()

    app.buttons["Dismiss"].tap()
    app.staticTexts["Pipilo Premium"].assertNotExists()
}
```

## Installation

### Swift Package Manager

1. Add the following to the dependencies array in your `Package.swift` file:

```swift
.package(url: "https://github.com/Tunous/XCAppTest.git", .upToNextMajor(from: "0.4.0")),
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
