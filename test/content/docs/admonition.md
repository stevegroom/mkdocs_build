# Admonition markdown extension

The admonition markdown extension offers simple, highly stylized boxes for inline content.

## Syntax

Start the line with three explication marks and indent all subsequent paragraphs with four spaces. To replace the standard name, add a text after it enclosed in double-quotes.

```text
!!! Alert "Look out!"
    This is a quick way to highlight key texts in a document.
```

renders:

!!! Alert "Look out!"
    This is a quick way to highlight key texts in a document.

```text
syntax:

!!! keyword ["optional title"]
    Indented content

    over several lines

keywords [ note or seealso ]
         [ abstract, summary or tldr ]
         [ info or todo ]
         [ tip, hint or important ]
         [ success, check or done ]
         [ question, help or faq ]
         [ warning, caution or attention ]
         [ failure, fail or missing ]
         [ danger, error ]
         [ bug ]
         [ example or snippet ]
         [ quote or cite ]

Set [optional keyword] = "" to suppress the header bar.
```

## Examples of Admonition Stylizing

!!! Note
    This is a note

    Continued to two paragraphs

!!! Abstract
    This is an abstract

!!! Info
    Info panel

!!! Tip
    Remember to ....

!!! Warning

!!! Success

!!! Failure

!!! Question
    Did you understand this section?

!!! danger "Do not try this at home"
    Really don't!

!!! Bug
    There is a known bug

!!! Example
    You can put an example here too

!!! Quote "Eating our own dog food" 
    *1988 Paul Maritz Microsoft*

!!! note ""
    Custom note without header bar
