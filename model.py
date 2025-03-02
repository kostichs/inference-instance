from fastapi import FastAPI
from pydantic import BaseModel
from vllm import LLM, SamplingParams

app = FastAPI()

# Загружаем модель один раз
llm = LLM(model="meta-llama/Llama-2-7b-chat-hf")

# Модель для стандартного запроса
class GenerateRequest(BaseModel):
    prompt: str
    temperature: float = 0.7
    top_p: float = 0.9

# Модель для OpenAI-стиля запроса
class Message(BaseModel):
    role: str
    content: str

class OpenAIRequest(BaseModel):
    model: str
    messages: list[Message]

@app.post("/generate")
def generate_text(request: GenerateRequest):
    sampling_params = SamplingParams(temperature=request.temperature, top_p=request.top_p)
    outputs = llm.generate([request.prompt], sampling_params)
    return {"response": outputs[0].text}

@app.post("/chat")
def chat(request: OpenAIRequest):
    # Берем последний user message
    prompt = next((msg.content for msg in request.messages if msg.role == "user"), None)
    if not prompt:
        return {"error": "No user message found"}

    # Генерация ответа
    sampling_params = SamplingParams(temperature=0.7, top_p=0.9)
    outputs = llm.generate([prompt], sampling_params)

    return {
        "role": "assistant",
        "content": outputs[0].text
    }
