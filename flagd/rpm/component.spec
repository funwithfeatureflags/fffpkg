%define pkgname @NAME@

%global debug_package %{nil}

Name: %{pkgname}
Version: @VERSION@
Release: @RELEASE@%{?dist}

Source: %{pkgname}-%{version}.tar.gz
Source1: flagd.service
Source2: flags.json

URL: https://github.com/open-feature/flagd
Vendor: The Open Feature Authors
License: Apache License 2.0
Group: System/Servers
Summary: A feature flag daemon with a Unix philosophy
BuildRoot: %{_tmppath}/%{pkgname}-%{version}-%{release}-build
BuildRequires: golang >= 1.21
BuildRequires: systemd-rpm-macros
BuildRequires: make
Requires: systemd

%description
A feature flag daemon with a Unix philosophy

%prep
%setup -q -n %{pkgname}-%{version}

%build
export GOPROXY=proxy.golang.org
export GOSUMDB=sum.golang.org
export GO111MODULE=on
make workspace-init
go build -ldflags "-X main.version=%{version} -X main.commit=%{version} -X main.date=1970-01-00T00:01:00Z" -o ./bin/flagd ./flagd

%install
rm -rf $RPM_BUILD_ROOT
mkdir -p %{buildroot}%{_bindir}
mkdir -p %{buildroot}%{_sysconfdir}/flagd/
mkdir -p %{buildroot}%{_unitdir}/

install -m 755 bin/flagd %{buildroot}%{_bindir}/
install -m 644 %{SOURCE1} %{buildroot}%{_unitdir}/
install -m 644 %{SOURCE2} %{buildroot}%{_sysconfdir}/flagd/

%post
%systemd_post flagd.service

%preun
%systemd_preun flagd.service

%postun
%systemd_postun_with_restart flagd.service

%clean
rm -rf $RPM_BUILD_ROOT

%files
%defattr(-, root, root, -)
%{_bindir}/flagd
%{_unitdir}/flagd.service
%config(noreplace) %{_sysconfdir}/flagd/flags.json

%changelog
* Sat Mar 15 2025 @MAINTAINER@ <@MAINTAINER_EMAIL@> 0.0.1-1
- initial Version initiale
