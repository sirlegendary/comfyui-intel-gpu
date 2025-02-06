FROM ghcr.io/sirlegendary/intel-ai-base-ubuntu22.04:latest

# Install Intel Extension for PyTorch
RUN python -m pip install torch==2.5.1+cxx11.abi torchvision==0.20.1+cxx11.abi torchaudio==2.5.1+cxx11.abi \
    intel-extension-for-pytorch==2.5.10+xpu oneccl_bind_pt==2.5.0+xpu \
    --extra-index-url https://pytorch-extension.intel.com/release-whl/stable/xpu/us/

## check installation
RUN python -c "import torch; import intel_extension_for_pytorch as ipex; print(torch.__version__); print(ipex.__version__); [print(f'[{i}]: {torch.xpu.get_device_properties(i)}') for i in range(torch.xpu.device_count())];"

RUN git clone https://github.com/comfyanonymous/ComfyUI.git

WORKDIR /ComfyUI

RUN python -m pip install -r requirements.txt

CMD ["python", "main.py"]