//
//  View.swift
//  ExtendedSwift
//
//  Created by Pedro Cavaleiro on 11/05/2025.
//

import SwiftUI
import LocalAuthentication
#if canImport(UIKit)
import UIKit
#endif

/// A collection of extensions for the View type
extension View {
    
    /// Gets wether the device has biometrics available
    /// - Returns: A boolean indicating whether biometrics are available
    public var hasBiometricsAvailable: Bool { return biometricsAvailable() }
    
    /// Gets wether the deivce has FaceID or not
    /// It's not possible to determine if a simulator or preview has FaceID (check comment inside function)
    /// - Returns: A boolean indicating whether FaceID is available
    public var hasFaceID: Bool {
        let context = LAContext()
        
        // On a simulator or preview it's not possible to determine if the FaceID is available
        // This is a way to force "hasFaceID" to return the value for simulators and previews
        // Set to false if you want a device without FaceID, set it true for a FaceID device
        if isRunningOnSimulator || runningAsPreview {
            return true
        }

        return context.biometryType == .faceID
    }
    
    #if canImport(UIKit)
    /// Gets the user interface idiom (iphone or ipad)
    /// - Returns: The UIUserInterfaceIdiom of the current device
    public var idiom : UIUserInterfaceIdiom { UIDevice.current.userInterfaceIdiom }
    #endif
        
    /// Gets wether the app is running in a XCode preview or not
    /// - Returns: A boolean indicating whether the app is running in a XCode preview
    public var runningAsPreview: Bool {
        return ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] == "1" ? true : false
    }

    /// Gets wether the app is running in a sumulator or real device
    /// - Returns: A boolean indicating whether the app is running in a simulator
    public var isRunningOnSimulator: Bool {
        #if targetEnvironment(simulator)
        return true
        #else
        return false
        #endif
    }
    
    #if canImport(UIKit)
    /// Observes the change in the color scheme from a SwiftUI view
    /// - Parameter onChange: Function to execute when the color changes (sends the new ColorScheme)
    /// - Returns: A modified view that observes the color scheme changes
    @available(iOS 17.0, *)
    public func observeColorScheme(onChange: @escaping (ColorScheme) -> Void) -> some View {
        self.modifier(ColorSchemeObserver(onChange: onChange))
    }

    /// Gets the safeArea for the view
    /// This allows to be accessible from the View struct
    ///
    /// - Returns: UIEdgeInsets for the safe area
    public func safeArea() -> UIEdgeInsets {
        guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            return .zero
        }
        guard let safeArea = screen.windows.first?.safeAreaInsets else {
            return .zero
        }
        return safeArea
    }
       
    /// Gets the bounds of the window
    ///
    /// - Returns: CGRect for the bounds
    public func getRect() -> CGRect {
        guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            return .zero
        }
        guard let window = screen.windows.first else {
            return .zero
        }

        return window.bounds
    }
    
    /// Hides the keyboard
    public func hideKeyboard() {
        DispatchQueue.main.async {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
    }
    #endif
    
    /// Registers the keyboard visibility in the Environment
    ///
    /// - Returns: The modified view
    public func addKeyboardVisibilityToEnvironment() -> some View {
        modifier(KeyboardVisibility())
    }

    /// Applies a padding to both vertical and horizontal
    ///
    /// - Parameters:
    ///    - horizontal: The horizontal padding
    ///    - vertical: The vertical padding
    ///
    /// - Returns: The modified view
    public func padding(_ horizontal: CGFloat, _ vertical: CGFloat) -> some View {
        self.padding(.horizontal, horizontal)
            .padding(.vertical, vertical)
    }

    /// Executes a if statement on render allowing to modify the component
    ///
    /// - Parameters:
    ///   - conditional: The boolean condition
    ///   - content: The content to modify
    /// - Returns: A TupleView containing the original view and the modified content if the condition is true
    public func `if`<Content: View>(_ conditional: Bool, content: (Self) -> Content) -> TupleView<(Self?, Content?)> {
        if conditional {
            return TupleView((nil, content(self)))
        } else {
            return TupleView((self, nil))
        }
    }

    /// Executes a action on render, it will run if the view is re-rendered
    /// - Parameters:
    ///   - action: The action to execute
    /// - Returns: The view itself, allowing for chaining
    public func `exec`(action: @escaping (() -> ())) -> (Self?) {
        action()
        return self
    }
    
    /// No different than *onAppear* but helps to decide that is a "initial load" action
    /// - Parameter loadAction: The action to execute when the view appears
    /// - Returns: The view itself, allowing for chaining
    public func onLoad(run loadAction: @escaping () -> Void) -> some View {
        self
            .onAppear {
                loadAction()
            }
    }

    /// Allows adding a placeholder (text in the middle of the List) to a SwiftUI List
    /// - Parameters:
    ///  - showPlaceholder: When to show the placeholder
    ///  - placeholder: The SwiftUI for the placeholder
    /// - Returns: The view with the `PlaceholderModifier` applied
    public func placeholder<Placeholder: View>(
        when showPlaceholder: Bool,
        @ViewBuilder placeholder: @escaping () -> Placeholder
    ) -> some View {
        self.modifier(PlaceholderModifier(showPlaceholder: showPlaceholder, placeholder: placeholder))
    }
    
    #if canImport(UIKit)
    /// Adds an offset to the view based on a binding value
    /// - Parameter offset: A binding to a CGFloat that will be used to set the offset
    /// - Returns: The view with the offset applied
    @available(iOS 15.0, *)
    public func offset(offset: Binding<CGFloat>) -> some View {
        return self
            .overlay {
                GeometryReader { proxy in
                    let minY = proxy.frame(in: .named("SCROLL")).minY
                    Color.clear.preference(key: ScrollOffsetPreferenceKey.self, value: minY)
                }
                .onPreferenceChange(ScrollOffsetPreferenceKey.self, perform: { value in
                    offset.wrappedValue = value
                })
            }
    }
    #endif

}
