# ``XCAppTest``

Utilities for easier interaction with XCUITest methods

XCAppTests builds upon default XCUITest capabilities by introducing helper assertion methods and extensions. It allows you to create readable tests that are easy to write and offer detailed failure descriptions when tests fail.

Here is a short example from one of my apps that makes use of this library. In the test I am checking that it is possible to navigate to "Premium features" screen, verify that most important data is visible and check that it is possible to leave that screen.

Note that some of the buttons are identified by enum case instead of raw string. You can see <doc:Tips> section to see how this is implemented.

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

## Customization

### Failure messages

All of the assertion functions have optional message as last parameter that can be used to configure what is displayed if assertion fails.

```swift
element.assertExists("My element should be visible")
```

### Timeouts

You can configure assertion timeout globally by modifying `XCAppTestTimeout.default` property or per call via `timeout` parameter.

```swift
XCAppTestTimeout.default = 3

element.assertExists(timeout: 3)
```

## Topics

### Tips

- <doc:TypeSafeIdentifiers>

### Checking existence of elements

- ``XCAppTest/XCTest/XCUIElement/assertExists(waitForAppToIdle:timeout:_:file:line:)``
- ``XCAppTest/XCTest/XCUIElement/assertNotExists(timeout:_:file:line:)``
- ``XCAppTest/XCTest/XCUIElement/assertExists(_:timeout:_:file:line:)``
- ``XCAppTest/XCTest/XCUIElementQuery/assertNotExists(timeout:_:file:line:)``

### Checking interactivity of elements

- ``XCAppTest/XCTest/XCUIElement/assertIsHittable(timeout:_:file:line:)``
- ``XCAppTest/XCTest/XCUIElement/assertIsNotHittable(timeout:_:file:line:)``
- ``XCAppTest/XCTest/XCUIElement/assertIsHittable(_:timeout:_:file:line:)``
- ``XCAppTest/XCTest/XCUIElement/assertIsEnabled(timeout:_:file:line:)``
- ``XCAppTest/XCTest/XCUIElement/assertIsDisabled(timeout:_:file:line:)``
- ``XCAppTest/XCTest/XCUIElement/assertIsEnabled(_:timeout:_:file:line:)``
- ``XCAppTest/XCTest/XCUIElement/assertIsInteractive(timeout:_:file:line:)``

### Checking properties of elements

- ``XCAppTest/XCTest/XCUIElement/assertHasLabel(_:timeout:_:file:line:)``
- ``XCAppTest/XCTest/XCUIElement/assertContainsText(_:timeout:_:file:line:)``
- ``XCAppTest/XCTest/XCUIElement/assertHasValue(_:timeout:_:file:line:)``
- ``XCAppTest/XCTest/XCUIElement/assertHasPlaceholder(_:timeout:_:file:line:)``
- ``XCAppTest/XCTest/XCUIElement/assertIsEmpty(timeout:_:file:line:)``
- ``XCAppTest/XCTest/XCUIElement/assertHasTitle(_:timeout:_:file:line:)``

### Checking traits of elements

- ``XCAppTest/XCTest/XCUIElement/assertIsSelected(timeout:_:file:line:)``
- ``XCAppTest/XCTest/XCUIElement/assertIsNotSelected(timeout:_:file:line:)``
- ``XCAppTest/XCTest/XCUIElement/assertIsSelected(_:timeout:_:file:line:)``

### Performing actions

- ``XCAppTest/XCTest/XCUIElement/tapWhenReady(timeout:_:file:line:)``
- ``XCAppTest/XCTest/XCUIElement/waitForInteractivity(timeout:_:file:line:)``
- ``XCAppTest/XCTest/XCUIElement/slowTypeText(_:)``
- ``XCAppTest/XCTest/XCUIElement/tap(withNormalizedOffset:)``
- ``XCAppTest/XCTest/XCUIElement/drag(from:to:pressDuration:)``
- ``XCAppTest/XCTest/XCUIElement/press(forDuration:withNormalizedOffset:)``
- ``XCAppTest/XCTest/XCUIElement/pressWhenReady(forDuration:timeout:_:file:line:)``
- ``XCAppTest/XCTest/XCUIApplication/moveToBackground(_:)``

### Accessing properties of elements

- ``XCAppTest/XCTest/XCUIElement/stringValue``

### Accessing elements and other apps

- ``XCAppTest/XCTest/XCUIElementQuery/lastMatch``
- ``XCAppTest/XCTest/XCUIElementQuery/subscript(_:)``
- ``XCAppTest/XCTest/XCUIElementQuery/first(where:)``
- ``XCAppTest/XCTest/XCUIApplication/safari``
- ``XCAppTest/XCTest/XCUIApplication/springboard``
- ``XCAppTest/XCTest/XCUIApplication/messages``

### Checking foreground state

- ``XCAppTest/XCTest/XCUIApplication/assertIsInForeground(timeout:_:file:line:)``
- ``XCAppTest/XCTest/XCUIApplication/assertIsNotInForeground(timeout:_:file:line:)``
- ``XCAppTest/XCTest/XCUIApplication/assertIsInForeground(_:timeout:_:file:line:)``

### Checking number of elements

- ``XCAppTest/XCTest/XCUIElementQuery/assertHasCount(_:timeout:_:file:line:)-6w6h2``
- ``XCAppTest/XCTest/XCUIElementQuery/assertHasCount(_:timeout:_:file:line:)-1745l``

### Configuration

- ``XCAppTest/XCAppTestConfig``
- ``XCAppTest/XCAppTestConfig/defaultTimeout``

### Normalized offsets

- ``CoreFoundation/CGVector/topLeft``
- ``CoreFoundation/CGVector/top``
- ``CoreFoundation/CGVector/topRight``
- ``CoreFoundation/CGVector/left``
- ``CoreFoundation/CGVector/center``
- ``CoreFoundation/CGVector/right``
- ``CoreFoundation/CGVector/bottomLeft``
- ``CoreFoundation/CGVector/bottom``
- ``CoreFoundation/CGVector/bottomRight``
- ``CoreFoundation/CGVector/offset(x:y:)``
