# voice-of-god
Voice of God for Urbit - Inspired by TempleOS

1. Retrieves a random number from the NIST randomness beacon
2. Derives 16 line numbers from it
3. Grabs those lines from the TempleOS god's wordlist
4. Composes a sentence
5. Posts it to the specified chat channel

# Installation
1. In the dojo run `|mount %`
2. From unix add `nist.hoon` to `sur`, `god.hoon` to `ted` and `vocab.txt` to the root of your `%home` desk
3. Run `|commit %home` in the dojo

# Usage
From the dojo run `-god ~sampel-palnet %some-channel` to post a message there.
