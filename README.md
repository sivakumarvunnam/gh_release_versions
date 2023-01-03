# gh_release_versions

reads a YAML file and extracts the values of the release, envs, and services keys

## Inputs

### `release_version`

**Required** Release Version

## Outputs

### `release_version`

**Required** Release Version

###
```- name: Release Versions
   uses: sivakumarvunnam/gh_release_versions@main # Uses an action in the root directory
   id: release_versions
   with:
     release_version: ${release_version}
```
