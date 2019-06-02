# PlantUML

This Markdown plug-in locally renders UML into imbedded UML diagrams in the converted markdown files.

<http://plantuml.com/>

## Plantuml

A more fully featured, but needs to have a java process to generate the diagrams.

More info here: <http://plantuml.com/faq>.

!!! Success
    PlantUML default setup sends all diagrams to the internet for processing using HTTP - so not secure. For this a local server is used in VSCode as well as in the Azure Pipeline.

## Examples of PlantUML

Create this uml chart

```plantuml
skinparam componentStyle uml2

[User] - https


cloud "Cloud Foundry" {

    package "node.js apps" {
      [Frontend] - http
      http - [Backend]  
    }

    package "CF Services" {
      [XSUAA]  
    }

[Frontend] -d-> [XSUAA] : JWT
[Backend] <-u- [XSUAA] : JWT
}

component "IDP"
https -right-> [Frontend]
XSUAA -right-> [IDP] : SAML
```

Renders to this: when put between ```` ```plantuml```` code fences

```text
    ```plantuml
    skinparam componentStyle uml2

    [User] - https


    cloud "Cloud Foundry" {

        package "node.js apps" {
          [Frontend] - http
          http - [Backend]  
        }

        package "CF Services" {
          [XSUAA]  
        }

    [Frontend] -d-> [XSUAA] : JWT
    [Backend] <-u- [XSUAA] : JWT
    }

    component "IDP"
    https -right-> [Frontend]
    XSUAA -right-> [IDP] : SAML
    ```
```
