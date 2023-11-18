from passlib.hash import sha512_crypt

hash = sha512_crypt.hash("test")

print(hash)

