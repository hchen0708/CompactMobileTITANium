def jwt_response_payload_handler(token, user=None, request=None):
    return {
        "token": token,
        "user": str(user.username),
        "active": user.is_active,
    }
