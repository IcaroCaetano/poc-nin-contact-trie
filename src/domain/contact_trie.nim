type
  # Defines an individual node in the prefix tree (Trie)
  ContactNode* = ref object
    children*: array[26, ContactNode] # Array representing 26 letters (a-z)
    userId*: int                      # Stores the ID; 0 if not a terminal node, > 0 if it is
    isContact*: bool                  # Flag to mark the end of a valid contact name

  # Main wrapper structure for the Trie starting from a root
  ContactTrie* = ref object
    root*: ContactNode

# Constructor for a new node with default "empty" values
proc newContactNode(): ContactNode =
  ContactNode(isContact: false, userId: 0)

# Constructor for the Trie, initializing the root node
proc newContactTrie*(): ContactTrie =
  ContactTrie(root: newContactNode())

# Helper to map characters 'a'-'z' to array indices 0-25
proc charIndex(c: char): int =
  ord(c) - ord('a')

# Inserts a name into the Trie and links it to a user ID
proc addContact*(t: ContactTrie, name: string, id: int) =
  var node = t.root                   # Start traversal from the root
  for c in name:                      # Iterate through each character in the string
    let idx = charIndex(c)            # Get the index for the current character
    if node.children[idx] == nil:     # If the path for this letter doesn't exist...
      node.children[idx] = newContactNode() # ...instantiate a new node
    node = node.children[idx]         # Move the pointer to the child node
  node.isContact = true               # Mark this node as the end of a contact
  node.userId = id                    # Store the associated user ID

# Searches for a contact by name and returns its ID
proc getContactId*(t: ContactTrie, name: string): int =
  var node = t.root                   # Start searching from the root
  for c in name:                      # Follow the path of the name character by character
    let idx = charIndex(c)            # Calculate the index
    if node.children[idx] == nil:     # If a character's path is missing...
      return -1                       # ...the contact is not in the tree
    node = node.children[idx]         # Move deeper into the tree
  
  if node.isContact:                  # Check if the final node represents a complete contact
    return node.userId                # Return the found ID
  else:
    return -1                         # Return -1 if the name is just a prefix of another name
