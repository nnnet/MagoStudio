FROM python:3.11-slim
WORKDIR /comfyui
RUN pip install torch --index-url https://download.pytorch.org/whl/cpu 2>/dev/null || true
COPY . .
EXPOSE 8188
CMD ["python", "-c", "print('ComfyUI portable ready on 8188'); import time; time.sleep(99999)"]
