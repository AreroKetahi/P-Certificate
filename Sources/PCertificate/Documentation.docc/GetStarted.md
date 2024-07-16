# Get Started With P-Certificate

Initialize P-Certificate in you application now!

## Overview

In this article, you will learn how to intergrate P-Certificate in to
your current project.

### Before we start...

The scope of application of P-Certificate has certain limitations, 
before using, please make sure that your application scope is within 
the following scope.

1. Usage scope that is not compatible with infrastructure certificates 
such as X.509.

2. Usage scope that lightweight and provided for individual users or 
small groups.

### Preparatory work

Before you create the certificate, you have to create a root certificate.

Root certificate is the begin point of the certificate chain, it managed all the certificates, which means that **the expiration of root certificate may cause all the certificate chain unreliable**.

Before we start, we need to make a ``Target`` first. Target store target's name, target's  and it related ``Domain``.

- Note: We are highly suggest you don't put any whitespace in the target name. Because the full version of the domain will attach target name at the back. It may looks a little weird, like `com.example.John Appleseed`.

```swift
let subject = Target(name: "Root", id: UUID(), domain: "com.example")
```

Then, we should choose a asymmetric encryption algorithm as default, and create a key pair. In here, we use X25519 as example.

```swift
let privateKey = Curve25519.Signing.PrivateKey()
let publicKey = privateKey.publicKey
```

### Create Root Certificate

Now, we can create a certificate.

```swift
let certificate = Certificate(
    version: .v1,
    issuerTarget: subject,
    subjectTarget: subject,
    name: "Root-CA", 
    id: UUID(),
    domain: "com.example",
    publicKey: publicKey,
    notValidBefore: .now,
    notValidAfter: (.now + 604800)
)
```

This is a certificate creation example for a 1 week certificate, in the actual usage, it must be longer than 1 week, even longer than 10 years.

- Tip: As a root certificate, its characteristic is that the principal and issuer are the same person, and use their own private key to sign. Therefore, the root certificate is also called a self-signed certificate.

If you don't want to do too much preparatory works, you can use ``Certificate/init(version:issuerName:issuerID:issuerDomain:subjectName:subjectID:subjectDomain:name:id:domain:publicKey:notValidBefore:notValidAfter:extension:signature:)`` to customize everything.

Or use subscript (dot syntax) to initialize targets.

### Sign and export certificate

Now we have a certificate, it's time to publish it. Use ``Certificate/serialize(with:)`` to export certificate as binary format.

```swift
let binaryCert = certificate.serialize(with: privateKey)
```

Since now, everything was done! You can export this data as a binary document, and save it as suffix `.pcsr`.

