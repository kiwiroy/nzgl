Name:		fastq_screen
Version:	0.4.3
Release:	1%{?dist}
Summary:	Contamination screening for next-gen sequence data

Group:		Applications/Engineering
License:	GPLv3+
URL:		http://www.bioinformatics.bbsrc.ac.uk/projects/%{name}/
Source0:	http://www.bioinformatics.bbsrc.ac.uk/projects/%{name}/%{name}_v%{version}.tar.gz
Source1:	%{name}-README.Fedora
BuildRoot:	%{_tmppath}/%{name}-%{version}-%{release}-root-%(%{__id_u} -n)

Requires:	bowtie

%description

FastQ Screen provides a simple way to screen a library of short reads
against a set of reference libraries. Its most common use is as part
of a QC pipeline to confirm that a library comes from the expected
source, and to help identify any sources of contamination.

%prep
%setup -q -n %{name}_v%{version}

cp -p %{SOURCE1} .

%build


%install
rm -rf %{buildroot}

mkdir -p %{buildroot}%{_bindir}
install -m 0755 %{name} %{buildroot}%{_bindir}

mkdir -p %{buildroot}%{_sysconfdir}
install -m 0644 %{name}.conf.example %{buildroot}%{_sysconfdir}/%{name}.conf

mkdir -p %{buildroot}%{_docdir}/%{name}-%{version}
install -m 0644 %{SOURCE1} %{buildroot}%{_docdir}/%{name}-%{version}

%clean
rm -rf %{buildroot}


%files
%defattr(-,root,root,-)
%doc README.txt RELEASE_NOTES.txt fastq_screen-README.Fedora
%config(noreplace) %{_sysconfdir}/%{name}.conf
%{_bindir}/%{name}


%changelog
* Wed Jun 04 2014 Sidney Markowitz <sidney@biomatters.com> - 0.4.3-1
- Upstream release v0.4.3 fixed bug causing all reads to be written
  to the 'no hits' output file when using Bowtie2 as the aligner.
- Bowtie2 now runs with the parameters '--no-discordant' and
  '--no-mixed' when mapping paired-end reads.
- The 'nohits' output file has the file extension '.fastq' and
  is compressed if the input files are compressed.
- rpm spec change - upstream changed name of example conf file

- v0.4.2 is a minor release. The script no longer defaults to 
  Bowtie if "--aligner" is not specified.  Instead, the script checks 
  the configuration file to determine if Bowtie/Bowtie2 paths and 
  indices  have been specified. If both Bowtie and Bowtie2 indices 
  have been specified, FastqScreen then defaults to the original 
  Bowtie. The script now reports the number of reads mapping each 
  genome in addition to percentages.

* Wed Jun 26 2013 Shane Sturrock <shane@biomatters.com> - 0.4.1-1
- New upstream release

* Thu Dec 13 2012 Carl Jones <carl@biomatters.com> - 0.4-1
- New upstream release

* Fri Jul 27 2012 Carl Jones <carl@biomatters.com> - 0.3.1-1
- New upstream release

* Wed Aug 10 2011 Adam Huffman <bloch@verdurin.com> - 0.2.1-2
- add README explaining use of fastq_screen.conf

* Fri Aug  5 2011 Adam Huffman <bloch@verdurin.com> - 0.2.1-1
- initial version

