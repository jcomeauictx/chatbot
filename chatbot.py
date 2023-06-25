#!/usr/bin/python3 -OO
'''
From https://beebom.com/how-build-own-ai-chatbot-with-chatgpt-api/
'''
import netrc, logging
import openai
import gradio as gr
logging.basicConfig(level=logging.DEBUG if __debug__ else logging.WARN)

openai.api_key = netrc.netrc().authenticators('platform.openai.com')[2]
logging.debug('key: %r', openai.api_key)

messages = [
    {"role": "system", "content": "You are a helpful and kind AI Assistant."},
]

def chatbot(input):
    if input:
        messages.append({"role": "user", "content": input})
        chat = openai.ChatCompletion.create(
            model="gpt-3.5-turbo", messages=messages
        )
        reply = chat.choices[0].message.content
        messages.append({"role": "assistant", "content": reply})
        return reply

inputs = gr.inputs.Textbox(lines=7, label="Chat with AI")
outputs = gr.outputs.Textbox(label="Reply")

gr.Interface(fn=chatbot, inputs=inputs, outputs=outputs, title="AI Chatbot",
             description="Ask anything you want",
             theme="compact").launch(share=True)
