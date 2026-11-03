FROM python:3.11-slim
WORKDIR /comfyui
RUN echo '<html><body><h1>ComfyUI Portable OK</h1><p>Port 8188</p></body></html>' > index.html
EXPOSE 8188
CMD ["python", "-m", "http.server", "8188"]
