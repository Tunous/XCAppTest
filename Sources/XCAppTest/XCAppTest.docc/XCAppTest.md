# ``XCAppTest``

Utilities for easier interaction with XCUITest methods

## Example

Here is a short example from one of my apps that makes use of this library. In the test I am checking that it is possible to navigate to "Premium features" screen, verify that most important data is visible and check that it is possible to leave that screen.

Note that some of the buttons are identified by enum case instead of raw string. You can see type safe identifiers tip below to see how this is implemented.

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

## Topics

- <doc:Tips>

### Checking existence of elements

- ``XCAppTest/XCTest/XCUIElement/assertExists(waitForAppToIdle:_:file:line:)``
- ``XCAppTest/XCTest/XCUIElement/assertNotExists(_:file:line:)``
- ``XCAppTest/XCTest/XCUIElement/assertExists(_:_:file:line:)``
- ``XCAppTest/XCTest/XCUIElementQuery/assertNotExists(_:file:line:)``

### Checking interactivity of elements

- ``XCAppTest/XCTest/XCUIElement/assertIsHittable(_:file:line:)``
- ``XCAppTest/XCTest/XCUIElement/assertIsNotHittable(_:file:line:)``
- ``XCAppTest/XCTest/XCUIElement/assertIsHittable(_:_:file:line:)``
- ``XCAppTest/XCTest/XCUIElement/assertIsEnabled(_:file:line:)``
- ``XCAppTest/XCTest/XCUIElement/assertIsDisabled(_:file:line:)``
- ``XCAppTest/XCTest/XCUIElement/assertIsEnabled(_:_:file:line:)``
- ``XCAppTest/XCTest/XCUIElement/assertIsInteractive(_:file:line:)``

### Checking properties of elements

- ``XCAppTest/XCTest/XCUIElement/assertHasLabel(_:_:file:line:)``
- ``XCAppTest/XCTest/XCUIElement/assertContainsText(_:_:file:line:)``
- ``XCAppTest/XCTest/XCUIElement/assertHasValue(_:_:file:line:)``
- ``XCAppTest/XCTest/XCUIElement/assertHasPlaceholder(_:_:file:line:)``

### Checking traits of elements

- ``XCAppTest/XCTest/XCUIElement/assertIsSelected(_:file:line:)``
- ``XCAppTest/XCTest/XCUIElement/assertIsNotSelected(_:file:line:)``
- ``XCAppTest/XCTest/XCUIElement/assertIsSelected(_:_:file:line:)``

### Performing actions

- ``XCAppTest/XCTest/XCUIElement/tapWhenReady(_:file:line:)``
- ``XCAppTest/XCTest/XCUIElement/waitForInteractivity(_:file:line:)``
- ``XCAppTest/XCTest/XCUIElement/slowTypeText(_:)``
- ``XCAppTest/XCTest/XCUIElement/tap(withNormalizedOffset:)``
- ``XCAppTest/XCTest/XCUIElement/drag(from:to:pressDuration:)``
- ``XCAppTest/XCTest/XCUIElement/press(forDuration:withNormalizedOffset:)``
- ``XCAppTest/XCTest/XCUIApplication/moveToBackground(_:)``

### Accessing other apps

- ``XCAppTest/XCTest/XCUIApplication/safari``
- ``XCAppTest/XCTest/XCUIApplication/springboard``
- ``XCAppTest/XCTest/XCUIApplication/messages``

### Checking foreground state

- ``XCAppTest/XCTest/XCUIApplication/assertIsInForeground(_:file:line:)``
- ``XCAppTest/XCTest/XCUIApplication/assertIsNotInForeground(_:file:line:)``
- ``XCAppTest/XCTest/XCUIApplication/assertIsInForeground(_:_:file:line:)``

### Checking number of elements

- ``XCAppTest/XCTest/XCUIElementQuery/assertHasCount(_:_:file:line:)-6ndsd``
- ``XCAppTest/XCTest/XCUIElementQuery/assertHasCount(_:_:file:line:)-8jvu3``

### Normalized offsets

- ``XCAppTest/CoreGraphics/CGVector/topLeft``
- ``XCAppTest/CoreGraphics/CGVector/top``
- ``XCAppTest/CoreGraphics/CGVector/topRight``
- ``XCAppTest/CoreGraphics/CGVector/left``
- ``XCAppTest/CoreGraphics/CGVector/center``
- ``XCAppTest/CoreGraphics/CGVector/right``
- ``XCAppTest/CoreGraphics/CGVector/bottomLeft``
- ``XCAppTest/CoreGraphics/CGVector/bottom``
- ``XCAppTest/CoreGraphics/CGVector/bottomRight``
- ``XCAppTest/CoreGraphics/CGVector/offset(x:y:)``
