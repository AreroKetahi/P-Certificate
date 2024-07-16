# P-Certificate Standard-2: Key

Basic specifications of P-Certificate Key.

## Structure

P-KeyPair can be divided into three part:

1. Header
2. Content
3. Footer

Those sections just divided to be easy to understand, and **NOT** 
divided in the key document.

## Header

In this section, those informations must be provided.

|Label    |Type     |Definition             |
|---------|---------|-----------------------|
|`version`|`Version`|Version of the key file|
|`algorithm`|`String`|The algorithm that this key use|
|`keySize`|`Int`|The key size that the alogrithm use in bits, `0` if this algorithm use fixed key size|
|`symmetry`|`Bool`|`true` if the algorithm is symmetrical algorithm, otherwise `false`|
|`transparency`|`Transparency`|`private` if the key is private key, `public` for public key. For symmetrical algorithm, this value should always be `private`|

Version stores the semantic version name.

- Note: Semantic version name looks like `1.0.0` and it's sorted by major 
version, minor version and patch version. For more information about 
semantic versioning, see the article on [semver.org](https://semver.org).

## Data

The data section store the binary key value, and labeled with key `content` using `Data` type.

## Footer

The footer have following informations.

|Label|Type|Definition|
|-----|----|----------|
|`digest`|`Digest`|SHA256 digest of the key|
|`id`|`UUID`|The identifier of the key|

---

## Standard Version
`1.0.0`

## See Also

- <doc:Standard-1-Certificate>
