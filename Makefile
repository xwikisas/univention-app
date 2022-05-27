
# @copyright Copyright (c) 2022 Ludovic Dubost <ludovic@xwiki.com>
#
# @author Ludovic Dubost <ludovic@xwiki.com>
#
# @license GNU AGPL app_version 3 or any later app_version
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as
# published by the Free Software Foundation, either app_version 3 of the
# License, or (at your option) any later app_version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Affero General Public License for more details
#
# You should have received a copy of the GNU Affero General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

# Based on
# @copyright Copyright (c) 2021 Arthur Schiwon <blizzz@arthur-schiwon.de>
#
# @author Arthur Schiwon <blizzz@arthur-schiwon.de>
#
# @license GNU AGPL app_version 3 or any later app_version
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as
# published by the Free Software Foundation, either app_version 3 of the
# License, or (at your option) any later app_version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Affero General Public License for more details
#
# You should have received a copy of the GNU Affero General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

app_name=xwiki
app_version=13.4.3
app_upgrade_from=13.4.3

ucs_version=4.4


.PHONY: all
all: push-files

.PHONY: add-version
add-version:
	if [ -z ${app_ver} ] ; then echo "no original app_version specified"; exit 13; fi
	if [ -z ${app_newver} ] ; then echo "no target app_version specified"; exit 13; fi
	univention-appcenter-control new-version "$(ucs_version)/$(app_name)=$(app_ver)" "$(ucs_version)/$(app_name)=$(app_newver)"

.PHONY: push-files
push-files:
	univention-appcenter-control upload --noninteractive $(ucs_version)/$(app_name)=$(app_version) \
		compose \
		configure_host \
		preinst \
		inst \
		uinst \
		i18n/en/README_EN \
		i18n/de/README_DE \
		i18n/en/README_INSTALL_EN \
		i18n/de/README_INSTALL_DE \
		i18n/en/README_POST_INSTALL_EN \
		i18n/de/README_POST_INSTALL_DE \
		i18n/en/README_UNINSTALL_EN \
		i18n/de/README_UNINSTALL_DE \
		i18n/en/README_POST_UPDATE_EN \
		i18n/de/README_POST_UPDATE_DE
		i18n/en/README_UPDATE_EN \
		i18n/de/README_UPDATE_DE
	univention-appcenter-control set --noninteractive $(ucs_version)/$(app_name)=$(app_version) \
		--json '{"WebInterface": "/xwiki/", "MinPhysicalRam": "3072", "RequiredUcsVersion": "4.4-8", "SupportedUCSVersions": "4.4-8, 5.0-0", "RequiredAppsInDomain": "openid-connect-provider"}'
