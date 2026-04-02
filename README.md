# poc-nin-contact-trie

# Contact Management System - Nim Trie PoC

This project demonstrates a practical implementation of a **Trie (Prefix Tree)** data structure in the Nim programming language. It is designed to store and retrieve contact information (User IDs) with high performance.

## 1. Domain Logic (`contact_trie.nim`)

The core logic handles the mapping of alphabetical names to numeric User IDs. Each node represents a character, allowing for `$O(L)$` lookups, where `$L$` is the length of the name.

```nim
type
  ContactNode* = ref object
    children*: array[26, ContactNode]
    userId*: int # 0 if not a terminal node, > 0 if it stores a contact
    isContact*: bool

  ContactTrie* = ref object
    root*: ContactNode

proc newContactNode(): ContactNode =
  ContactNode(isContact: false, userId: 0)

proc newContactTrie*(): ContactTrie =
  ContactTrie(root: newContactNode())

proc charIndex(c: char): int =
  ## Converts a character 'a'-'z' to an index 0-25
  ord(c) - ord('a')

proc addContact*(t: ContactTrie, name: string, id: int) =
  ## Inserts a name into the trie and associates it with a User ID
  var node = t.root
  for c in name:
    let idx = charIndex(c)
    if node.children[idx] == nil:
      node.children[idx] = newContactNode()
    node = node.children[idx]
  node.isContact = true
  node.userId = id

proc getContactId*(t: ContactTrie, name: string): int =
  ## Searches for a name. Returns the User ID or -1 if not found.
  var node = t.root
  for c in name:
    let idx = charIndex(c)
    if node.children[idx] == nil:
      return -1
    node = node.children[idx]

if node.isContact:
    return node.userId
  else:
    return -1

```

## 2. Test Suite (test_contact_trie.nim)

The test suite validates the integrity of the data structure, ensuring that exact matches are found, prefixes are not incorrectly identified as full names, and IDs can be updated.

## How to Run
Ensure you have the Nim compiler installed.

Keep both files in the same directory (or adjust the import path).

Execute the test file using the command:

```
nim r test_contact_trie.nim
```
