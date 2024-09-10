import sys
import jwt  # PyJWT library
import json

if len(sys.argv) < 2:
    print("Please provide a JWT token as a command-line argument.")
    sys.exit(1)

token = sys.argv[1]

try:
    decoded_token = jwt.decode(token, options={"verify_signature": False})
    print(json.dumps(decoded_token))
except jwt.DecodeError as e:
    print(f"Failed to decode token: {e}")

