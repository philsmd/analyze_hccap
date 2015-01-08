# About

The goal of this project is to make the content of a hashcat .hccap file human-readable.
The format of these files is defined here: https://hashcat.net/wiki/doku.php?id=hccap

# Requirements

Software:  
- Perl must be installed (should work on *nix and windows with perl installed)


# Installation and First Steps

* Clone this repository:  
    git clone https://github.com/philsmd/analyze_hccap.git  
* Enter the repository root folder:
    cd analyze_hccap
* Get a test hccap file (e.g):
    wget http://hashcat.net/misc/example_hashes/hashcat.hccap
* Run it:  
    ./analyze_hccap.pl hashcat.hccap
* Check output

There is a second (optional) parameter. It works like a filter and allows you to specify
which of the networks you want to display.
For instance if a .hccap file has 4 networks in it (i.e. it could be splitted in 4 single
.hccap files), you can display the single networks like this:  
  ./analyze_hccap.pl multi.hccap 2,3  
  

By doing so only the second and third network are shown (out of 4).
It is a comma-separated list. Single networks can also be filtered, for instance:    
  ./analyze_hccap.pl mutli.hccap 1  
will show only the first network
 
# Hacking

* More features
* CLEANUP the code, use more coding standards, everything is welcome (submit patches!)
* all bug fixes are welcome
* guaranty cross-plattformness
* testing with different kinds of hccap files
* solve and remove the TODOs
* and,and,and

# Credits and Contributors 
Credits go to:  
  
* philsmd, hashcat project

# License/Disclaimer

License: belongs to the PUBLIC DOMAIN, donated to hashcat, credits MUST go to hashcat and philsmd for their hard work. Thx
Disclaimer: WE PROVIDE THE PROGRAM “AS IS” WITHOUT WARRANTY OF ANY KIND, EITHER EXPRESSED OR IMPLIED, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE Furthermore, NO GUARANTEES THAT IT WORKS FOR YOU AND WORKS CORRECTLY
