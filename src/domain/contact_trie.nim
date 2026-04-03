type
  ContactNode* = ref object
    children*: array[26, ContactNode]
    userId*: int # 0 if it's not the end of a word, > 0 if it's a contact.
    isContact*: bool

  ContactTrie* = ref object
    root*: ContactNode

proc newContactNode(): ContactNode =
  ContactNode(isContact: false, userId: 0)

proc newContactTrie*(): ContactTrie =
  ContactTrie(root: newContactNode())

proc charIndex(c: char): int =
  ord(c) - ord('a')

# Enter a name and associate a user ID.
proc addContact*(t: ContactTrie, name: string, id: int) =
  var node = t.root
  for c in name:
    let idx = charIndex(c)
    if node.children[idx] == nil:
      node.children[idx] = newContactNode()
    node = node.children[idx]
  node.isContact = true
  node.userId = id

# Searches for a contact and returns the ID (or -1 if not found).
proc getContactId*(t: ContactTrie, name: string): int =
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
