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
For details see [documentation](https://swiftpackageindex.com/Tunous/XCAppTest/main/documentation/xcapptest).

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
