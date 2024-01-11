Marker Extractor v0.0.1 - Pesterenan
====================================

>_For English version, see below._

Esse pequeno script de automação busca facilitar um processo que eu evitava fazer.
Buscar os `Markers` colocados num projeto pelo Davinci Resolve, que ao ser renderizado
transforma esses Markers em capítulos dentro do arquivo de vídeo.

Durante a edição de vídeo você pode adicionar marcadores já com o texto que irá dar nome
aos capítulos na descrição do vídeo no YouTube. Esses marcadores ficam nos metadados do vídeo,
e esse script extrai eles junto com o momento no vídeo (time stamp) num arquivo de texto.

Como usar:
----------
Após o vídeo ser renderizado, rode esse script num shell que suporte os `coreutils` como `grep`,
`awk` e outros.
É necessário ter o `ffprobe` instalado no sistema, e que ele esteja no PATH para poder ser iniciado.

```bash
./extract.sh <caminho_para_o_arquivo.mp4>
```
O script extrai os capítulos, o caminho de pasta, e o nome, e gera um arquivo `.txt` no mesmo
caminho com o mesmo nome do vídeo.

English:
--------
This little automation script seeks to ease up a process that I avoided doing.
Getting the `Markers` put into a in Davinci Resolve project, that when rendered, transforms these
Markers into chapters inside the video file.

While editing a video, you can add markers with the text that will name the chapters into the
description of an YouTube video. These markers stay in the video's metadata, and this script
extract them together with the time stamp into a text file.

How to use:
-----------
After the video is rendered, run this script in a shell that supports the `coreutils` like `grep`,
`awk` and others.
It's required to have `ffprobe installed in the system, and that it is in the system's PATH to work.

```bash
./extract.sh <caminho_para_o_arquivo.mp4>
```
The script extracts the chapters, the file path, the name, and generates a `.txt` file in the same
path with the same name as the video file.
