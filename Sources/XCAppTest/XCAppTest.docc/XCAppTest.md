# ``XCAppTest``

Utilities for easier interaction with XCUITest methods

XCAppTests builds upon default XCUITest capabilities by introducing helper assertion methods and extensions. It allows you to create readable tests that are easy to write and offer detailed failure descriptions when tests fail.

Here is a short example from one of my apps that makes use of this library. In the test I am checking that it is possible to navigate to "Premium features" screen, verify that most important data is visible and check that it is possible to leave that screen.

Note that some of the buttons are identified by enum case instead of raw string. You can see <doc:TypeSafeIdentifiers> section to see how this is implemented.

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

## Customization

### Failure messages

All of the assertion functions have optional message as last parameter that can be used to configure what is displayed if assertion fails.

```swift
element.assertExists("My element should be visible")
```

### Timeouts

You can configure assertion timeout globally by modifying ``XCAppTestConfig/defaultTimeout`` property or per call via `timeout` parameter.

```swift
XCAppTestConfig.defaultTimeout = 3
element.assertExists(timeout: 3)
```

## Topics

- ``XCAppTest/XCTest/XCUIElement``
- ``XCAppTest/XCTest/XCUIElementQuery``
- ``XCAppTest/XCTest/XCUIApplication``
- ``XCAppTest/XCTest/XCTestCase``
- ``XCAppTest/CoreFoundation/CGVector``
- ``XCAppTest/XCAppTestConfig``

### Tips

- <doc:TypeSafeIdentifiers>
