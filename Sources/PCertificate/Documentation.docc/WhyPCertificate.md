# Why P-Certificate?

Why should we use P-Certificate instead of traditional X.509 certificates.

## We're on different sides

In the traditional X.509 certificate, we use a variety of signature 
algorithms to ensure the uniqueness of the certificate, and the 
versions of various algorithms are not conducive to the management and 
integration of development engineers.

In addition, a large number of additional information and restrictions 
on the use of certificates make the purpose and standard of 
certificates unclear, and a large number of information and 
serialization costs make the production and management costs of 
certificates expensive.

The goal of P-Certificate is not to replace X.509 certificates, but to 
create a fast and efficient certificate system. Our goal has never been 
the foundation of the Internet, but user authentication at the software 
level.

Through P-Certificate, each user can obtain a unique certificate to ensure 
the uniqueness of the identity. The production cost of P-Certificate is 
extremely low, but the security is not sacrificed, which makes 
P-Certificate an excellent choice for lightweight user identity 
authentication management.

## We're the most efficient

In traditional X.509 certificates, each certificate serialization and 
deserialization takes a lot of time and energy, and its management is not 
easy because of the complexity of the certificate chain behind it.

P-Certificate uses Protocol Buffer instead of ASN.1 serialization 
algorithm to improve the original serialization speed. At the same time, 
as a declarative serialization system, Protocol Buffer can be used to make 
each certificate organized using a standard template.

## We focus on different areas

In the X.509 certificate, it focuses on the basic trust facilities of the 
Internet, which requires it to be compatible with a large number of 
Internet facilities in order for the global Internet to operate normally.

P-Certificate focuses on identity trust settings in proprietary systems, 
and different certificate versions will not affect the global 
P-Certificate system. At the same time, minimal management costs and 
almost negligible certificate costs allow P-Certificate to cover every 
user. When the P-Certificage certificate is stored on the server side, a 
large amount of server storage space can be saved because of the special 
serialization rules of the Protocol Buffer.

## Last but not least, we are easy to use

P-Certificate does not require development engineers to build a complex 
system to run it. Instead, it only needs to use the P-Certificate code 
base to issue and manage certificates. Everything is so easy!
