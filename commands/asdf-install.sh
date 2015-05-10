source $(dirname $(dirname $0))/lib/utils.sh

package=$1
full_version=$2
source_path=$(get_source_path $package)
check_if_source_exists $source_path

IFS=':' read -a version_info <<< "$full_version"
if [ "${version_info[0]}" = "tag" ] || [ "${version_info[0]}" = "commit" ]
then
  install_type="${version_info[0]}"
  version="${version_info[1]}"
else
  install_type="version"
  version="${version_info[0]}"
fi

install_path=$(get_install_path $package $install_type $version)
${source_path}/bin/install $install_type $version $install_path
reshim_command $package $version