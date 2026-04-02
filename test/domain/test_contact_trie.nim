import contact_trie

proc runTests() =
  let agenda = newContactTrie()

  # 1. Testing the insertion of multiple contacts
  agenda.addContact("alice", 101)
  agenda.addContact("bob", 202)
  agenda.addContact("alicia", 303)

  # 2. Validating exact searches
  assert agenda.getContactId("alice") == 101
  assert agenda.getContactId("bob") == 202
  assert agenda.getContactId("alicia") == 303

  # 3. Testing for names that do not exist
  assert agenda.getContactId("charlie") == -1

  # 4. Testing prefixes that are NOT complete contacts
  assert agenda.getContactId("ali") == -1

  # 5. Overwriting/Updating a contact
  agenda.addContact("alice", 999)
  assert agenda.getContactId("alice") == 999

  echo "-----------------------------------"
  echo " All the tests on the Agenda passed!
  echo "-----------------------------------"

runTests()