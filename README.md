# XCAppTest

[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2FTunous%2FXCAppTest%2Fbadge%3Ftype%3Dswift-versions)](https://swiftpackageindex.com/Tunous/XCAppTest) [![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2FTunous%2FXCAppTest%2Fbadge%3Ftype%3Dplatforms)](https://swiftpackageindex.com/Tunous/XCAppTest)

Utilities for easier interaction with XCUITest methods.

## What's included

- `XCUIElement` extensions:
    - Checking existence of elements:
        - `assertExists()`
        - `assertExists(waitForAppToIdle: true)`
        - `assertNotExists()`
        - `assertExists(false)`
    - Checking interactivity of elements:
        - `assertIsHittable()`
        - `assertIsNotHittable()`
        - `assertIsHittable(false)`
        - `assertIsEnabled()`
        - `assertIsDisabled()`
        - `assertIsEnabled(false)`
        - `assertIsInteractive()` (exists, isHittable, isEnabled)
    - Checking properties of elements:
        - `assertHasLabel("label")`
        - `assertContainsText("label")`
        - `assertHasValue("equatable value")`
        - `assertHasValue()`
        - `assertIsOn()`
        - `assertIsOff()`
        - `assertIsOn(false)`
        - `assertHasPlaceholder("placeholder")`
        - `assertIsEmpty()` (value == placeholderValue)
        - `assertHasTitle("title")`
        - `assertHasNonEmptyStringValue()`
    - Checking traits of elements:
        - `assertIsSelected()`
        - `assertIsNotSelected()`
        - `assertIsSelected(false)`
    - Performing actions:
        - `tapWhenReady()`
        - `waitForInteractivity()`
        - `slowTypeText("text")`
        - `tap(withNormalizedOffset: .center)`
        - `drag(from: .top, to: .bottom, pressDuration: 1)`
        - `press(forDuration: 1, withNormalizedOffset: .center)`
        - `pressWhenReady(forDuration: 2)`
        - `tapIfExists()`
        - `tapCenter()`
        - `deleteText()`
        - `deleteText(3)`
    - Accessing properties of elements:
        - `stringValue`
        - `intValue`
        - `isOn`

- `XCUIApplication` extensions:
    - Accessing other apps:
        - `XCUIApplication.safari`
        - `XCUIApplication.springboard`
        - `XCUIApplication.messages`
        - `XCUIApplication.settings`
    - Checking foreground state:
        - `assertIsInForeground()`
        - `assertIsNotInForeground()`
        - `assertIsInForeground(false)`
    - Performing actions:
        - `moveToBackground()`

- `XCUIElementQuery` extensions:
    - Checking number of elements:
        - `assertHasCount(2)`
        - `assertNotExists()`
        - `assertHasCount(2...5)`, `assertHasCount(..<3)`
        - `assertExists()`
    - Accessing elements:
        - `lastMatch`
        - `self[2]`
        - `first(where: { $0.label == "a" })`
        - `bannerNotifications`
    - Asserting elements:
        - `assertMatchedElements(perform: { element in /*...*/ })`

- `CGVector` extensions:
    - Normalized offsets:
        - `CGVector.topLeft`, `CGVector.top`, `CGVector.topRight`
        - `CGVector.left`, `CGVector.center`, `CGVector.right`
        - `CGVector.bottomLeft`, `CGVector.bottom`, `CGVector.bottomRight`
        - `offset(x: 0.2, y: 0.5)`
        
- `XCUIElement.ElementType` extensions:
    - `bannerNotification`
    
- `XCTestCase` extensions:
    - `run { ... }`
    - `run("Activity name") { ... }`

All of the above assertion functions have optional message as last parameter that can be used to configure what is displayed if assertion fails. For example: `element.assertExists("My element should be visible")`.
Additionally you can configure assertion timeout globally by modifying `XCAppTestConfig.defaultTimeout` or per call via `timeout` parameter. For example: `XCAppTestConfig.defaultTimeout = 3`, `element.assertExists(timeout: 3)`.
For details see [documentation](https://swiftpackageindex.com/Tunous/XCAppTest/main/documentation/xcapptest).

## Example

Here is a short example from one of my apps that makes use of this library. In the test I am checking that it is possible to navigate to "Premium features" screen, verify that most important data is visible and check that it is possible to leave that screen.

Note that some of the buttons are identified by enum case instead of raw string. You can see [type safe identifiers](https://swiftpackageindex.com/tunous/xcapptest/main/documentation/xcapptest/typesafeidentifiers) tip to see how this is implemented.

```swift
func testOpenClosePremiumScreen() throws {
    try launch(configuration: .init(premiumUnlocked: false))

    app.buttons[.toggleBottomSheetButton].tap()
    app.buttons["Unlock Premium"].tapWhenReady()
    
    run("Verify screen content") {
        assertPremiumScreenIsVisible()
        app.buttons[.unlockFeaturesButton].assertIsEnabled().assertContainsText("Lifetime access")
        app.buttons["Restore Purchase"].assertIsEnabled()
    }

    app.buttons["Dismiss"].tap()
    app.staticTexts["Pipilo Premium"].assertNotExists()
}
```

## Installation

### Swift Package Manager

1. Add the following to the dependencies array in your `Package.swift` file:

```swift
.package(url: "https://github.com/Tunous/XCAppTest.git", .upToNextMajor(from: "0.14.0")),
```

2. Add `XCAppTest` as a dependency for your **tests** target:

```swift
.target(name: "MyAppTests", dependencies: ["XCAppTest"]),
```

3. Add `import XCAppTest` in your tests source code.

### Xcode

Add [https://github.com/Tunous/XCAppTest.git](https://github.com/Tunous/XCAppTest.git), to the list of Swift packages for your project in Xcode and include it as a dependency on your **tests** target.
