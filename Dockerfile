From ubuntu

Env LANG en_US.UTF-8 LC_ALL=en_US.UTF-8
Run ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
Workdir /home
Run yes | apt update
Run yes | apt install python3 python3-pip
Run yes | apt install wget cmake gcc g++ 
Run yes | apt install libxml2 libxslt1-dev
Run yes | apt install libmagic-dev 
#poppler tesseract

Run pip3 install jupyter
Run pip3 install langchain openai kor
Run pip3 install google-search-results
# models
#Run pip3 install pygpt4all ?
Run pip3 install huggingface_hub 
Run pip3 install transformers
# index document loaders 
Run pip3 install pandas 
Run pip3 install pypdf pdfminer pdf2image pytesseract
Run pip3 install  unstructured
#Run pip3 install bilibili-api
Run pip3 install beautifulsoup4
# index.vectorstores
#Run pip3 install chromadb ?
Run pip3 install elasticsearch pinecone-client redis
# agent.tools
Run pip3 install gradio_tools wikipedia wolframalpha

#other
Run pip3 install tiktoken

Run apt install sqlite3
Run pip3 install tabulate
Run pip3 install redis faiss-cpu
Run pip3 install tqdm

Run yes | apt install poppler-utils tesseract-ocr

Cmd ["jupyter","notebook","--ip=0.0.0.0","--port=8888","--allow-root"]