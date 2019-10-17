import Foundation
import GoogleSignIn.GIDSignIn

/// Setup and Handle Google Signin and Associted Methods
final class GoogleSignInService {
    // MARK: - Attributes -
    fileprivate static let delegate = GoogleSignInServiceDelegate()
    static var signInEvent: Events<GIDGoogleUser?> = Events<GIDGoogleUser?>()

    // MARK: - Methods -
    /// Configure Google Signin.
    static func prepareToLaunch() {
        GIDSignIn.sharedInstance().clientID = Configrations.GoogleSignIn.clientID
        GIDSignIn.sharedInstance().delegate = delegate
        GIDSignIn.sharedInstance().scopes = Configrations.GoogleSignIn.scopes
    }

    static func currentUser() -> GIDGoogleUser! {
        return GIDSignIn.sharedInstance().currentUser
    }

    /// Google Singin
    static func signIn() {
        GIDSignIn.sharedInstance().signIn()
    }

    static func signInSilently() {
        GIDSignIn.sharedInstance().signInSilently()
    }

    /// Google Singout
    static func signOut() {
        GIDSignIn.sharedInstance().signOut()
    }

    /// Handle Url Use in Appdelegate Open URL Method.
    ///
    /// - Parameters:
    ///   - url: url
    ///   - options: options
    /// - Returns: Bool
    static func handle(url: URL, options: [UIApplication.OpenURLOptionsKey: Any]) -> Bool {
        return GIDSignIn.sharedInstance().handle(url, sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String, annotation: [:])
    }
}

// MARK: - GIDSignInDelegate -
final class GoogleSignInServiceDelegate: NSObject, GIDSignInDelegate {
    func sign(_: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError _: Error!) {
        GoogleSigninManager.signInEvent.raise(data: user)
    }
}
