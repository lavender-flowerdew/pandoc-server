#!/bin/bash

cd /usr/src/linux-headers-4.9.30/arch/x86/include/asm && \
h2ph -r -l . && \
cd /usr/src/linux-headers-4.9.30/arch/x86/include/generated && \
h2ph -r -l . && \
cd /usr/src/linux-headers-4.9.30/arch/x86/include/uapi && \
h2ph -r -l . && \
cd /usr/src/linux-headers-4.9.30/include/uapi && \
h2ph -r -l * && \
cd /usr/src/linux-headers-4.9.30/include/generated && \
h2ph -r -l * && \
cd /usr/src/linux-headers-4.9.30/include/asm-generic && \
h2ph -r -l * && \
echo "Built perl headers"
