# References:
# - https://docs.micropython.org/en/latest/develop/gettingstarted.html
# - https://github.com/mcauser/BLACK_F407VE

FROM ubuntu:22.04

# Install dependencies
RUN apt update &&  apt install -y \
    vim \
    build-essential libffi-dev git pkg-config \
    gcc-arm-none-eabi binutils-arm-none-eabi libnewlib-arm-none-eabi \
    python3 \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

WORKDIR /root

RUN git clone https://github.com/micropython/micropython.git

WORKDIR /root/micropython

RUN git submodule update --init

RUN cd ports/stm32/boards && git clone https://github.com/mcauser/BLACK_F407VE.git

RUN cd /root/micropython/mpy-cross && make

RUN cd /root/micropython/ports/stm32 && make submodules && make BOARD=BLACK_F407VE
#COPY files/vimrc .vimrc

#RUN pip install xlsx2csv pandas openpyxl globus-cli

# Cleanup
#RUN rm globus-config.tgz get-data.sh
