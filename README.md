# poc-nin-contact-trie

# Contact Management System - Nim Trie PoC

This project demonstrates a practical implementation of a **Trie (Prefix Tree)** data structure in the Nim programming language. It is designed to store and retrieve contact information (User IDs) with high performance.

## 1. Domain Logic (`contact_trie.nim`)

The core logic handles the mapping of alphabetical names to numeric User IDs. Each node represents a character, allowing for `$O(L)$` lookups, where `$L$` is the length of the name.

## 2. Test Suite (test_contact_trie.nim)

The test suite validates the integrity of the data structure, ensuring that exact matches are found, prefixes are not incorrectly identified as full names, and IDs can be updated.

## How to Run
Ensure you have the Nim compiler installed.

Keep both files in the same directory (or adjust the import path).

Execute the test file using the command:

```
nim r test_contact_trie.nim
```
## Tree Effect

```plaintext
          [Root]
            |
           (i)  <-- Shared by all
          /   \
        (c)   (d) <-- Here it branches out!
         |     |
        (a)   (e)
         |     |
        (r)   (l)
         |     |
        (o)   (f) ... (idelfonso)
         |
      [isContact: true, ID: 1] ("icaro" It ends here.)
         |
        (s)
         |
      [isContact: true, ID: 2] ("icaros" It ends here.)
```
