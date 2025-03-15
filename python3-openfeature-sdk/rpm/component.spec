%define pkgname @NAME@

Name: %{pkgname}
Version: @VERSION@
Release: @RELEASE@%{?dist}
Source: %{pkgname}-%{version}.tar.gz

# Example of declaration of additional sources like .service file
# just put this files in the rpm/ directory
#Source1: @NAME@
#Source2: @NAME@.conf
#Source3: @NAME@.service

URL: @URL@ 
Vendor: @MAINTAINER@
License: @LICENSE@
Group: System/Servers
Summary: @SUMMARY@ 
BuildRoot: %{_tmppath}/%{pkgname}-%{zone}-%{version}-%{release}-build
BuildArch: noarch
BuildRequires: python3-devel
BuildRequires: python3-setuptools
BuildRequires: python3-pip
BuildRequires: python3-hatchling
BuildRequires: python3-pytest
Requires: python3

%description
@DESCRIPTION@

%prep
%setup -q -n %{pkgname}-%{version}

#%generate_buildrequires
#%pyproject_buildrequires

%build
rm -rf $RPM_BUILD_ROOT
%pyproject_wheel

%install
%pyproject_install

%check
# Skip tests for now
# %{__python3} -m pytest

%clean
rm -rf $RPM_BUILD_ROOT

%files
%defattr(644, root, root, 755)
%{python3_sitelib}/*

%changelog
* Wed Feb 01 2023 @MAINTAINER@ <@MAINTAINER_EMAIL@> @VERSION@-@RELEASE@
- Package for @NAME@ version @VERSION@
