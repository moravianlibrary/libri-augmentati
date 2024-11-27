# Libri augmentati

XProc 3.0 Libraries for Digital Books Download and Enrichment

This software downloads all available (or selected) data and metadata, like [MODS](https://www.loc.gov/standards/mods/), [FOXML](https://wiki.lyrasis.org/display/FEDORA/All+Documentation), [DC](https://www.dublincore.org/specifications/dublin-core/), [ALTO](https://www.loc.gov/standards/alto/), and images, from digital libraries based on the system [Kramerius](https://system-kramerius.cz) and stores it on the local system.

At this time, `Librari augmenti` only supports digital libraries provided by [Moravian Library in Brno](https://www.digitalniknihovna.cz/mzk "Digital library by Moravian Library in Brno") (Kramerius [version 7](https://github.com/ceskaexpedice/kramerius/wiki/Kramerius-REST-API-verze-7.0 "Wiki for Kramerius 7 Client API")) and [National Library](https://www.ndk.cz/ "Digital library by National Library") (Kramerius [version 5](https://github.com/ceskaexpedice/kramerius/wiki/ClientAPIDEV "Wiki for Kramerius 5 Client API")). Further libraries can be added to the [libraries.xml](src\settings\libraries.xml) settings file. See [registry](https://registr.digitalniknihovna.cz "Registry of the Kramerius systems") of all running instances of the Kramerius system.

## Prerequisites

- [Java 11](https://www.azul.com/downloads/?version=java-11-lts&package=jdk#zulu "Download Azul Zulu OpenJDK")
- [Saxon-HE 12.3](https://github.com/Saxonica/Saxon-HE/releases/tag/SaxonHE12-3 "Download SaxonHE12-3J")
- [MorganaXProc-IIIse 1.4.5](https://sourceforge.net/projects/morganaxproc-iiise/files/MorganaXProc-IIIse-1.4.5/ "Donwload MorganaXProc-IIIse 1.4.5")

### TODO list

- [ ] Install Java JDK 11
- [ ] Extract content of the [MorganaXProc-IIIse-1.4.5.zip](https://sourceforge.net/projects/morganaxproc-iiise/files/MorganaXProc-IIIse-1.4.5/MorganaXProc-IIIse-1.4.5.zip/download "Donwload MorganaXProc-IIIse 1.4.5.zip file")
- [ ] Extract content of the [SaxonHE12-3J.zip](https://github.com/Saxonica/Saxon-HE/releases/download/SaxonHE12-3/SaxonHE12-3J.zip "Download SaxonHE12-3J") file
  - [ ]  copy extracted `saxon-he-12.3.jar` and `saxon-he-xqj-12.3.jar` files to the `MorganaXProc-IIIse_lib` folder
- [ ] On your operating system, set environment PATH variable to point to the location of the `MorganaXProc-IIIse` folder
- for example on Windows:
  - (run command line as administrator): `setx /m PATH "%PATH%;C:\Programs\MorganaXProc-IIIse"`
  - (run command line as usual user): `setx PATH "%PATH%;C:\Programs\MorganaXProc-IIIse"`

## How to use it

Run command from the [run](run) folder

- [sample-book.cmd](run/sample-book.cmd) uses [sample-book.xpl](src/tests/xproc/sample-book.xpl) pipeline for downloading and processing [digital book](https://www.digitalniknihovna.cz/mzk/view/uuid:de87a0e0-643b-11ea-a744-005056827e51) from Moravian Library in Brno.
- in the [client.cmd](run/client.cmd) file you can set parameters of the book to be processed; this batch file uses [client.xpl](src/tests/xproc/client.xpl) pipeline
- in the [client-mzk.cmd](run/client-mzk.cmd) file change `-option:document-id` and `-option:nickname` argument and download (meta)data from Moravian Library in Brno
- in the [client-nkp.cmd](run/client-nkp.cmd) file change `-option:document-id` and `-option:nickname` argument and download (meta)data from National Library
