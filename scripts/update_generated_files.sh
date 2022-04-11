#!/bin/sh

bold=$(tput bold)
normal=$(tput sgr0)

printf "%s\n" "${bold}Setting .env file...${normal}"
# Parameter expansion to get the location of the script, https://bit.ly/3KM6kXj
SCRIPT_PATH=${0%/*}
cd "${SCRIPT_PATH}/.."
source .env

printf "%s\n" "${bold}Fetching translations...${normal}"
flutter pub run lang_table:generate --platform=airTable --target=Flutter --input="$I18N_AIRTABLE_ADDRESS" --api-key="$I18N_AIRTABLE_KEY"
printf "%s\n" "${bold}Done.${normal}"

printf "%s\n" "${bold}Update generated flutter files...${normal}"
flutter pub run build_runner build --delete-conflicting-outputs
flutter packages pub run gen_lang:generate --output-dir lib/i18n
printf "%s\n" "${bold}Done.${normal}"
