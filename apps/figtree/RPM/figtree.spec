Name:           FigTree
Version:        1.4.0
Release:        1%{?dist}
Summary: 	Graphical viewer of phylogenetic trees
URL:		http://tree.bio.ed.ac.uk/software/figtree/
Group:		Sciences/Biology
License:	Freeware
BuildRoot:	%{_tmppath}/%{name}-%{version}-buildroot
Source0:	%{name}_v%{version}.tar.xz
Requires:	java >= 1.5
BuildArch:	noarch

%description
FigTree is designed as a graphical viewer of phylogenetic trees and as a program for producing publication-ready figures.

%prep
%setup -q -n %{name}_v%{version}

%build

%install
rm -rf %{buildroot}
mkdir %{buildroot}
mkdir %{buildroot}/usr
mkdir %{buildroot}%{_datadir}
mkdir %{buildroot}%{_datadir}/%{name}_v%{version}
cp -R * %{buildroot}%{_datadir}/%{name}_v%{version}

# delete the bin directory in the source
# not needed is only a start script
rm -rf %{buildroot}%{_datadir}/%{name}_v%{version}/bin

# start script
mkdir -p %{buildroot}%{_bindir}
%__cat > figtree.sh <<EOF
#!/bin/bash
cd /usr/share/%{name}_v%{version}/lib
java -Xms64m -Xmx512m -jar figtree.jar $*
EOF
%__install -m 755 figtree.sh %{buildroot}%{_bindir}

chmod +x %{buildroot}%{_bindir}/figtree.sh
chmod +x %{buildroot}%{_datadir}/%{name}_v%{version}/lib/figtree.jar

# icon
mkdir -p %{buildroot}%{_datadir}/pixmaps
%__install -m 644 %{buildroot}%{_datadir}/%{name}_v%{version}/images/figtree.png %{buildroot}%{_datadir}/pixmaps/figtree.png

# menu-entry
mkdir -p %{buildroot}%{_datadir}/applications
cat > %{buildroot}%{_datadir}/applications/%{name}.desktop << EOF
[Desktop Entry]
Name=FigTree
Comment=Graphical viewer of phylogenetic trees
GenericName=FigTree
Type=Application
Terminal=false
Exec=figtree.sh
Icon=figtree
Encoding=UTF-8
Categories=Science;Bioinformatics;
EOF

%clean
rm -rf %{buildroot}

%post

%files
%defattr(-,root,root)
%doc README.txt
%{_bindir}/figtree.sh
%{_datadir}/%{name}_v%{version}
%{_datadir}/applications/%{name}.desktop
%{_datadir}/pixmaps/figtree*.png

%changelog
* Fri Dec 20 2013 Shane Sturrock <shane@biomatters.com> 1.4.0-1
- Initial import into NZGL

* Sun Jun 09 2013 ghostbunny <hmhaase at pclinuxosusers dot de> 1.4.0-1pclos2013
- 1.4.0

* Sat Jan 28 2012 Neal <nealbrks0 at gmail dot com> 1.3.1-1pclos2012
- process 4 64bit

* Sat Jan 28 2012 ghostbunny <hmhasse at pclinuxosusers dot de> 1.3.1-1pclos2012
- initial build
