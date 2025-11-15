import anthropic
import pandas as pd
import os
import prompt as pt


user_prompt = pt.USER_PROMPT
key = os.getenv("ANTHROPIC_API_KEY")

client = anthropic.Anthropic(api_key=key)

messages = [{"role":"user", "content": user_prompt}]

message = client.messages.create(
    model='claude-sonnet-4-5',
    max_tokens=1000,
    messages=messages
)

print(message.content[0].text)




