# P-Certificate Standard-1: Certificate

Basic specifications of P-Certificate.

## Structure

P-Certificate can be divided into three major sections:

1. Header
2. Data
3. Signature

Those sections just divided to be easy to understand, and **NOT** 
divided in the certificate.

## Header

In this section, those informations must be provided.

|Label    |Type       |Definition                |
|---------|-----------|--------------------------|
|`version`|`Version`  |Version of the certificate.|
|`algorithm`|`Algorithm`|Specifies the encryption algorithm used by the certificate.|

Version stores the semantic version name.

- Note: Semantic version name looks like `1.0.0` and it's sorted by major 
version, minor version and patch version. For more information about 
semantic versioning, see the article on [semver.org](https://semver.org).

## Data

The data section can also be subdivided into four sections:

1. Issuer informations
2. Certificate subject informations
3. Certificate informations
4. Extended informations

### Issuer Information

Issuer informations must have those information below

|Label|Type|Definition|
|-----|----|----------|
|`issuerName`|`String`|Issuer Name|
|`issuerID`|`UUID`|Issuer unique identifier|
|`issuerDomain`|`Domain`|Issuer domain|

### Certificate subject Informations

Certificate subject informations must have those information below

|Label|Type|Definition|
|-----|----|----------|
|`subjectName`|`String`|Certificate subject name|
|`subjectID`|`UUID`|Certificate subject identifier|
|`subjectDomain`|`Domain`|Certificate subject  domain|

- Important: When the issuer is exactly equal to the certificate subject, 
the certificate is considered the root certificate.

### Certificate informations

Certificate informations must have those information below

|Label|Type|Definition|
|-----|----|----------|
|`name`|`String`|Certificate name|
|`id`|`UUID`|Certificate unique identifier|
|`domain`|`Domain`|Certificate domain|
|`publicKey`|`PublicKey`|Subject's public key|
|`notValidBefore`|`Date`|Certifiate valid date|
|`notValidAfter`|`Date`|Certificate expire date|

- Important: The `Domain` above are all **inverse domain**, and have 
no last domain specific.

### Extended informations

All the extended information are storing in the `extension`. 
The extended information corresponds to the key value one by one.

- Note: The place of the `extension` are **fixed** and **important** in
the certificate, the type of the `extension` should be `List<(Domain, Value)>`.

### Extension Restriction

|Domain|Value|Definition|
|------|-----|----------|
|`x.cert.allowca`|`Bool`|Allow or not to use this certificate as CA.|
|`x.cert.pathlenght`|`UInt`|Max path length of this CA certificate can issue.|
|`x.cert.organization`|`String`|Organization name of this certificate.|
|`x.cert.country`|`String`|ISO-3166 country identifier.|

- Warning: The `x.cert` domain is reserved for P-Certificate and cannot be used for other types of tags except for certificate-related purposes.

## Signature

P-Certificate use SHA-512 digest algorithm to calculate the digest of the 
Header and the Data part of the certificate. Then use the private key of
the issuer to sign it and attach the signature after the certificate.

## Inverse Domain

All then domain appear in P-Certificate must be inversed. To use 
`www.example.com` as a example, the inverse version is `com.example.www`.

## JSON Representation

```json
{
    "version": "Version",
    "algorithm": "Algorithm",

    "issuerName": "String",
    "issuerID": "UUID",
    "issuerDomain": "Domain",
    "subjectName": "String",
    "subjectID": "UUID",
    "subjectDomain": "Domain",
    "name": "String",
    "id": "UUID",
    "domain": "Domain",
    "publicKey": "PublicKey",
    "notValidBefore": "Data",
    "notValidAfter": "Data"
    "extension": {...},

    "signature": "Signature"
}
```

---

## Standard Version
`1.0.0`

## See Also

- <doc:Standard-2-Key>
