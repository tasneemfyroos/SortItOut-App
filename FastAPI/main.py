from fastapi import FastAPI, File, UploadFile
from fastapi.responses import HTMLResponse, StreamingResponse
from typing import Annotated
from fastapi.middleware.cors import CORSMiddleware

# from PIL import Image
import io
from convnext_model import showPred
from BinMap import binMap

app = FastAPI()

@app.post("/")
async def main(file: UploadFile = File(...)):
    # Read the file contents as bytes
    image_contents = await file.read()
    category = showPred(image_contents)
    return binMap[category]
